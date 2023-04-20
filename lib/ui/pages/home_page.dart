import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_offerts_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_producto_widget.dart';

class HomePage extends StatelessWidget {
  /*
  //con esto realiamos la llamda a nuestro firebase
  CollectionReference productReference =
      FirebaseFirestore.instance.collection("products");
  */
  //nos cremos una variable para nuestro servicio
  FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    /*
    //realizamos la prueba la cantidad de productos que tenemos
    productReference.get().then((QuerySnapshot value) {
      //traemos en tamaño de nuestros elemetos
      print(value.size);
      //traemos los elementos
      value.docs.forEach((element) {
        print(element.id);
      });
    });
*/
//probamos nuestro servicio con su método
    // firestoreService.getProducts();
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          //cuando requieridmos un solo servicio
          // future: firestoreService.getProducts(),
          //cuando requerimos varios servicios
          future: firestoreService.getProducts(),
          //  Future.wait([
          //   firestoreService.getProducts(),
          //   firestoreService.getBrands(),
          // ]),
          builder: (context, AsyncSnapshot snapshot) {
            // print(snapshot);
            if (snapshot.hasData) {
              // print(snapshot.data[1]);
              //realizamos la llamada a nuestra lista de productos
              // List<ProductModel> products = snapshot.data[0];
              List<ProductModel> products = snapshot.data;
              // List<BrandModel> brands = snapshot.data[1];
              //verificación y actualización de la marca

              //lsita de productoscon descuentos
              List<ProductModel> productsDiscount = [];
              /*
              //aqui verificamos que productos tienen descuentos FORMA 1
              for (var item in products) {
                if (item.discount > 0) {
                  productsDiscount.add(item);
                }
              }*/
              /*
              //realimos en descuento de la SeEGUNDA FORMA
              products.forEach((item) {
                if (item.discount > 0) {
                  productsDiscount.add(item);
                }
              });*/
              //realimos el descuento de la TERCER FORMA
              productsDiscount = products.where((e) => e.discount > 0).toList();

              // print(productsDiscount.length);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: BrandColor.primaryColor,
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const H1(
                              text: "Hey Elí Pacombia Quiroa, Bienvenido",
                              height: 1.15,
                            ),
                            spacing12,
                            const H5(
                                text: "Tenemos las mejores ofertas para ti"),
                            spacing12,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: productsDiscount.map((e) {
                                  //Esto deberia de estar en el back
                                  // String idBrand = e.brand;
                                  // String newBrand = brands
                                  //     .where((item) => item.id == idBrand)
                                  //     .first
                                  //     .name;
                                  // e.brand = newBrand;
                                  return ItemOffertWidget(
                                    productModel: e,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const H5(
                            text: "Ultimos ingresos",
                            fontWeight: FontWeight.w700,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 3.0),
                            decoration: BoxDecoration(
                                color: BrandColor.primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: const [
                                H6(
                                  text: "Ver todo",
                                  color: BrandColor.secondaryFontColor,
                                ),
                                Icon(
                                  Icons.arrow_right_alt_outlined,
                                  size: 16,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, int index) {
                        // print(products[index].brand);
                        // String idBrand = products[index].brand;
                        //con esto encontrasmo en nombre de nuesta marca
                        // print(brands
                        //     .where((element) => element.id == idBrand)
                        //     .first
                        //     .name);
                        // String newBrand = brands
                        //     .where((element) => element.id == idBrand)
                        //     .first
                        //     .name;

                        // products[index].brand = newBrand;
                        return ItemProductWidget(
                          productModel: products[index],
                        );
                      },
                    )
                  ],
                ),
              );
            }
            return Center(
              child: loadingWidget,
            );
          },
        ));
  }
}
