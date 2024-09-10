import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/auth/models/update_fcm_command.dart';
import 'package:dkejvh/data/auth/models/user_sign_in_request.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<Either> signUp(UserSignUpCommand command);
  Future<Either> signIn(UserSignInRequest request);
  Future<Either> getUser();
  Future<Either> updateFcmToken(UpdateFcmCommand command);
}
