class ProductModel {
  String? id;
  String name;
  double price;
  String image;
  int discount;
  bool status;
  int stock;
  String brand;
  List<double> sizes;
  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.discount,
    required this.status,
    required this.stock,
    required this.brand,
    required this.sizes,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        price: json["price"] != null ? json["price"].toDouble() : 0,
        image: json["image"],
        discount: json["discount"] ?? 0,
        status: json["status"] ?? false,
        stock: json["stock"] ?? 0,
        brand: json["brand"] ?? "",
        sizes: json["sizes"] != null
            ? List<double>.from(json["sizes"].map((e) => e.toDouble()))
            : [],
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "image": image,
        "discount": discount,
        "status": status,
        "stock": stock,
        "brand": brand,
        "sizes": List<dynamic>.from(sizes.map((e) => e)),
      };
}
