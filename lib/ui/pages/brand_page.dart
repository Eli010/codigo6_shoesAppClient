import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/brand_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/widgets/brand_filter_page.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_brand_widget.dart';

class BrandPage extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    // firestoreService.getBrands().then((value) {
    //   print(value.length);
    // });
    return Scaffold(
        body: FutureBuilder(
      future: firestoreService.getBrands(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<BrandModel> brands = snapshot.data;
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Colors.white,
                floating: true,
                title: H5(
                  text: "Nuestras Marcas",
                  fontWeight: FontWeight.w700,
                ),
                toolbarHeight: 80,
                centerTitle: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(14),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: brands
                      .map((e) => ItemBrandWidget(
                            brandModel: e,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BrandFilterPage(brandModel: e),
                                ),
                              );
                            },
                          ))
                      .toList(),
                ),
              )
            ],
          );
        }
        return Center(
          child: loadingWidget,
        );
      },
    ));
  }
}
