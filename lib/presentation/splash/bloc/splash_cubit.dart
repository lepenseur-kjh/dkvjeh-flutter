import 'package:dkejvh/domain/auth/usecases/is_logged_in.dart';
import 'package:dkejvh/presentation/splash/bloc/splash_state.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    var isLogin = await sl<IsLoggedInUsecase>().call();
    if (isLogin) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
