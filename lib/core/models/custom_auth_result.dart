import 'package:firebase_auth/firebase_auth.dart';

class CustomAuthResult{
  bool status;
  String errorMessage;
  User user;

  CustomAuthResult({this.status, this.errorMessage, this.user});
}