import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoesclientapp/models/brand_model.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/models/user_model.dart';

class FirestoreService {
  Future<List<ProductModel>> getProducts() async {
    //llamamos nuestra colección
    CollectionReference reference =
        FirebaseFirestore.instance.collection("products");
    //con esto obtengo mi collection
    // QuerySnapshot collection = await reference.get();
    QuerySnapshot collection = await reference.get();
    //esto es nuetro documents
    List<QueryDocumentSnapshot> docs = collection.docs;
    //Me creo una lista de productos
    List<ProductModel> products = [];
    //listamos las marcas
    List<BrandModel> brands = await getBrands();
    //realizamos el resumen de nustro for
    // products = docs
    //     .map((e) => ProductModel.fromJson(e.data() as Map<String, dynamic>))
    //     .toList();

    for (QueryDocumentSnapshot item in docs) {
      // print(item.data());
      ProductModel product =
          ProductModel.fromJson(item.data() as Map<String, dynamic>);
      // print(product.brand);
      //con esto comparamos nuestro idbrand y producto brand
      String newBrand =
          brands.where((element) => element.id == product.brand).first.name;
      product.brand = newBrand;
      products.add(product);
      // print(product.toJson());
    }

    return products;
  }

  Future<List<BrandModel>> getBrands() async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("brands");
    QuerySnapshot collection = await reference.get();
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<BrandModel> brands = [];
    for (QueryDocumentSnapshot item in docs) {
      BrandModel modelB =
          BrandModel.fromJson(item.data() as Map<String, dynamic>);
      // print(modelB.toJson());
      modelB.id = item.id;
      // print(modelB.toJson());
      brands.add(modelB);
    }
    // brands = docs
    //     .map((e) => BrandModel.fromJson(e.data() as Map<String, dynamic>))
    //     .toList();
    return brands;
  }

  Future<List<ProductModel>> getProductsByBrand(String id) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection("products");
    QuerySnapshot collection =
        await reference.where("brand", isEqualTo: id).get();

    // print(collection.size);
    List<QueryDocumentSnapshot> docs = collection.docs;
    List<ProductModel> products = [];
    List<BrandModel> brands = await getBrands();
    for (QueryDocumentSnapshot item in docs) {
      ProductModel product =
          ProductModel.fromJson(item.data() as Map<String, dynamic>);
      //con esto comparamos nuestro idbrand y producto brand
      String newBrand =
          brands.where((element) => element.id == product.brand).first.name;
      product.brand = newBrand;
      products.add(product);
    }
    return products;
  }

  Future<String> registerUser(UserModel model) async {
    CollectionReference userReference =
        FirebaseFirestore.instance.collection("users");
    DocumentReference doc = await userReference.add(model.toJson()
        // {
        //   "email": "Erika@gmail.com",
        //   "name": "Erika Gonzales",
        //   "phone": "958421154",
        //   "rol": "client"
        // },
        );
    print(doc.id);
    return doc.id;
  }

  Future<String> registerProduct(ProductModel product) async {
    CollectionReference productReference =
        FirebaseFirestore.instance.collection("products");
    DocumentReference doc = await productReference.add(product.toJson());
    return doc.id;
  }

  Future<void> updateProduct(ProductModel model) async {
    CollectionReference productReference =
        FirebaseFirestore.instance.collection("products");
    await productReference.doc(model.id).update(model.toJson());
  }
}
