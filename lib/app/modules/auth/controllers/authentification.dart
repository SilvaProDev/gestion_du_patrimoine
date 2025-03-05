import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/views/login/login_page.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
//import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../constants/constants.dart';
import '../../dashbord/views/carousel_page.dart';
import '../models/user_model.dart';
import '../../dashbord/views/dashbord.dart';

class AuthentificationController extends GetxController {
  final box = GetStorage();
  final isLoading = false.obs;
  String token = '';
  final user_role = ''.obs;
  var user = Rxn<UserModel>(); // Modèle utilisateur observable

  // final _isLoggedIn = false.obs; // Statut de connexion

  //fonction pour se connecter
  Future login({required String email, required String password}) async {
    try {
      isLoading.value = true; //Stimule le début du chargement
      var data = {'email': email, 'password': password};

      //envoie de requete vers le back pour se connecter
      var request = await http.post(Uri.parse('${url}/login'),
          headers: {
            'Accept': 'json/application',
          },
          body: data);
      //Vérifie si la réponse est ok et récupère le token
      if (request.statusCode == 200) {
        token = json.decode(request.body)['access_token'];
        box.write('access_token', token); //recupère le token
        var data1 = json.decode(request.body)['user'];
        user.value = UserModel.fromJson(data1);
        
        isLoading.value = false;
        Get.snackbar("Connexion", "Connexion effectué avec succès",
            colorText: Colors.white,
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP,
            borderRadius: 20,
            margin: EdgeInsets.all(5));
        Get.offAll(() => const CarouselPage());
      } else {
        isLoading.value = false;
        // _isLoggedIn.value = false;
        Get.snackbar("Connexion",
            "Echec de connexion. Merci de vérifier vos identifiants",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
            borderRadius: 20,
            margin: EdgeInsets.all(5));
      }
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future logout() async {
    await http.post(Uri.parse('${url}/logout'), headers: {
      'Accept': 'json/application',
      'Authorization': 'Bearer ${box.read('token')}', // Ajouter le token}
    });
    box.erase();
    Get.offAll(() => const LoginPage()); // Rediriger vers la page de connexion
    // if (request.statusCode == 200) {
    // }
  }
}
