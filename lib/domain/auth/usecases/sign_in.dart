import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/data/auth/models/user_sign_in_request.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class SignInUseCase extends UseCase<Either, UserSignInRequest> {
  @override
  Future<Either> call({UserSignInRequest? params}) async {
    return await sl<AuthRepository>().signIn(params!);
  }
}
