import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/brand_page.dart';
import 'package:shoesclientapp/ui/pages/explorer_page.dart';
import 'package:shoesclientapp/ui/pages/home_page.dart';
import 'package:shoesclientapp/utils/assets_data.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int indexPage = 0;
  List<Widget> pages = [
    HomePage(),
    ExplorerPage(),
    BrandPage(),
    const Center(
      child: Text("Favoritos"),
    ),
    const Center(
      child: Text("perfil"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[indexPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (int value) {
          indexPage = value;
          setState(() {});
          // print(value);
        },
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        selectedItemColor: BrandColor.primaryFontColor,
        unselectedItemColor: BrandColor.primaryFontColor.withOpacity(0.45),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsData.iconStore,
                height: 22,
                colorFilter: ColorFilter.mode(
                    indexPage == 0
                        ? BrandColor.primaryFontColor
                        : BrandColor.primaryFontColor.withOpacity(0.45),
                    BlendMode.srcIn)),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.iconRocket,
              colorFilter: indexPage == 1
                  ? const ColorFilter.mode(
                      BrandColor.primaryFontColor, BlendMode.srcIn)
                  : ColorFilter.mode(
                      BrandColor.primaryFontColor.withOpacity(0.45),
                      BlendMode.srcIn),
            ),
            label: "Explorer",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.iconBrand,
              colorFilter: indexPage == 2
                  ? const ColorFilter.mode(
                      BrandColor.primaryFontColor, BlendMode.srcIn)
                  : ColorFilter.mode(
                      BrandColor.primaryFontColor.withOpacity(0.45),
                      BlendMode.srcIn),
            ),
            label: "Marcas",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.iconFavorite,
              colorFilter: indexPage == 3
                  ? const ColorFilter.mode(
                      BrandColor.primaryFontColor, BlendMode.srcIn)
                  : ColorFilter.mode(
                      BrandColor.primaryFontColor.withOpacity(0.45),
                      BlendMode.srcIn),
            ),
            label: "Favoritos",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsData.iconProfile,
              colorFilter: indexPage == 4
                  ? const ColorFilter.mode(
                      BrandColor.primaryFontColor, BlendMode.srcIn)
                  : ColorFilter.mode(
                      BrandColor.primaryFontColor.withOpacity(0.45),
                      BlendMode.srcIn),
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
