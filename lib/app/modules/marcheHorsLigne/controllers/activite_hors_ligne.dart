import 'package:gestion_patrimoine_dcf/app/modules/marche/models/activite_model.dart';
import 'package:get/get.dart';

import '../../../database/database_helper.dart';

class ActiviteHorsLigneController extends GetxController {
  // Add the necessary Rx variables to store activities and loading state
  var isLoading = false.obs;
  var query = ''.obs;
  var isLoadingSigobe = false.obs;
  var liste_activite_sigobe = <ActiviteModel>[].obs;

  var liste_activite = <ActiviteModel>[].obs;
  var filterActivite = <ActiviteModel>[].obs;

@override
  void onInit() {
    super.onInit();
    filterActivite.value = liste_activite; // Initialiser la liste filtrée avec toutes les activités
  }
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

 Future<void> loadActivitesFromDatabase() async {
  isLoading.value = true;
  try {
    var activities = await _dbHelper.getAllActivitiesHorsLigne();
    if (activities.isNotEmpty) {
      liste_activite.value = activities.map((activity) {
        return ActiviteModel.fromJsonSQLite(activity);
      }).toList();
      filterActivite.value = liste_activite;
    }
  } catch (e) {
    print("Error loading activities from database: $e");
  } finally {
    isLoading.value = false;
  }
}


  // Optionally, you can add filtering methods based on search query
  void searchActivite(String query) {
    filterActivite.value = liste_activite
        .where((activite) =>
            activite.libelleActivite!
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            activite.activiteId.toString().contains(query))
        .toList();
  }
}
