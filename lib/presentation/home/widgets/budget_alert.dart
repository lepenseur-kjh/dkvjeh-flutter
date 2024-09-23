import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BudgetAlert extends StatelessWidget {
  final TextEditingController _useBudgetCon = TextEditingController();

  BudgetAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.background,
      title: const Center(
        child: Text(
          '오늘 사용한 금액을 입력하세요.',
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center, // 상하
        crossAxisAlignment: CrossAxisAlignment.start, // 좌우
        children: [
          const Text(
            '* 오늘 하루 생존에 성공하셨습니다.',
            style: TextStyle(
              fontSize: 21,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _useBudgetCon,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '예: 10000'),
            style: const TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 값 입력 없이 완료 버튼 누를 때, 방지
                  int useBudget = _useBudgetCon.text.isNotEmpty
                      ? int.parse(_useBudgetCon.text)
                      : 0;
                  Navigator.of(context).pop(useBudget);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size.fromHeight(53),
                ),
                child: const Text(
                  "완료",
                  style: TextStyle(
                    fontFamily: "EastSeaDokdo",
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
