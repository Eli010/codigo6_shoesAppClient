import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class CommonPasswordWidget extends StatefulWidget {
  TextEditingController controller;
  CommonPasswordWidget({required this.controller});

  @override
  State<CommonPasswordWidget> createState() => _CommonPasswordWidgetState();
}

class _CommonPasswordWidgetState extends State<CommonPasswordWidget> {
  bool isInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        H5(
          text: "  Contraseña:",
          fontWeight: FontWeight.w500,
        ),
        spacing8,
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: isInvisible,
            decoration: InputDecoration(
              hintText: "Tu contraseña",
              hintStyle: TextStyle(
                fontSize: 14.0,
                color: BrandColor.primaryFontColor.withOpacity(0.60),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              prefixIcon: SvgPicture.asset(
                // AssetData.iconLock,
                AssetsData.iconLock,
                fit: BoxFit.scaleDown,
                color: BrandColor.primaryFontColor.withOpacity(0.50),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isInvisible
                      ? Icons.remove_red_eye_sharp
                      : Icons.remove_red_eye_outlined,
                  size: 18.0,
                  color: BrandColor.secondaryColor,
                ),
                onPressed: () {
                  isInvisible = !isInvisible;
                  setState(() {});
                  // Future.delayed(const Duration(seconds: 2), () {
                  //   isInvisible = !isInvisible;
                  //   setState(() {});
                  // });
                },
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (String? value) {
              if (value != null && value.isEmpty) {
                return "Campo obligatorio";
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
