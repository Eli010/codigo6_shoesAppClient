import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/product_detail_page.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_discount_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/response.dart';

class ItemOffertWidget extends StatelessWidget {
  final ProductModel productModel;

  const ItemOffertWidget({super.key, required this.productModel});

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
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        width: ResponsiveUI.pDiagonal(context, 0.33),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
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
                        maxLines: 2,
                        height: 1.1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w700,
                      ),
                      spacing4,
                      Row(
                        children: [
                          H5(
                            text: "S/ ${price.toStringAsFixed(2)}",
                            fontWeight: FontWeight.w700,
                          ),
                          spacing12With,
                          H6(
                            text: "S/ ${productModel.price.toStringAsFixed(2)}",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.55),
                            textDecoration: TextDecoration.lineThrough,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: productModel.image,
                    height: 90,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: Colors.amber,
                        child: Image.asset(AssetsData.placeHolder),
                      );
                    },
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(child: loadingWidget);
                    },
                  ),
                )
                // Image.network(
                //   "http://images.nike.com/is/image/DotCom/CW4555_012_A_PREM?hei=3144&wid=3144&fmt=jpg&bgc=F5F5F5&iccEmbed=1",
                //   width: 90,
                // ),
              ],
            ),
            const Positioned(
              top: -3,
              right: 0,
              child: ItemDiscountWidget(
                discount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
