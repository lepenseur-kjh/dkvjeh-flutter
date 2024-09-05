import 'package:flutter/material.dart';

class AppNavigator {
  // 현재 페이지를 새로운 페이지로 대체
  // 이전 페이지는 스택에서 제거되어 뒤로 가기 버튼으로 돌아갈 수 없다.
  static void pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
  }

  // 새로운 페이지를 네이게이션 스택의 맨 위에 추가
  // 이전 페이지는 스택에 남아있어 뒤로 가기 버튼으로 돌아갈 수 있다.
  static void push(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  // 새로운 페이지를 추가하고, 조건에 맞는 페이지까지 스택의 페이지들을 제거
  // 특정 조건을 만족할 때까지 스택의 페이지들을 제거할 수 있어 유연
  static void pushAndRemove(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      // (Route<dynamic> route) => false, // 모든 이전 루트 제거
      (Route<dynamic> route) => route.isFirst, // 첫 번째 (홈) 빼고 모두 제거
    );
  }
}
