import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/presentation/home/pages/add_schedule_page.dart';
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _scheduleTitle(context),
              const SizedBox(height: 32),
              _scheduleText(context),
            ],
          ),
        ),
        const Spacer(),
        _addButton(context),
      ]),
    );
  }

  Widget _scheduleTitle(BuildContext context) {
    return const Text(
      "일정 관리",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _scheduleText(BuildContext context) {
    return const Text(
      "꼭 기억해야 할 일을 등록해보세요. (최대 3개)\n" +
          "잊어버리지 않도록 마감일 전까지 푸시 알림을 발송해드립니다.\n\n" +
          "일정을 수정해야 하는 경우,\n" +
          "일정 삭제 후, 다시 등록해주세요.",
      style: TextStyle(
        fontSize: 21,
        color: Colors.black,
      ),
    );
  }

  Widget _addButton(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Center(
        child: Builder(builder: (context) {
          return BasicAppButton(
            onPressed: () {
              AppNavigator.push(context, AddSchedulePage());
            },
            title: "일정 등록",
          );
        }),
      ),
    );
  }
}
