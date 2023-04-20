import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/brand_model.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class ItemBrandWidget extends StatelessWidget {
  final BrandModel brandModel;
  final VoidCallback onTap;
  const ItemBrandWidget(
      {super.key, required this.brandModel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
          imageUrl: brandModel.image,
          // fit: BoxFit.cover,
          errorWidget: (context, url, error) {
            return Image.asset(AssetsData.placeHolder);
          },
          progressIndicatorBuilder: (context, url, progress) {
            return loadingWidget;
          },
        ),
      ),
    );
  }
}
