import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';

class CommonButtonWidget extends StatelessWidget {
  String text;
  Color color;
  String? icon;
  VoidCallback onPressed;
  CommonButtonWidget({
    required this.text,
    required this.color,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.0,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? SvgPicture.asset(
                icon!,
                color: Colors.white,
              )
            : const SizedBox(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        label: H5(
          text: text,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
