import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/product_model.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_discount_widget.dart';
import 'package:shoesclientapp/ui/widgets/item_search_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/calculate.dart';

class SearchProduct extends SearchDelegate {
  List<ProductModel> products;
  SearchProduct({required this.products});
  List<String> names = [
    "Elvis",
    "Lee",
    "Margarita",
    "Sandra",
    "Rosa",
    "Miguel",
    "Ganner"
  ];

  //aqui esta nuestro label
  @override
  String? get searchFieldLabel => "Buscar producto...";
  @override
  //el estilo de mi label
  TextStyle? get searchFieldStyle => TextStyle(
      fontSize: 16, color: BrandColor.primaryFontColor.withOpacity(0.80));
  //decoration
  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.06),
        hintStyle: TextStyle(
            fontSize: 14, color: BrandColor.primaryFontColor.withOpacity(0.6)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      );

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: IconThemeData(
          color: BrandColor.primaryFontColor.withOpacity(0.8),
        ),
        toolbarHeight: 76,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black.withOpacity(0.06),
        hintStyle: TextStyle(
            fontSize: 14, color: BrandColor.primaryFontColor.withOpacity(0.6)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ));

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          // print(query);
          close(context, "");
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> result = products
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) {
        return ItemSearchWidget(
          productModel: result[index],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> suggestions = products
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ItemSearchWidget(
          productModel: suggestions[index],
        );
      },
    );
  }
}
