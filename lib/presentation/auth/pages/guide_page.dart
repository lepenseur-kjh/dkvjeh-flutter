import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/presentation/auth/pages/sign_in_page.dart';
import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(
        hideBack: true,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _guideTitle(context),
              const SizedBox(height: 32),
              _guideText(context),
              const Spacer(),
              _finishButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _guideTitle(BuildContext context) {
    return const Text(
      "서비스 이용 방법",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _guideText(BuildContext context) {
    return const Text(
      "회원가입이 완료되었습니다.\n" +
          "'돌아가기' 버튼을 눌러 메인화면으로 이동해주세요.\n" +
          "방금 누르셨던 로그인 버튼을 클릭해주세요.",
      style: TextStyle(
        fontSize: 21,
        color: Colors.black,
      ),
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.background,
      child: Center(
        child: BasicAppButton(
          onPressed: () {
            AppNavigator.pushReplacement(context, const SignInPage());
          },
          title: "돌아가기",
        ),
      ),
    );
  }
}
