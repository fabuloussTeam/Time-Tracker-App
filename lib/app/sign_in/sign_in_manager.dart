import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/services/auth.dart';

class SignInManager {

  // Pour mettre a jour les fonction signInAnonymously ...
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  SignInManager({@required this.auth, @required this.isLoading});

  Future<UserModel> _signIn(Future<UserModel> Function() signInMethod) async {
    try{
      isLoading.value = true;
      return await signInMethod();
    } catch(e) {
      rethrow;
    } finally {
     isLoading.value = false;
    }
  }

  Future<UserModel> signInAnonymously() async => await _signIn(Auth().signInAnonymously);

  Future<UserModel> signInWithGoogle() async => await _signIn(Auth().signInWithGoogle);

  Future<UserModel> signInWithFacebook() async => await _signIn(Auth().signInWithFacebook);
}
