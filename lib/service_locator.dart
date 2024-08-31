import 'package:dkejvh/data/auth/repository/auth_repository_impl.dart';
import 'package:dkejvh/data/auth/source/auth_firebase_service.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/domain/auth/usecases/get_user.dart';
import 'package:dkejvh/domain/auth/usecases/is_logged_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_up.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  // Service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  // UseCase
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
}
