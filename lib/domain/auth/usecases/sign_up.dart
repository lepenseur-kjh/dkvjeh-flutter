import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class SignUpUseCase extends UseCase<Either, UserSignUpCommand> {
  @override
  Future<Either> call({UserSignUpCommand? params}) async {
    return await sl<AuthRepository>().signUp(params!);
  }
}
