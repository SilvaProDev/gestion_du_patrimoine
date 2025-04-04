import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/views/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:printing/printing.dart';

import 'app/database/database_helper.dart';
import 'app/modules/auth/controllers/authentification.dart';
import 'app/modules/dashbord/controllers/info_dossier.dart';
import 'app/modules/dashbord/views/currentPage.dart';
import 'app/modules/marcheHorsLigne/controllers/marche_hors_ligne.dart';

void main() async {
  // Ensuring Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize the database
  await DatabaseHelper.instance.database;
  // Initialize the controllers before running the app
  // Injection au démarrage des controllers au demarrage pour stocker les données dans la base sqlite
  Get.put(AuthentificationController());
  Get.put(InfoDossierController());  
Get.put(MarcheControllerHorsLigne());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final String title = 'Invoice';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isConnectedToInternet = true;
  late StreamSubscription<InternetStatus> _internetConnectionStreamSubscription;
  Timer? _noInternetTimer; // Timer pour afficher le message périodiquement

  @override
  void initState() {
    super.initState();

    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (event) {
          case InternetStatus.connected:
            setState(() {
              _isConnectedToInternet = true;
              print(_isConnectedToInternet);
              _noInternetTimer?.cancel(); // Arrêter le timer si Internet revient
              print("Connecté");
              if (Get.context != null) {
                Get.snackbar(
                  "Connexion", "Connexion retablie",
                  colorText: Colors.white,
                  backgroundColor: Colors.green,
                  snackPosition: SnackPosition.TOP,
                  borderRadius: 20,
                  margin: EdgeInsets.all(5),
                );
              } else {
                print("Impossible d'afficher la Snackbar : Get.context est null");
              }
            });
            break;

          case InternetStatus.disconnected:
            setState(() {
              _isConnectedToInternet = false;
              print(_isConnectedToInternet);
              print("Déconnecté");
              _startNoInternetNotification(); // Démarrer les notifications périodiques
            });
            break;

          default:
            setState(() {
              _isConnectedToInternet = false;
            });
            break;
        }
      });
    });
  }
   // Fonction pour afficher un message toutes les 3 secondes
  void _startNoInternetNotification() {
    _noInternetTimer?.cancel(); // Annule l'ancien timer s'il existe
    _noInternetTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      if (!_isConnectedToInternet && Get.context != null) {
        Get.snackbar(
          "Connexion", "Pas de connexion Internet",
          colorText: Colors.white,
          backgroundColor: Colors.orange,
          snackPosition: SnackPosition.TOP,
          borderRadius: 20,
          margin: EdgeInsets.all(5),
        );
      } else {
        timer.cancel(); // Arrêter le timer si l'Internet revient
      }
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription.cancel(); // Annule l'écoute pour éviter les fuites de mémoire
    super.dispose();
  }
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
      home: token == null ? LoginPage() : CurentPage(),
    );
  }
}
