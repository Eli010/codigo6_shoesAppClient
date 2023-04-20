import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/admin/producto_form_admin_page.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class ProducAdminPage extends StatelessWidget {
  CollectionReference productReference =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: BrandColor.secondaryColor,
          title: const H4(
            text: "Productos",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductFormAdminPage(),
                ));
          },
          child: Icon(Icons.add),
          backgroundColor: BrandColor.secondaryColor,
        ),
        body: StreamBuilder(
          stream: productReference.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot collection = snapshot.data;
              List<QueryDocumentSnapshot> docs = collection.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  //nos reamos un mapa
                  Map<String, dynamic> data =
                      docs[index].data() as Map<String, dynamic>;
                  ProductModel product = ProductModel.fromJson(data);
                  product.id = docs[index].id;
                  return ListTile(
                    //nos vmaos para realizar la actulización
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductFormAdminPage(productModel: product),
                          ));
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        height: 46.0,
                        width: 46.0,
                        fit: BoxFit.cover,
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
                    ),
                    title: H5(text: product.name),
                  );
                },
              );
              // return Text(docs.toString());
            }
            return loadingWidget;
          },
        ));
  }
}
