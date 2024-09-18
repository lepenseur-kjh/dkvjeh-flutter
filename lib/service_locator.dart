import 'package:dkejvh/data/auth/repository/auth_repository_impl.dart';
import 'package:dkejvh/data/auth/source/auth_firebase_service.dart';
import 'package:dkejvh/data/budget/repository/budget_repository_impl.dart';
import 'package:dkejvh/data/budget/source/budget_local_service.dart';
import 'package:dkejvh/data/schedule/repository/schedule_repository_impl.dart';
import 'package:dkejvh/data/schedule/source/schedule_firebase_service.dart';
import 'package:dkejvh/domain/auth/repository/auth_repository.dart';
import 'package:dkejvh/domain/auth/usecases/get_user.dart';
import 'package:dkejvh/domain/auth/usecases/is_logged_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_in.dart';
import 'package:dkejvh/domain/auth/usecases/sign_up.dart';
import 'package:dkejvh/domain/auth/usecases/update_fcm_token.dart';
import 'package:dkejvh/domain/budget/repository/budget_repository.dart';
import 'package:dkejvh/domain/budget/usecases/add_budget.dart';
import 'package:dkejvh/domain/schedule/repository/schedule_repository.dart';
import 'package:dkejvh/domain/schedule/usecases/add_schedule.dart';
import 'package:dkejvh/domain/schedule/usecases/get_schedules.dart';
import 'package:dkejvh/domain/schedule/usecases/remove_schedule.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<ScheduleRepository>(ScheduleRepositoryImpl());
  sl.registerSingleton<BudgetRepository>(BudgetRepositoryImpl());

  // Service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<ScheduleFirebaseService>(ScheduleFirebaseServiceImpl());
  sl.registerSingleton<BudgetLocalService>(BudgetLocalServiceImpl());

  // UseCase
  sl.registerSingleton<IsLoggedInUsecase>(IsLoggedInUsecase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());
  sl.registerSingleton<AddScheduleUseCase>(AddScheduleUseCase());
  sl.registerSingleton<GetSchedulesUseCase>(GetSchedulesUseCase());
  sl.registerSingleton<RemoveScheduleUseCase>(RemoveScheduleUseCase());
  sl.registerSingleton<UpdateFcmTokenUseCase>(UpdateFcmTokenUseCase());
  sl.registerSingleton<AddBudgetUsecase>(AddBudgetUsecase());
}
