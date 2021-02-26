class AuthExceptionsService {
  static generateExceptionMessage(e) {
    print(e.code);
    String errorMessage;
    switch (e.code) {
      case "email-already-in-use":
        errorMessage =
        "The email has already been registered. Please login or reset your password.";
        break;
      case "invalid-email":
        errorMessage = "Your email address appears to be malformed.";
        break;
      case "weak-password":
        errorMessage =
        "Your password is very weak. Please try a strong password.";
        break;
      case "wrong-password":
        errorMessage = "Your password is wrong.";
        break;
      case "user-not-found":
        errorMessage = "User with this email doesn't exist.";
        break;
      case "user-disabled":
        errorMessage = "User with this email has been disabled.";
        break;
      case "operation-not-allowed":
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;

    //Todo: Handle no internet exception as well.

      default:
        errorMessage = "An undefined Error happened.";
    }
    return errorMessage;
  }
}
