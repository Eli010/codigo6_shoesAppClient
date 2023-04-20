import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shoesclientapp/models/user_model.dart';
import 'package:shoesclientapp/services/local/sp_global.dart';
import 'package:shoesclientapp/services/remote/firestore_service.dart';
import 'package:shoesclientapp/ui/general/brand_color.dart';
import 'package:shoesclientapp/ui/pages/init_page.dart';
import 'package:shoesclientapp/ui/widgets/common_button_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_input_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_password_widget.dart';
import 'package:shoesclientapp/ui/widgets/common_text.dart';
import 'package:shoesclientapp/ui/widgets/common_widget.dart';
import 'package:shoesclientapp/utils/assets_data.dart';
import 'package:shoesclientapp/utils/response.dart';
import 'package:shoesclientapp/utils/type.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  FirestoreService firestoreService = FirestoreService();
  bool isLoading = false;

  registerUser() async {
    try {
      isLoading = true;
      setState(() {});
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        // email: "Erika@gmail.com",
        email: emailController.text,
        // password: "mandarina123",
        password: passwordController.text,
      );
      if (userCredential.user != null) {
        UserModel model = UserModel(
          email: emailController.text,
          name: fullNameController.text,
          phone: phoneController.text,
          rol: "client",
        );
        String value = await firestoreService.registerUser(model);
        if (value.isNotEmpty) {
          //AQUI USAMOS NUESTRO SHARE PREFERENCE
          SPGlobal().fullName = fullNameController.text;
          SPGlobal().isLogin = true;
          isLoading = false;
          setState(() {});
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InitPage(),
              ));
        }
      }
      //aqui guardamos en nombre completo
      // CollectionReference userReference =
      //     FirebaseFirestore.instance.collection("users");
      // userReference.add(
      //   {
      //     "email": "Erika@gmail.com",
      //     "name": "Erika Gonzales",
      //     "phone": "958421154",
      //     "rol": "client"
      //   },
      // );
      // print(userCredential);
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      setState(() {});
      print("error .... ${e.code}");
      if (e.code == "weak-password") {
        //
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("La contraseña debe tener minimo 6 caracteres"),
        );
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarError("El correo electrónico ya está siendo utilizado"),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
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

          //Form
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  // key: formKeyRegister,
                  child: Column(
                    children: [
                      SizedBox(
                        height: ResponsiveUI.pDiagonal(context, 0.07),
                      ),
                      Image.asset(
                        AssetsData.imageLogo,
                        height: 52,
                      ),
                      const H1(
                        text: "ShoesApp",
                      ),
                      spacing8,
                      const H4(
                        text: "Regístrate",
                      ),
                      spacing20,
                      CommonInputWidget(
                        label: "Nombre completo",
                        hintText: "Tu nombre completo",
                        icon: AssetsData.iconUser,
                        controller: fullNameController,
                        inputType: InputTypeEnum.text,
                      ),
                      spacing20,
                      CommonInputWidget(
                        label: "Teléfono",
                        hintText: "Tu teléfono",
                        icon: AssetsData.iconPhone,
                        controller: phoneController,
                        inputType: InputTypeEnum.phone,
                      ),
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
                        text: "Regístrate",
                        onPressed: () {
                          registerUser();
                        },
                      ),
                      spacing16,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          H5(
                            text: "Ya tienes una cuenta?  ",
                            color:
                                BrandColor.primaryFontColor.withOpacity(0.70),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const H5(
                              text: "Inicia Sesión",
                              fontWeight: FontWeight.w700,
                              color: BrandColor.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          isLoading
              ? Container(
                  color: Colors.white70,
                  child: loadingWidget,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
