import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/views/login/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:printing/printing.dart';
import 'app/modules/dashbord/views/currentPage.dart';

void main() async {
    // WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final String title = 'Invoice';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //  home:HomePage1()
      home: token == null ? LoginPage() : CurentPage() ,
      
    );
  }
}

