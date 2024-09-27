import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_app_button.dart';
import 'package:dkejvh/common/widgets/button/basic_reactive_button.dart';
import 'package:dkejvh/core/configs/assets/app_images.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/domain/budget/entities/budget.dart';
import 'package:dkejvh/domain/budget/usecases/reset_budget.dart';
import 'package:dkejvh/domain/budget/usecases/substract_budget.dart';
import 'package:dkejvh/presentation/home/bloc/budget_display_cubit.dart';
import 'package:dkejvh/presentation/home/pages/add_budget_page.dart';
import 'package:dkejvh/presentation/home/widgets/budget_alert.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: const BasicAppBar(),
        body: SafeArea(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => BudgetDisplayCubit()..displayBudget()),
              BlocProvider(create: (context) => ButtonStateCubit()),
            ],
            child: BlocBuilder<BudgetDisplayCubit, BudgetEntity?>(
              builder: (context, state) {
                if (state == null) {
                  return const CircularProgressIndicator();
                }
                return _bugdetPage(context, false, state);
              },
            ),
          ),
        ));
  }

  Widget _bugdetPage(
    BuildContext context,
    bool isLoading,
    BudgetEntity budget,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _budgetTitle(context),
          const SizedBox(height: 32),
          _bugdet(context, isLoading, budget),
          const SizedBox(height: 32),
          _progressStatus(context, budget),
          const Spacer(),
          _addButton(context, budget),
        ],
      ),
    );
  }

  Widget _budgetTitle(BuildContext context) {
    return const Text(
      "생존 가계부",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _bugdet(
    BuildContext context,
    bool isLoading,
    BudgetEntity budget,
  ) {
    if (budget.budgetStatus == BudgetStatus.pending) {
      return const Text(
        "생존 시작 버튼을 눌러 생존을 시작해보세요.\n" +
            "해당 기간동안 생활비를 아껴 써봐요.\n\n" +
            "한 번 시작한 생존은 멈출 수 없어요!\n" +
            "생존을 종료하고 싶으시다면, 생존을 임의로 진행해주세요.",
        style: TextStyle(
          fontSize: 21,
          color: Colors.black,
        ),
      );
    } else if (budget.budgetStatus == BudgetStatus.inProgress) {
      return Container(
        height: 187,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(AppImages.budgetInProgress),
                fit: BoxFit.fill),
            color: AppColors.background,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8)),
      );
    } else {
      // // budget.budgetStatus == BudgetStatus.completed
      return Container(
        height: 187,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(AppImages.budgetCompleted), fit: BoxFit.fill),
            color: AppColors.background,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8)),
      );
    }
  }

  Widget _progressStatus(
    BuildContext context,
    BudgetEntity budget,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "총 남은 금액: ${budget.livingBudget - budget.usedBudget}원 / ${budget.livingBudget}원",
          style: const TextStyle(
            fontSize: 21,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.90,
          animation: true,
          lineHeight: 30.0,
          animationDuration: 2500,
          percent: 1 - budget.remainBudgetPercent >= 0
              ? double.parse(
                  (1 - budget.remainBudgetPercent).toStringAsFixed(2))
              : 0,
          center: Text(
            "${double.parse((((1 - budget.remainBudgetPercent)) * 100).toStringAsFixed(2))}%",
            style: const TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
          barRadius: const Radius.circular(30),
          progressColor: AppColors.primary,
        ),
        const SizedBox(height: 6),
        Text(
          "생존 진행률: ${budget.passedDays}일 / ${budget.livingDays}일",
          style: const TextStyle(
            fontSize: 21,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        LinearPercentIndicator(
          width: MediaQuery.of(context).size.width * 0.90,
          animation: true,
          lineHeight: 30.0,
          animationDuration: 2500,
          percent: budget.remainDaysPercent,
          center: Text(
            "${budget.remainDaysPercent * 100}%",
            style: const TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
          barRadius: const Radius.circular(30),
          progressColor: AppColors.primary,
        ),
        const SizedBox(height: 6),
        budget.budgetStatus == BudgetStatus.completed
            ? _completedText(context, budget)
            : Text(
                "* 하루 권장 생존 금액은 ${budget.recommendedDailyBudget}원입니다.",
                style: const TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                ),
              ),
      ],
    );
  }

  Widget _completedText(
    BuildContext context,
    BudgetEntity budget,
  ) {
    int remainBudget = budget.livingBudget - budget.usedBudget;
    if (remainBudget > 0) {
      return Text(
        "* $remainBudget원 절약, 생존 성공!",
        style: const TextStyle(
          fontSize: 21,
          color: Colors.black,
        ),
      );
    } else {
      return Text(
        "* ${-remainBudget}원 과소비, 생존 실패!",
        style: const TextStyle(
          fontSize: 21,
          color: Colors.black,
        ),
      );
    }
  }

  Widget _addButton(
    BuildContext context,
    BudgetEntity budget,
  ) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Center(
        child: Builder(
          builder: (context) {
            if (budget.budgetStatus == BudgetStatus.pending) {
              return BasicAppButton(
                onPressed: () {
                  AppNavigator.push(context, AddBudgetPage());
                },
                title: "생존 시작",
              );
            } else if (budget.budgetStatus == BudgetStatus.inProgress) {
              return BasicReactiveButton(
                onPressed: () async {
                  int? result = await showDialog<int>(
                      context: context,
                      builder: (BuildContext context) => BudgetAlert());

                  if (result != null) {
                    // budgetStatus.inProgress ~ budgetStatus.completed
                    try {
                      // ignore: use_build_context_synchronously
                      await context.read<ButtonStateCubit>().execute(
                          usecase: sl<SubstractBudgetUseCase>(),
                          params: result);
                      // ignore: use_build_context_synchronously
                      context.read<BudgetDisplayCubit>().displayBudget();
                    } catch (e) {
                      var snackBar = SnackBar(
                        content: Text(e.toString()),
                        behavior: SnackBarBehavior.floating,
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    var snackBar = const SnackBar(
                      content: Text("사용 금액을 입력해주세요."),
                      behavior: SnackBarBehavior.floating,
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                title: "생존 진행",
              );
            } else {
              // budget.budgetStatus == BudgetStatus.completed
              return BasicReactiveButton(
                onPressed: () async {
                  try {
                    // ignore: use_build_context_synchronously
                    await context
                        .read<ButtonStateCubit>()
                        .execute(usecase: sl<ResetBudgetUseCase>());
                    // ignore: use_build_context_synchronously
                    context.read<BudgetDisplayCubit>().displayBudget();
                  } catch (e) {
                    var snackBar = SnackBar(
                      content: Text(e.toString()),
                      behavior: SnackBarBehavior.floating,
                    );
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                title: "탈출",
              );
            }
          },
        ),
      ),
    );
  }
}
