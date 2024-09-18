import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_reactive_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/data/budget/models/add_budget_command.dart';
import 'package:dkejvh/domain/budget/usecases/add_budget.dart';
import 'package:dkejvh/presentation/home/pages/budget_page.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBudgetPage extends StatelessWidget {
  AddBudgetPage({super.key});

  final TextEditingController _livingDaysCon = TextEditingController();
  final TextEditingController _livingBudgetCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(),
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
              AppNavigator.pushAndRemove(context, const BudgetPage());
            }
          },
          child: SafeArea(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.sizeOf(context).width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _budgetTitle(context),
                  const SizedBox(height: 32),
                  _budgetLivingDays(context),
                  const SizedBox(height: 20),
                  _budgetLivingBudget(context),
                  const Spacer(),
                  _finishButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _budgetTitle(BuildContext context) {
    return const Text(
      "생존 설정",
      style: TextStyle(
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _budgetLivingDays(BuildContext context) {
    return TextField(
      controller: _livingDaysCon,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: "생존 일수를 입력해주세요. (예: 10)"),
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _budgetLivingBudget(BuildContext context) {
    return TextField(
      controller: _livingBudgetCon,
      keyboardType: TextInputType.number,
      decoration:
          const InputDecoration(hintText: "생존 금액을 입력해주세요. (예: 1000000)"),
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Center(
        child: Builder(
          builder: (context) {
            return BasicReactiveButton(
              onPressed: () {
                context.read<ButtonStateCubit>().execute(
                    usecase: sl<AddBudgetUsecase>(),
                    params: AddBudgetCommand(
                      livingDays: int.parse(_livingDaysCon.text),
                      livingBudget: int.parse(_livingBudgetCon.text),
                    ));
              },
              title: "등록",
            );
          },
        ),
      ),
    );
  }
}
