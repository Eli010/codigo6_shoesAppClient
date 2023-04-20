import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';

class ItemSizeWidget extends StatelessWidget {
  final double size;
  const ItemSizeWidget({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1.8,
          color: BrandColor.primaryFontColor.withOpacity(0.30),
        ),
      ),
      alignment: Alignment.center,
      child: H5(
        text: size.toString(),
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
