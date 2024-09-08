import 'package:dkejvh/domain/auth/usecases/is_logged_in.dart';
import 'package:dkejvh/domain/auth/usecases/update_fcm_token.dart';
import 'package:dkejvh/presentation/splash/bloc/splash_state.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(DisplaySplash());

  void appStarted() async {
    await Future.delayed(const Duration(seconds: 2));
    var isLogin = await sl<IsLoggedInUsecase>().call();
    if (isLogin) {
      // 로그인 시, FCM 토큰 업데이트
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      await sl<UpdateFcmTokenUseCase>().call(params: fcmToken);
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
