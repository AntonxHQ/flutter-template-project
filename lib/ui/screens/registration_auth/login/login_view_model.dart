

import 'package:antonx/core/enums/view_state.dart';
import 'package:antonx/core/models/app_user.dart';
import 'package:antonx/core/models/custom_auth_result.dart';
import 'package:antonx/core/services/auth_services.dart';
import 'package:antonx/core/services/database_services.dart';
import 'package:antonx/core/view_models/base_view_model.dart';

import '../../../locator.dart';

class LoginViewModel extends BaseViewModel{
  AppUser appUser = AppUser();
  final _authService = locator<AuthService>();
  final _dbService = DatabaseService();
  CustomAuthResult authResult;

  ///
  /// Login with Email and Password Functions
  ///

  loginWithEmailPassword() async {
    setState(ViewState.busy);
    authResult = await _authService.loginWithEmailPassword(
        email: appUser.email, password: appUser.password);
    if (authResult.status) {
//      final newToken = await FirebaseMessaging().getToken();
//      _dbService.updateFcmToken(newToken, authResult.user.uid);
//      FirebaseMessaging().subscribeToTopic('students');
      /// if true, login success
      ///      final token = await FirebaseMessaging().getToken();
      ///      _dbService.updateFcmToken(token, authResult.user.uid);
    }
    setState(ViewState.idle);
  }

  ///
  /// This method is For SignInWithGoogle
  ///
  signInWithGoogle() async{
    setState(ViewState.busy);
    try{
      authResult = await _authService.signInWithGoogle();
      if(authResult.status){
        print("Login");
      }
    }catch(e, s){
      print("@AuthViewModel signInWithGoogle Exception: $e");
      print(s);
    }
    setState(ViewState.idle);
  }
}