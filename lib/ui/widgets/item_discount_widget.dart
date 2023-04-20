import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';

class ItemDiscountWidget extends StatelessWidget {
  final int discount;

  const ItemDiscountWidget({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(7.0),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: BrandColor.primaryColor,
      ),
      child: H5(
        text: "-$discount %",
        color: BrandColor.primaryFontColor.withOpacity(0.5),
      ),
    );
  }
}
