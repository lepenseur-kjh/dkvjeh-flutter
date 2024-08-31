import 'package:dkejvh/core/usecase/usecase.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/service_locator.dart';

class IsLoggedInUsecase extends UseCase<bool, dynamic> {
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
}
