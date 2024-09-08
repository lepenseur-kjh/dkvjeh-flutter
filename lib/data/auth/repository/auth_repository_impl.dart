import 'package:dartz/dartz.dart';
import 'package:dkejvh/data/auth/models/user.dart';
import 'package:dkejvh/data/auth/models/user_sign_in_request.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';
import 'package:dkejvh/data/auth/source/auth_firebase_service.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> signUp(UserSignUpCommand command) async {
    return await sl<AuthFirebaseService>().signUp(command);
  }

  @override
  Future<Either> signIn(UserSignInRequest request) async {
    return await sl<AuthFirebaseService>().signIn(request);
  }

  @override
  Future<Either> getUser() async {
    var resp = await sl<AuthFirebaseService>().getUser();
    return resp.fold((error) {
      return Left(error);
    }, (data) {
      // Map (api) -> Model (data) -> Entity (domain)
      return Right(UserModel.fromMap(data).toEntity());
    });
  }

  @override
  Future<Either> updateFcmToken(String fcmToken) async {
    return await sl<AuthFirebaseService>().updateFcmToken(fcmToken);
  }
}
