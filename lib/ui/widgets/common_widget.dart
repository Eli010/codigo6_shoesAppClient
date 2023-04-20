import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';

SizedBox spacing2 = const SizedBox(height: 2);
SizedBox spacing4 = const SizedBox(height: 4);
SizedBox spacing8 = const SizedBox(height: 8);
SizedBox spacing12 = const SizedBox(height: 12);
SizedBox spacing16 = const SizedBox(height: 16);
SizedBox spacing20 = const SizedBox(height: 20);
SizedBox spacing30 = const SizedBox(height: 30);
SizedBox spacing40 = const SizedBox(height: 40);

SizedBox spacing4With = const SizedBox(width: 4);
SizedBox spacing8With = const SizedBox(width: 8);
SizedBox spacing12With = const SizedBox(width: 12);
SizedBox spacing16With = const SizedBox(width: 16);
SizedBox spacing20With = const SizedBox(width: 20);
SizedBox spacing30With = const SizedBox(width: 30);
SizedBox spacing40With = const SizedBox(width: 40);

Center loadingWidget = const Center(
  child: SizedBox(
    width: 20,
    height: 20,
    child: CupertinoActivityIndicator(
      radius: 7,
      color: BrandColor.primaryColor,
    ),
  ),
);

SnackBar snackBarError(String message) => SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Color(0xffED3949),
      content: Row(
        children: [
          Expanded(
            child: H5(
              text: message,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
