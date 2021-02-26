import 'package:antonx/core/models/app_user.dart';
import 'package:antonx/core/models/custom_auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_exceptions_services.dart';
import 'database_services.dart';

class AuthService {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  User user;
  bool isLogin;
  AppUser appUser;

  AuthService() {
    init();
  }

  init() async {
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;
//      patient = await _dbService.getPatient(user.uid);
    } else {
      isLogin = false;
    }
  }

  updateUserProfile(AppUser user) {
    _dbService.updateUserProfile(user);
  }

  Future<CustomAuthResult> signUpWithEmailPassword(AppUser user) async {
    print('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      /// If user login fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        user.id = credentials.user.uid;

        await _dbService.registerUser(user);
        this.appUser = user;
      }
    } catch (e) {
      print('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  Future<CustomAuthResult> loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      /// Check if there is a user account associated with
      /// this uid in the database.
      /// If yes, then proceed to the auth success otherwise
      /// logout the user and generate an error for the user.
      ///
      if (credentials.user != null) {
//        final user = await _dbService.getVendorData(credentials.user.uid);
//        if (user == null) {
//          customAuthResult.status = false;
//          await logout();
//          customAuthResult.errorMessage =
//              "You don't have a Vendor account. Please create one and then proceed to login.";
//          return customAuthResult;
//        }
        this.appUser = await _dbService.getUser(credentials.user.uid);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }



  ///
  /// This Function is for Sign With Google
  ///
  Future<CustomAuthResult> signInWithGoogle() async{
    print("@signInWithGoogle");

    try{
      final GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();

      if(googleSignInAccount != null){
        appUser.email = googleSignInAccount.email;
        appUser.name = googleSignInAccount.displayName;
        appUser.imageUrl = googleSignInAccount.photoUrl;
      }else{
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'You have Cancelled Google Sign';
        return customAuthResult;
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );



      final credentials = await _auth.signInWithCredential(googleAuthCredential);

      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      print("User Credential Id" + credentials.user.uid);
      appUser.id = credentials.user.uid;


      ///
      /// Check is user is new one then add user data to firebase user Collection
      ///
      if(credentials.additionalUserInfo.isNewUser){
        await _dbService.registerUser(appUser);
      }

    }catch(e, s){
      customAuthResult.status = false;
      customAuthResult.errorMessage = AuthExceptionsService.generateExceptionMessage(e);
      print("GoogleSignAccount");
      print(e);
      print(s);
    }
    return customAuthResult;
  }



  ///
  /// This Function for to login With Facebook
  ///
  Future<CustomAuthResult> signInWithFacebook() async{
    print("@AuthService signInWithFacebook");
    try{
      final AccessToken accessToken = await FacebookAuth.instance.login();

      final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(accessToken.token);

      if(accessToken != null){
        final userData = await FacebookAuth.instance.getUserData();
        appUser.email = userData["email"];
        appUser.name = userData["name"];
        appUser.imageUrl = userData["picture"]["data"]["url"];
      }



      final credentials = await _auth.signInWithCredential(facebookAuthCredential);

      if (credentials.user == null) {
        customAuthResult.status = false;
//        customAuthResult.errorCode = "Undefined";
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }
      print("User Credential Id" + credentials.user.uid);
      appUser.id = credentials.user.uid;

      ///
      /// Check is user is new one then add user data to firebase user Collection
      ///
      if(credentials.additionalUserInfo.isNewUser){
        await _dbService.registerUser(appUser); }

      print("After ---------------");
      print(credentials.user.uid);
      print(credentials.user.email);

    }on FacebookAuthException catch(e){
      customAuthResult.status = false;
//      customAuthResult.errorCode =  e.errorCode;
      customAuthResult.errorMessage = AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }


  Future<void> logout({id}) async {
//    if (id != null) FirebaseDatabaseService().updateFcmToken(null, id);
    await _auth.signOut();
    this.isLogin = false;
    this.appUser = null;
    this.user = null;
  }

//  @override
  void resetPassword(String email) {
    try {
      _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Exception @FirebaseAuthService/resetPassword: $e');
    }
  }
}
