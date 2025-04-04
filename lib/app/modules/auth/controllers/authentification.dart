import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/database/database_helper.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/views/login/login_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../../constants/connectivity_service.dart';
import '../../../constants/constants.dart';
import '../../dashbord/controllers/info_dossier.dart';
import '../../dashbord/views/carousel_page.dart';
import '../../dashbord/views/valeur_semaine.dart';
import '../../marche/models/activite_model.dart';
import '../../marche/models/marche_model.dart';
import '../../marcheHorsLigne/controllers/marche_hors_ligne.dart';
import '../models/user_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../dashbord/views/dashbord.dart';
import '../../../database/database_helper.dart'; // Ajout pour SQLite

class AuthentificationController extends GetxController {
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  final user_role = ''.obs;
  var marcheParActivite = <MarcheModel>[].obs; // Modèle Marché observable
  var user = Rxn<UserModel>(); // Modèle utilisateur observable
  var liste_activite = <ActiviteModel>[].obs;

  final ConnectivityService connectivityService = ConnectivityService();

  // Fonction pour se connecter
  Future login({required String email, required String password}) async {
    try {
      isLoading.value = true;

      if (connectivityService.isConnected) {
        // 🌐 Utilisateur en ligne : connexion API
        var data = {'email': email, 'password': password};
        var request = await http.post(
          Uri.parse('${url}/login'),
          headers: {'Accept': 'application/json'},
          body: data,
        );

        if (request.statusCode == 200) {
          var responseData = json.decode(request.body);
          token = responseData['access_token'];
          box.write('access_token', token);

          var userData = responseData['user'];
          user.value = UserModel.fromJson(userData);

          // 🔹 Stocker l'utilisateur en SQLite
          await DatabaseHelper.instance.insertUser({
            'name': userData['name'],
            'email': userData['email'],
            'token': token,
          });

          // Appeler le controller InfoDossierController pour récupérer les activités
          final infoDossierController = Get.find<InfoDossierController>();
          await infoDossierController.getActiviteMarcheHorsSigobe();

          // Récupérer la liste des activités depuis le controller
          List<ActiviteModel> activities = infoDossierController.liste_activite;

          // Insérer les activités dans la base de données SQLite
          for (var activity in activities) {
            await DatabaseHelper.instance.insertActivity(activity.toMap());
          }
          // Appeler le controller InfoDossierController pour récupérer les activités
          final marcheHorsLigneController =
              Get.find<MarcheControllerHorsLigne>();
          await marcheHorsLigneController.getListeMarcheParApi();

          // Récupérer la liste des activités depuis le controller
          List<MarcheModel> marches = marcheHorsLigneController.listeMarche;
          if (marches.isNotEmpty) {
            // Insérer les activités dans la base de données SQLite
            for (var marche in marches) {
              print("insertion du marché: $marches");
              await DatabaseHelper.instance.insertMarche(marche);
            }
          } else {
            print("erreur lors du chargement du marché");
          }

          Get.offAll(() =>  ValeurSemainePage());
        } else {
          Get.snackbar("Connexion", "Échec, identifiants incorrects",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        // 🚀 Mode hors-ligne : vérifier si l'utilisateur est en local
        var localUser = await DatabaseHelper.instance.getUserByEmail(email);

        if (localUser != null && localUser['email'] == email) {
          user.value = UserModel(
            userName: localUser['name'],
            email: localUser['email'],
          );
          token = localUser['token'];

          Get.snackbar("Mode hors-ligne", "Connexion réussie",
              backgroundColor: Colors.orange, colorText: Colors.white);

          Get.offAll(() => const CarouselPage());
        } else {
          Get.snackbar("Mode hors-ligne", "Utilisateur non trouvé en local",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      print("Erreur : $e");
      Get.snackbar("Erreur", "Une erreur s'est produite",
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  // Fonction pour se déconnecter
  Future logout() async {
    try {
      await http.post(
        Uri.parse('${url}/logout'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer ${box.read('access_token')}', // Utilisation correcte du token
        },
      );

      // Supprimer l'utilisateur en SQLite
      await DatabaseHelper.instance.deleteUser();

      // Supprimer les données stockées
      box.erase();
      Get.offAll(
          () => const LoginPage()); // Rediriger vers la page de connexion
    } catch (e) {
      print("Erreur de déconnexion : $e");
    }
  }
}
