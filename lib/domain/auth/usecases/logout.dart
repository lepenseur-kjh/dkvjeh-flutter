import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class LogoutUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().logout();
  }
}
