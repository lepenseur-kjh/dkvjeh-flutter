import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/common/helper/navigator/app_navigator.dart';
import 'package:dkejvh/common/widgets/appbar/app_bar.dart';
import 'package:dkejvh/common/widgets/button/basic_reactive_button.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:dkejvh/data/auth/models/user_sign_up_command.dart';
import 'package:dkejvh/domain/auth/usecases/sign_up.dart';
import 'package:dkejvh/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:dkejvh/presentation/auth/pages/guide_page.dart';
import 'package:dkejvh/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputUserinfoPage extends StatelessWidget {
  final UserSignUpCommand command;
  InputUserinfoPage({
    required this.command,
    super.key,
  });

  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _birthDateTextCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const BasicAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GenderSelectionCubit()),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
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
              AppNavigator.pushAndRemove(context, const GuidePage());
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
                  _signUpText(context),
                  const SizedBox(height: 32),
                  _usernameText(context),
                  const SizedBox(height: 20),
                  _birthDateText(context),
                  const SizedBox(height: 20),
                  _genders(context),
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

  Widget _signUpText(BuildContext context) {
    return const Text(
      "회원가입",
      style: TextStyle(
        fontFamily: "EastSeaDokdo",
        fontSize: 44,
        color: Colors.black,
      ),
    );
  }

  Widget _usernameText(BuildContext context) {
    return TextField(
      controller: _usernameCon,
      decoration: const InputDecoration(hintText: "이름 또는 닉네임 (예: 신짱구)"),
      style: const TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }

  Widget _birthDateText(BuildContext context) {
    return TextField(
        controller: _birthDateTextCon,
        keyboardType: TextInputType.datetime,
        decoration: const InputDecoration(hintText: "생년월일 (예: 2024/08/31)"),
        style: const TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(DateTime.now().year + 1),
          );
          if (pickedDate != null) {
            _birthDateTextCon.text =
                "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
          }
        });
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderTitle(context, 0, "남"),
            const SizedBox(width: 20),
            genderTitle(context, 1, "여"),
          ],
        );
      },
    );
  }

  Expanded genderTitle(BuildContext context, int genderIndex, String gender) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectGender(genderIndex);
        },
        child: Container(
          height: 53,
          decoration: BoxDecoration(
            color: context.read<GenderSelectionCubit>().selectedIndex ==
                    genderIndex
                ? AppColors.primary
                : AppColors.secondBackground,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 21,
                color: context.read<GenderSelectionCubit>().selectedIndex ==
                        genderIndex
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ),
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
                // request body 설정
                command.username = _usernameCon.text;
                command.birthDate = _birthDateTextCon.text;
                command.gender =
                    context.read<GenderSelectionCubit>().selectedIndex;
                command.createdAt = DateTime.now();
                // request body 설정
                context.read<ButtonStateCubit>().execute(
                      usecase: sl<SignUpUseCase>(),
                      params: command,
                    );
              },
              title: "완료",
            );
          },
        ),
      ),
    );
  }
}
