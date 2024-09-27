import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void showToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16,
    fontAsset: "EastSeaDokdo",
  );
}

class SocialLogin {
  static Future<String> kakaoLogin() async {
    User user;

    try {
      user = await UserApi.instance.me();
      print('user: $user');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      showToast("에러 발생");
    }
    // 카카오 로그인 구현 예제
    OAuthToken token;

    // 카카오톡 실행 가능 여부 확인
    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공1: $token');
      } catch (error) {
        showToast("카카오계정으로 로그인 실패 $error");

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          showToast("다시 시도해주세요.");
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          showToast("카카오계정으로 로그인 실패 $error");
        }
      }

      // 사용자 정보 재요청
      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
            '\n유저: $user');

        return user.kakaoAccount!.email!;
      } catch (error) {
        showToast("사용자 정보 요청 실패");
      }
    } else {
      showToast("카카오톡을 설치해주세요.");
    }
    return "kakao-error";
  }

  static Future<String> appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      List<String> jwt = credential.identityToken?.split('.') ?? [];
      String payload = jwt[1];
      payload = base64.normalize(payload);
      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      print(userInfo);
      String email = userInfo['email'];
      print("apple email: $email");
      return email;
    } catch (e) {
      showToast("다시 시도해주세요.");
      return "apple-error";
    }
  }
}
