import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/search/search_product.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_producto_widget.dart';

class ExplorerPage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: firestoreService.getProducts(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> products = snapshot.data;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: BrandColor.primaryColor,
                floating: true,
                pinned: false,
                expandedHeight: 60,
                title: TextField(
                  onTap: () async {
                    await showSearch(
                        context: context,
                        delegate: SearchProduct(products: products));
                  },
                  cursorColor: BrandColor.secondaryFontColor,
                  style: const TextStyle(
                      fontSize: 14, color: BrandColor.secondaryFontColor),
                  // enabled: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Buscar producto.... ",
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: BrandColor.secondaryFontColor,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.35),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 12,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 16.0,
                      color: BrandColor.secondaryFontColor,
                    ),
                  ),
                ),
                titleSpacing: 16.0,
                //le aumentamos el spacio
                // collapsedHeight: 66,
                toolbarHeight: 80,
                // elevation: 0,
                shadowColor: BrandColor.primaryColor,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: H5(
                        text: "Nuestros productos",
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  childAspectRatio: 0.9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    return ItemProductWidget(
                      productModel: products[index],
                    );
                    // return Text("data");
                  },
                  childCount: products.length,
                ),
              ),
            ],
          );
        }
        return loadingWidget;
      },
    )

        // body: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.all(16.0),
        //         color: BrandColor.primaryColor,
        //         child: SafeArea(
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               TextField(
        //                 cursorColor: BrandColor.secondaryFontColor,
        //                 style: const TextStyle(
        //                     fontSize: 14, color: BrandColor.secondaryFontColor),
        //                 // enabled: false,
        //                 readOnly: true,
        //                 decoration: InputDecoration(
        //                   hintText: "Buscar producto.... ",
        //                   hintStyle: const TextStyle(
        //                     fontSize: 14,
        //                     color: BrandColor.secondaryFontColor,
        //                   ),
        //                   filled: true,
        //                   fillColor: Colors.white.withOpacity(0.35),
        //                   focusedBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(30),
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   enabledBorder: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(30),
        //                     borderSide: BorderSide.none,
        //                   ),
        //                   contentPadding: const EdgeInsets.symmetric(
        //                     horizontal: 0,
        //                     vertical: 12,
        //                   ),
        //                   prefixIcon: const Icon(
        //                     Icons.search,
        //                     size: 16.0,
        //                     color: BrandColor.secondaryFontColor,
        //                   ),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ),
        // GridView.builder(
        //   shrinkWrap: true,
        //   itemCount: 30,
        //   physics: const ScrollPhysics(),
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 4.0,
        //     crossAxisSpacing: 4.0,
        //     childAspectRatio: 0.85,
        //   ),
        //   itemBuilder: (context, index) {
        //     return const ItemProductWidget();
        //   },
        // ),
        // SliverGrid.count(
        //   crossAxisCount: 2,
        // ),
        // SliverGrid(
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 10,
        //     crossAxisSpacing: 10,
        //   ),
        //   delegate: SliverChildBuilderDelegate(
        //     (BuildContext context, int index) {
        //       return Container(
        //         color: Colors.teal,
        //       );
        //     },
        //     childCount: 10,
        //   ),
        // )
        //       ],
        //     ),
        //   ),
        );
  }
}
