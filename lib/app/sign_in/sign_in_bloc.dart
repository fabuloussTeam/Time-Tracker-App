import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timetrackerapp/services/auth.dart';

class SignInBloc {

  // Pour mettre a jour les fonction signInAnonymously ...
  final AuthBase auth;
  SignInBloc({@required this.auth});

  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<UserModel> _signIn(Future<UserModel> Function() signInMethod) async {
    try{
      _setIsLoading(true);
      return await signInMethod();
    } catch(e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<UserModel> signInAnonymously() async => await _signIn(Auth().signInAnonymously);

  Future<UserModel> signInWithGoogle() async => await _signIn(Auth().signInWithGoogle);

  Future<UserModel> signInWithFacebook() async => await _signIn(Auth().signInWithFacebook);
}
