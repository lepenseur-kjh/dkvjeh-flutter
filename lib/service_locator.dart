import 'package:dkejvh/data/auth/repository/auth_repository_impl.dart';
import 'package:dkejvh/data/auth/source/auth_firebase_service.dart';
import 'package:dkejvh/data/schedule/repository/schedule_repository_impl.dart';
import 'package:dkejvh/data/schedule/source/schedule_firebase_service.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/domain/auth/usecases/get_user.dart';
import 'package:dkejvh/domain/auth/usecases/is_logged_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_up.dart';
import 'package:dkejvh/domain/schedule/repository/schedule_repository.dart';
import 'package:dkejvh/domain/schedule/usecases/add_schedule.dart';
import 'package:dkejvh/domain/schedule/usecases/get_schedules.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<ScheduleRepository>(ScheduleRepositoryImpl());

  // Service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<ScheduleFirebaseService>(ScheduleFirebaseServiceImpl());

  // UseCase
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
  sl.registerSingleton<AddScheduleUseCase>(AddScheduleUseCase());
  sl.registerSingleton<GetSchedulesUseCase>(GetSchedulesUseCase());
}
