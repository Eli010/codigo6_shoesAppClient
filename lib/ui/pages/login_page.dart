import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/register_page.dart';
import 'package:shoesclientapp/ui/widgets/common_button_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_input_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_password_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/response.dart';
import 'package:shoesclientapp/utils/type.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Positioned(
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
          ),

          //Formulario
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  // key: formKeyLogin,
                  child: Column(
                    children: [
                      SizedBox(
                        height: ResponsiveUI.pDiagonal(context, 0.07),
                      ),
                      Image.asset(
                        AssetsData.imageLogo,
                        height: 52,
                      ),
                      H1(
                        text: "ShoesApp",
                      ),
                      spacing8,
                      H4(
                        text: "Iniciar Sesión",
                      ),
                      // spacing4,
                      // H5(
                      //   text: "Por favor ingresa tus credenciales",
                      //   color: BrandColor.primaryFontColor.withOpacity(0.80),
                      // ),
                      spacing20,
                      CommonInputWidget(
                        label: "Correo electrónico",
                        hintText: "Tu correo electrónico",
                        icon: AssetsData.iconEmail,
                        controller: emailController,
                        inputType: InputTypeEnum.email,
                      ),
                      spacing20,
                      CommonPasswordWidget(
                        controller: passwordController,
                      ),
                      spacing30,
                      CommonButtonWidget(
                        color: BrandColor.secondaryColor,
                        text: "Iniciar Sesión",
                        onPressed: () {
                          // login();
                        },
                      ),
                      spacing16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Aún no tienes una cuenta?  ",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: H5(
                              text: "Regístrate",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      spacing40,
                      H5(
                        text: "También puedes",
                        color: BrandColor.primaryFontColor.withOpacity(0.80),
                      ),
                      spacing20,
                      CommonButtonWidget(
                        color: Color(0xff000814),
                        text: "Iniciar Sesión con Google",
                        // icon: AssetData.iconGoogle,
                        icon: AssetsData.iconGoogle,
                        onPressed: () {
                          // loginWithGoogle();
                        },
                      ),
                      spacing20,
                      CommonButtonWidget(
                        color: Color(0xff0A82ED),
                        text: "Iniciar Sesión con Facebook",
                        icon: AssetsData.iconFacebook,
                        onPressed: () {
                          // loginWithFacebook();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // isLoading
          //     ? Container(
          //         color: Colors.white70,
          //         child: loadingWidget,
          //       )
          //     : const SizedBox(),
        ],
      ),
    );
  }
}
