import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/presentation/home/pages/budget_page.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const BudgetPage());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 232,
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _budgetTitle(),
            const SizedBox(height: 15),
            _budgetComment(),
            const SizedBox(height: 4),
            _budgetText(),
          ],
        ),
      ),
    );
  }

  Widget _budgetTitle() {
    return const Text(
      "생존 가계부",
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
      "1. 생존 일수, 생존 금액 설정\n" + "2. 생존 진행하기\n" + "3. 목표 달성",
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
