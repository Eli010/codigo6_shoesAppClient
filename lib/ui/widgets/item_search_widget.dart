import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/product_detail_page.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_discount_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/calculate.dart';

class ItemSearchWidget extends StatelessWidget {
  final ProductModel productModel;

  const ItemSearchWidget({super.key, required this.productModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(productModel: productModel),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: BrandColor.primaryFontColor.withOpacity(0.09),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image,
                    height: 90.0,
                    width: 105,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        AssetsData.placeHolder,
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return loadingWidget;
                    },
                  ),
                ),
                spacing12With,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      H6(
                        text: productModel.brand,
                        color: BrandColor.primaryFontColor.withOpacity(0.55),
                      ),
                      spacing2,
                      H5(
                        text: productModel.name,
                        height: 1.1,
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      spacing4,
                      Row(
                        children: [
                          H5(
                            text:
                                "S/ ${Calculate.getPrice(productModel.price, productModel.discount).toStringAsFixed(2)}",
                            // "S/. 261",
                            fontWeight: FontWeight.w700,
                          ),
                          spacing8With,
                          productModel.discount > 0
                              ? H6(
                                  text:
                                      "S/ ${productModel.price.toStringAsFixed(2)}",
                                  // text: "S/. 256",
                                  color: BrandColor.primaryFontColor
                                      .withOpacity(0.55),
                                  textDecoration: TextDecoration.lineThrough,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: productModel.discount > 0
                  ? ItemDiscountWidget(
                      discount: productModel.discount,
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
