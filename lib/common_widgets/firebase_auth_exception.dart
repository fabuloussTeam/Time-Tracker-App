import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/common_widgets/platform_alert_dialog.dart';

class FirebaseAuthExceptionCustom extends PlatformAlertDialog {
  final String title;
  final FirebaseAuthException exception;
  FirebaseAuthExceptionCustom({ this.title, @required this.exception, }) : super(
    title: title,
    content: message(exception),
    defaultActionText: "OK"
  );

  static String message(FirebaseAuthException exception){
    //print("excep sort: $exception");
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    "account-exists-with-different-credential": "This account already exist",
    ///  - Thrown if there already exists an account with the email address
    ///    asserted by the credential.
    ///    Resolve this by calling [fetchSignInMethodsForEmail] and then asking
    ///    the user to sign in using one of the returned providers.
    ///    Once the user is signed in, the original credential can be linked to
    ///    the user with [linkWithCredential].
     "invalid-credential": "This account doen't exist",
    ///  - Thrown if the credential is malformed or has expired.
     "operation-not-allowed": "Your account is not enable. Please contact adminitrator",
    ///  - Thrown if the type of account corresponding to the credential is not
    ///    enabled. Enable the account type in the Firebase Console, under the
    ///    Auth tab.
    "user-disabled": "Your account is not active",
    ///  - Thrown if the user corresponding to the given credential has been
    ///    disabled.
    "user-not-found": "Another user corresponding to this given email",
    ///  - Thrown if signing in with a credential from [EmailAuthProvider.credential]
    ///    and there is no user corresponding to the given email.
    "wrong-password": "You have enter a wrong password, Please retry!",
    ///  - Thrown if signing in with a credential from [EmailAuthProvider.credential]
    ///    and the password is invalid for the given email, or if the account
    ///    corresponding to the email does not have a password set.
    /// - **invalid-verification-code**:
    ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
    ///    verification code of the credential is not valid.
    /// - **invalid-verification-id**:
    ///  - Thrown if the credential is a [PhoneAuthProvider.credential] and the
    ///    verification ID of the credential is not valid.id.
    "email-already-in-use": "This email is already use",
    ///  - Thrown if there already exists an account with the given email address.
   "invalid-email": "Valuer enter is not a valid email",
   ///  - Thrown if the email address is not valid.
     "operation-not-allowed": "Your account is not enable yet.",
    ///  - Thrown if email/password accounts are not enabled. Enable
     ///    email/password accounts in the Firebase Console, under the Auth tab.
   "weak-password": "You password is not strong enough. Should be at least 6 characters",
   ///  - Thrown if the password is not strong enough.
  };

}