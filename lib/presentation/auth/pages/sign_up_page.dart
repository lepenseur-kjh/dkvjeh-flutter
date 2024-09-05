import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';
import 'package:dkejvh/presentation/auth/pages/input_userinfo_page.dart';
import 'package:dkejvh/social_login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(),
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _signUpTitle(context),
              const SizedBox(height: 32),
              _welcomeText(context),
              const SizedBox(height: 72),
              _kakaoButton(context),
              const SizedBox(height: 20),
              _appleButton(context),
              const SizedBox(height: 20),
              _termText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpTitle(BuildContext context) {
    return const Text(
      "회원가입",
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
          return BasicAppButton(
            onPressed: () async {
              AppNavigator.push(
                // ignore: use_build_context_synchronously
                context,
                InputUserinfoPage(
                  command: UserSignUpCommand(
                    email: await SocialLogin.kakaoLogin(),
                    password: dotenv.env["PW"]!,
                    socialType: "kakao",
                  ),
                ),
              );
            },
            title: "카카오로 시작하기",
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
          return BasicAppButton(
            onPressed: () async {
              AppNavigator.push(
                // ignore: use_build_context_synchronously
                context,
                InputUserinfoPage(
                  command: UserSignUpCommand(
                    email: await SocialLogin.appleLogin(),
                    password: dotenv.env["PW"]!,
                    socialType: "apple",
                  ),
                ),
              );
            },
            title: "애플로 시작하기",
            svgIcon: "assets/vectors/applelogo.svg",
          );
        }),
      ),
    );
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
              // TODO: Notion WebView
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
