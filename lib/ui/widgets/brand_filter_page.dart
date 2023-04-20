import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/brand_model.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_producto_widget.dart';

class BrandFilterPage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();
  BrandModel brandModel;

  BrandFilterPage({super.key, required this.brandModel});

  @override
  Widget build(BuildContext context) {
    // firestoreService.getProductsByBrand(brandModel.id!);
    return Scaffold(
      body: FutureBuilder(
        // future: firestoreService.getProductsByBrand(model.id!),
        future: firestoreService.getProductsByBrand(brandModel.id!),
        builder: (BuildContext context, AsyncSnapshot snap) {
          if (snap.hasData) {
            List<ProductModel> products = snap.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  floating: true,
                  title: H5(
                    text: brandModel.name,
                    fontWeight: FontWeight.w700,
                  ),
                  toolbarHeight: 50,
                  centerTitle: true,
                ),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ItemProductWidget(
                        productModel: products[index],
                      );
                      //return Text("Hola");
                    },
                    childCount: products.length,
                  ),
                ),
              ],
            );
          }
          return loadingWidget;
        },
      ),
    );
  }
}
