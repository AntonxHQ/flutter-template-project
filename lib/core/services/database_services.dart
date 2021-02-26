import 'package:antonx/core/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final _db = FirebaseFirestore.instance;
  static final DatabaseService _singleton = DatabaseService._internal();

  factory DatabaseService() {
    return _singleton;
  }

  DatabaseService._internal();

  ///
  /// Register User
  ///
  registerUser(AppUser user) async {
    print(user.id + "ID is-------");
    try {
      await _db
          .collection('reg_user')
          .doc(user.id)
          .set(user.toJson());
    } catch (e, s) {
      print('Exception @DatabaseService/registerPatient $e');
//      print(s);
    }
  }

  ///
  /// Get User
  ///
  Future<AppUser> getUser(id) async {
    print('@getUser: id: $id');
    try {
      final snapshot = await _db.collection('reg_user').doc(id).get();
      print('User Data: ${snapshot.data()}');
      return AppUser.fromJson(snapshot.data(), snapshot.id);
    } catch (e, s) {
      print('Exception @DatabaseService/getUser $e');
//      print(s);
      return null;
    }
  }

  ///
  /// Update User Profile
  updateUserProfile(AppUser appUser) async {
    print('@updateUserProfile: ${appUser.id}');
    await _db
        .collection('reg_user')
        .doc(appUser.id)
        .update(appUser.toJson());
  }


}