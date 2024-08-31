import 'package:dkejvh/common/bloc/button_state.dart';
import 'package:dkejvh/common/bloc/button_state_cubit.dart';
import 'package:dkejvh/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicReactiveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final Widget? content;
  final String? svgIcon;
  const BasicReactiveButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.content,
      this.svgIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
        builder: (context, state) {
      if (state is ButtonLoadingState) {
        return _loading();
      }
      return _initial();
    });
  }

  Widget _loading() {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height ?? 53),
        ),
        child: Container(
            height: height ?? 53,
            alignment: Alignment.center,
            child: const CircularProgressIndicator()));
  }

  Widget _initial() {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          minimumSize: Size.fromHeight(height ?? 53),
        ),
        child: svgIcon == null
            ? content ??
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: "EastSeaDokdo",
                    color: Colors.white,
                    fontSize: 21,
                  ),
                )
            : Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SvgPicture.asset(svgIcon!), // SVG 파일 경로
                const SizedBox(width: 96), // 아이콘과 텍스트 사이의 간격
                content ??
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: "EastSeaDokdo",
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
              ]));
  }
}
