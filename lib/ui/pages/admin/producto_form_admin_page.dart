import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:shoesclientapp/models/brand_model.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_button_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_input_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/response.dart';
import 'package:shoesclientapp/utils/type.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductFormAdminPage extends StatefulWidget {
  final ProductModel? productModel;

  const ProductFormAdminPage({super.key, this.productModel});
  @override
  State<ProductFormAdminPage> createState() => _ProductFormAdminPageState();
}

class _ProductFormAdminPageState extends State<ProductFormAdminPage> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController discountCtrl = TextEditingController();
  final TextEditingController stockCtrl = TextEditingController();

  final TextEditingController sizeCtrl = TextEditingController();

  List<double> sizes = [];
  ImagePicker imagePicker = ImagePicker();
  XFile? image;
  bool isloading = false;
  Future<void> getImageGallery() async {
    image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {});
    }
  }

  //aqui traemos la lista e marcas
  List<BrandModel> brands = [];
  String idBrand = "";
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    isloading = true;
    setState(() {});
    FirestoreService firestoreService = FirestoreService();
    brands = await firestoreService.getBrands();
    idBrand = brands.first.id!;
    if (widget.productModel != null) {
      String urlImage = await uploadImageStorage();
      nameCtrl.text = widget.productModel!.name;
      priceCtrl.text = widget.productModel!.price.toString();
      discountCtrl.text = widget.productModel!.discount.toString();
      stockCtrl.text = widget.productModel!.stock.toString();
      sizes = widget.productModel!.sizes;
      idBrand = widget.productModel!.brand;
    }
    isloading = false;
    setState(() {});
  }

  // String dropdownValue = 'Opción 1';
  Future<String> uploadImageStorage() async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference referenceStorage =
        storage.ref().child("examples");
    //creamos un nombre
    String name = DateTime.now().toString();
    //creamos la extendion
    String temp = mime(image!.path) ?? "";
    //desfragmentamos nuestro url de la image
    String extension = temp.split("/")[1];
    //con esto subo mi archivo
    firebase_storage.TaskSnapshot uploadTask = await referenceStorage
        .child("$name.$extension")
        .putFile(File(image!.path));
    // print(referenceStorage);
    //con esto obtengo mi url
    return await uploadTask.ref.getDownloadURL();
  }

/*
  registerProduct() async {
    CollectionReference productReference =
        FirebaseFirestore.instance.collection("products");
    String urlImage = await uploadImageStorage();
    productReference.add(
      {
        "name": nameCtrl.text,
        "price": double.parse(priceCtrl.text),
        "discount": int.parse(discountCtrl.text),
        "stock": int.parse(stockCtrl.text),
        "brand": idBrand,
        "status": true,
        "sizes": sizes,
        "created": DateTime.now(),
        "image": urlImage,
      },
    );
  }
*/
  registerProduct() async {
    FirestoreService firestoreService = FirestoreService();
    String urlImage = await uploadImageStorage();
    ProductModel product = ProductModel(
      name: nameCtrl.text,
      price: double.parse(priceCtrl.text),
      image: urlImage,
      discount: int.parse(discountCtrl.text),
      status: true,
      stock: int.parse(stockCtrl.text),
      brand: idBrand,
      sizes: sizes,
    );
    String id = await firestoreService.registerProduct(product);
    if (id.isNotEmpty) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // sizes = sizes.reversed.toList();
    return Scaffold(
      appBar: AppBar(
        title: const H4(
          text: "Agregar Producto",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: BrandColor.secondaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonInputWidget(
                    label: "Nombre",
                    hintText: "Nombre del producto",
                    icon: AssetsData.iconNotepad,
                    controller: nameCtrl,
                    inputType: InputTypeEnum.text,
                  ),
                  spacing20,
                  const H5(
                    text: "Marca:",
                    fontWeight: FontWeight.w500,
                  ),
                  spacing8,
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 12,
                          offset: const Offset(4, 4),
                        ),
                      ],
                    ),
                    child: DropdownButton(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(20.0),
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: idBrand,
                      // value: dropdownValue,

                      items: brands
                          .map(
                            (e) => DropdownMenuItem(
                              child: H5(text: e.name),
                              value: e.id,
                            ),
                          )
                          .toList(),
                      //  <String>[
                      //   'Opción 1',
                      //   'Opción 2',
                      //   'Opción 3',
                      //   'Opción 4'
                      // ].map<DropdownMenuItem<String>>((String value) {
                      //   return DropdownMenuItem(
                      //     child: H5(text: value),
                      //     value: value,
                      //   );
                      // DropdownMenuItem<String>(
                      //   value: value,
                      //   child: Text(value),
                      // );
                      // }).toList(),
                      //   const [
                      // DropdownMenuItem(
                      //   child: H5(text: "Adidas"),
                      //   value: "Adidas",
                      // ),
                      // DropdownMenuItem(
                      //   child: H5(text: "Nike"),
                      //   value: "Nike",
                      // ),
                      // DropdownMenuItem(
                      //   child: H5(text: "New Balance"),
                      //   value: "New Balance",
                      // ),
                      // DropdownMenuItem(
                      //   child: H5(text: "Puma"),
                      //   value: "Puma",
                      // ),
                      // ],
                      onChanged: (String? value) {
                        idBrand = value!;
                        setState(() {});
                        // print(value);
                        // setState(() {
                        //   dropdownValue = newValue.toString();
                        // });
                      },
                    ),
                  ),
                  spacing20,
                  Row(
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Precio (S/. )",
                          hintText: "Precio",
                          icon: AssetsData.iconDollar,
                          controller: priceCtrl,
                          inputType: InputTypeEnum.num,
                        ),
                      ),
                      spacing16With,
                      Expanded(
                        child: CommonInputWidget(
                          label: "Descuento (%)",
                          hintText: "Descuento",
                          icon: AssetsData.iconOffer,
                          controller: discountCtrl,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                    ],
                  ),
                  spacing20,
                  Row(
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Stock",
                          hintText: "Stock",
                          icon: AssetsData.iconShape,
                          controller: stockCtrl,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  spacing20,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: CommonInputWidget(
                          label: "Tallas",
                          hintText: "Talla",
                          icon: AssetsData.iconSize,
                          controller: sizeCtrl,
                          inputType: InputTypeEnum.text,
                        ),
                      ),
                      spacing16With,
                      InkWell(
                        onTap: () {
                          if (sizeCtrl.text.isNotEmpty) {
                            double size = double.parse(sizeCtrl.text);
                            sizes.add(size);
                            FocusManager.instance.primaryFocus?.unfocus();
                            sizeCtrl.clear();
                            setState(() {});
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: BrandColor.primaryFontColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  spacing16,
                  Container(
                    height: ResponsiveUI.pDiagonal(context, 0.25),
                    child: sizes.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: sizes.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: H5(
                                    text:
                                        "Talla: ${sizes[sizes.length - index - 1]}"),
                                trailing: IconButton(
                                  onPressed: () {
                                    sizes.removeAt(sizes.length - index - 1);
                                    setState(() {});
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: H5(text: "Aun no hay tallas agregadas"),
                          ),
                  ),
                  spacing20,
                  CommonButtonWidget(
                    text: "Galeria",
                    color: BrandColor.primaryFontColor,
                    icon: AssetsData.iconRocket,
                    onPressed: () {
                      getImageGallery();
                    },
                  ),
                  spacing20,
                  ClipRRect(
                    child: Image(
                      image: image != null
                          ? FileImage(File(image!.path))
                          : widget.productModel != null
                              ? NetworkImage(widget.productModel!.image)
                              : const AssetImage(AssetsData.placeHolder)
                                  as ImageProvider,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: ResponsiveUI.pDiagonal(context, 0.3),
                    ),
                  ),
                  /*
                  image != null
                      ? Image.file(
                          File(image!.path),
                          width: double.infinity,
                          height: ResponsiveUI.pDiagonal(context, 0.33),
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(),
                */
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(12.0),
              child: CommonButtonWidget(
                  text: "Agregar Producto",
                  color: BrandColor.secondaryColor,
                  onPressed: () {
                    // uploadImageStorage();
                    registerProduct();
                  }),
            ),
          ),
          isloading
              ? Container(
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
