import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 관리
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 232,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _budgetTitle(),
              const SizedBox(height: 20),
              _budgetComment(),
              const SizedBox(height: 4),
              _budgetText(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _budgetTitle() {
    return const Text(
      "만원의 행복",
      style: TextStyle(
        fontSize: 31,
        color: Colors.white,
      ),
    );
  }

  Widget _budgetComment() {
    return const Text(
      "* 생활비를 아껴 써봐요!",
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _budgetText() {
    return const Text(
      "1. 하루 사용 금액 설정\n" + "2. 사용 금액 차감하기\n" + "3. 목표 달성",
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
