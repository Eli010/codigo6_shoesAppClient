import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/product_detail_page.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_discount_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class ItemProductWidget extends StatelessWidget {
  final ProductModel productModel;

  const ItemProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    double price = productModel.price;
    if (productModel.discount > 0) {
      price = price - (productModel.price * productModel.discount / 100);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailPage(productModel: productModel),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: productModel.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, url, error) {
                        return Image.asset(AssetsData.placeHolder);
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return loadingWidget;
                      },
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: productModel.discount > 0
                          ? ItemDiscountWidget(discount: productModel.discount)
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spacing4,
                  H6(
                    text: productModel.brand,
                    color: BrandColor.primaryFontColor.withOpacity(0.55),
                  ),
                  H5(text: productModel.name),
                  Row(
                    children: [
                      H5(
                        text: "S/ ${price.toStringAsFixed(2)}",
                        fontWeight: FontWeight.w700,
                      ),
                      spacing12With,
                      productModel.discount > 0
                          ? H6(
                              text:
                                  "S/ ${productModel.price.toStringAsFixed(2)}",
                              color:
                                  BrandColor.primaryFontColor.withOpacity(0.55),
                              textDecoration: TextDecoration.lineThrough,
                            )
                          : const Text(""),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
