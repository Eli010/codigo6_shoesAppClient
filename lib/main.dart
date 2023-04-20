import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoesclientapp/services/local/sp_global.dart';
import 'package:shoesclientapp/ui/pages/admin/home_page.dart';
import 'package:shoesclientapp/ui/pages/init_page.dart';
import 'package:shoesclientapp/ui/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SPGlobal spGlobal = SPGlobal();
  spGlobal.initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      title: 'Shoes App cliente',
      home: HomeAdminPage(),
      // home: LoginPage(),
    );
  }
}
