import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final String? svgIcon;
  const BasicAppButton(
      {required this.onPressed,
      this.title = '',
      this.height,
      this.width,
      this.content,
      this.svgIcon,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 53),
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
