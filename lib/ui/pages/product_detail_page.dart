import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_discount_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_size_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/calculate.dart';
import 'package:shoesclientapp/utils/response.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailPage({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    double price = productModel.price;
    if (productModel.discount > 0) {
      price = price - (productModel.price * productModel.discount / 100);
    }
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: productModel.image,
                height: ResponsiveUI.pDiagonal(context, 0.37),
                width: double.infinity,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Image.asset(AssetsData.placeHolder);
                },
                progressIndicatorBuilder: (context, url, progress) {
                  return loadingWidget;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ItemDiscountWidget(discount: 40),
                    spacing8,
                    H4(
                      text: productModel.brand,
                      color: BrandColor.primaryFontColor.withOpacity(0.60),
                    ),
                    // spacing8,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: H2(
                            text: productModel.name,
                            fontWeight: FontWeight.w900,
                            height: 1,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            H6(
                              text:
                                  "S/. ${productModel.price.toStringAsFixed(2)}",
                              color:
                                  BrandColor.primaryFontColor.withOpacity(0.60),
                              textDecoration: TextDecoration.lineThrough,
                            ),
                            spacing4,
                            H4(
                              text:
                                  "S/ ${Calculate.getPrice(productModel.price, productModel.discount).toStringAsFixed(2)}",
                              // "S/ 256",
                              fontWeight: FontWeight.w900,
                              height: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                    spacing16,
                    H5(
                      text: "Tallas disponibles:",
                      color: BrandColor.primaryFontColor.withOpacity(0.60),
                    ),
                    spacing12,

                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: productModel.sizes
                          .map((e) => ItemSizeWidget(
                                size: e,
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              height: 100,
              // color: Colors.amber,
              child: Row(
                children: [
                  H2(
                    text:
                        "S/ ${Calculate.getPrice(productModel.price, productModel.discount).toStringAsFixed(2)}",
                    // "S/ 256",
                  ),
                  spacing12With,
                  Expanded(
                    child: SizedBox(
                      height: 50.0,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColor.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        // icon: Icon(Icons.),
                        icon: SvgPicture.asset(
                          AssetsData.iconWhatsapp,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                        label: const H4(
                          text: "Obtener ahora",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
