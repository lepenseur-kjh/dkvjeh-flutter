import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/core/configs/assets/app_vectors.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/presentation/auth/pages/sign_in_page.dart';
import 'package:dkejvh/presentation/splash/bloc/splash_cubit.dart';
import 'package:dkejvh/presentation/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/pages/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          // TODO: sign_in 페이지를 둬야 하는가?
          // firebase auth를 사용했을 때, 로그아웃을 구현하는 게 아니라면
          // 이 두 페이지를 나눌 필요가 없다.
          AppNavigator.pushReplacement(context, const SignInPage());
        }
        if (state is Authenticated) {
          AppNavigator.pushReplacement(context, const HomePage());
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: SvgPicture.asset(AppVectors.appLogo),
        ),
      ),
    );
  }
}
