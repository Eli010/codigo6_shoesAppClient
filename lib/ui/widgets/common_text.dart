import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';

class BaseText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final double? height;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecoration;
  const BaseText({
    super.key,
    required this.text,
    required this.fontSize,
    this.color,
    this.fontWeight,
    this.height,
    this.maxLines,
    this.textOverflow,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      style: TextStyle(
        overflow: textOverflow,
        fontSize: fontSize,
        color: color ?? BrandColor.primaryFontColor,
        fontWeight: fontWeight,
        height: height,
        decoration: textDecoration,
      ),
    );
  }
}

class H1 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;

  const H1({super.key, required this.text, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 28,
      color: color,
      fontWeight: FontWeight.w700,
      height: height,
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final FontWeight? fontWeight;

  const H2({
    super.key,
    required this.text,
    this.color,
    this.height,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 24,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: height,
    );
  }
}

class H3 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;

  const H3({super.key, required this.text, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 21,
      color: color,
      fontWeight: FontWeight.w500,
      height: height,
    );
  }
}

class H4 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final FontWeight? fontWeight;

  const H4(
      {super.key,
      required this.text,
      this.color,
      this.height,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 18,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w500,
      height: height,
    );
  }
}

class H5 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;

  const H5(
      {super.key,
      required this.text,
      this.color,
      this.height,
      this.maxLines,
      this.textOverflow,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      maxLines: maxLines,
      text: text,
      fontSize: 14,
      color: color,
      fontWeight: fontWeight,
      height: height,
      textOverflow: textOverflow,
    );
  }
}

class H6 extends StatelessWidget {
  final String text;
  final Color? color;
  final double? height;
  final TextDecoration? textDecoration;
  const H6(
      {super.key,
      required this.text,
      this.color,
      this.height,
      this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 12,
      color: color,
      fontWeight: FontWeight.w500,
      height: height,
      textDecoration: textDecoration,
    );
  }
}
