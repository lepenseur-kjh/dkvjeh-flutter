import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_reactive_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/data/auth/models/user_sign_in_request.dart';
import 'package:dkejvh/domain/auth/usecases/sign_in.dart';
import 'package:dkejvh/presentation/auth/pages/sign_up_page.dart';
import 'package:dkejvh/presentation/home/pages/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dkejvh/social_login.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(
        hideBack: true,
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(
                content: Text(state.errorMsg),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            if (state is ButtonSuccessState) {
              AppNavigator.pushAndRemove(context, const HomePage());
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _welcomeTitle(context),
                    const SizedBox(height: 32),
                    _welcomeText(context),
                    const SizedBox(height: 72),
                    _kakaoButton(context),
                    const SizedBox(height: 20),
                    _appleButton(context),
                    const SizedBox(height: 20),
                    _signUpText(context),
                    const SizedBox(height: 20),
                    _termText(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeTitle(BuildContext context) {
    return const Text(
      "환영합니다.",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _welcomeText(BuildContext context) {
    return const Text(
      "안녕하세요, 개발자 'kjh'입니다.\n" +
          "일상 속에서 유용하게 사용 가능한 기능을\n" +
          "팝업스토어처럼 제공할 수 있는 서비스를 만들어 가겠습니다.",
      style: TextStyle(
        fontSize: 21,
        color: Colors.black,
      ),
    );
  }

  Widget _kakaoButton(BuildContext context) {
    return Container(
      height: 49,
      color: Colors.white,
      child: Center(
        child: Builder(builder: (context) {
          return BasicReactiveButton(
            onPressed: () async {
              context.read<ButtonStateCubit>().execute(
                  usecase: SignInUseCase(),
                  params: UserSignInRequest(
                    email: await SocialLogin.kakaoLogin(),
                    password: dotenv.env["PW"]!,
                  ));
            },
            title: "카카오 로그인",
            svgIcon: "assets/vectors/kakaologo.svg",
          );
        }),
      ),
    );
  }

  Widget _appleButton(BuildContext context) {
    return Container(
      height: 49,
      color: Colors.white,
      child: Center(
        child: Builder(builder: (context) {
          return BasicReactiveButton(
            onPressed: () async {
              context.read<ButtonStateCubit>().execute(
                  usecase: SignInUseCase(),
                  params: UserSignInRequest(
                    email: await SocialLogin.appleLogin(),
                    password: dotenv.env["PW"]!,
                  ));
            },
            title: "애플 로그인",
            svgIcon: "assets/vectors/applelogo.svg",
          );
        }),
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "회원가입이 필요하신가요? ",
          style: TextStyle(
            fontFamily: "EastSeaDokdo",
            fontSize: 17,
            color: Colors.black,
          )),
      TextSpan(
          text: "(클릭)",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              AppNavigator.push(context, const SignUpPage());
            },
          style: const TextStyle(
            fontFamily: "EastSeaDokdo",
            fontSize: 17,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ))
    ]));
  }

  Widget _termText(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          text: "서비스 이용약관 및 개인정보처리방침을 확인해주세요. ",
          style: TextStyle(
            fontFamily: "EastSeaDokdo",
            fontSize: 17,
            color: Colors.black,
          )),
      TextSpan(
          text: "(클릭)",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // TODO: 웹뷰 (노션)
            },
          style: const TextStyle(
            fontFamily: "EastSeaDokdo",
            fontSize: 17,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ))
    ]));
  }
}
