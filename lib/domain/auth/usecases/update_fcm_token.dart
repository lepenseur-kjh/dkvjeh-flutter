import 'package:dartz/dartz.dart';
import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/data/auth/models/update_fcm_command.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class UpdateFcmTokenUseCase extends UseCase<Either, UpdateFcmCommand> {
  @override
  Future<Either> call({UpdateFcmCommand? params}) async {
    return await sl<AuthRepository>().updateFcmToken(params!);
  }
}
