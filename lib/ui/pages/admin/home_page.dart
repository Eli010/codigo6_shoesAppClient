import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/admin/dashboard_admin_page.dart';
import 'package:shoesclientapp/ui/pages/admin/product_admin_page.dart';
import 'package:shoesclientapp/ui/pages/admin/report_admin_page.dart';
import 'package:shoesclientapp/ui/widgets/admin/item_menu_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/response.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    spacing30,
                    H1(
                      text: "Bienenidos al administrador de shoesApp",
                    ),
                    spacing12,
                    H5(text: "Puedes GEstionar todo desde aqui"),
                    GridView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: [
                        ItemMenuWidget(
                          text: "Productos",
                          icon: AssetsData.imageShoes,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProducAdminPage(),
                                ));
                          },
                        ),
                        ItemMenuWidget(
                          text: "Marcas",
                          icon: AssetsData.imageCategory,
                          onTap: () {},
                        ),
                        ItemMenuWidget(
                          text: "Clientes",
                          icon: AssetsData.imageClient,
                          onTap: () {},
                        ),
                        ItemMenuWidget(
                          text: "Resportes",
                          icon: AssetsData.imageReport,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReportAdminPage(),
                                ));
                          },
                        ),
                        ItemMenuWidget(
                          text: "Dasboard",
                          icon: AssetsData.imageDasboard,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DasboardAdminPage(),
                                ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -ResponsiveUI.pDiagonal(context, 0.2),
      left: -ResponsiveUI.pDiagonal(context, 0.05),
      child: Transform.rotate(
        angle: pi / 3.5,
        child: Container(
          height: ResponsiveUI.pDiagonal(context, 0.48),
          width: ResponsiveUI.pDiagonal(context, 0.48),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(90.0),
            gradient: const LinearGradient(
              colors: [
                BrandColor.secondaryColor,
                BrandColor.primaryColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: BrandColor.primaryColor.withOpacity(0.6),
                blurRadius: 12.0,
                offset: const Offset(6, 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
