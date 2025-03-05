import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/controllers/cartographie.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/image_marche_carto.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../constants/constants.dart';
import 'widgets/drawer_filtre.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final CartographieController _cartographieController =
      Get.put(CartographieController());

  LatLng _center = LatLng(7.54, -5.55); // Côte d'Ivoire par défaut
  List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();

    // Charger les données après l'initialisation
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _cartographieController.getListeImagesParMarche();
      _loadMarkers();
    });
  }

  /// Charger les marqueurs avec les images récupérées
  void _loadMarkers() {
    setState(() {
      _markers = _cartographieController.listeImagesMarches.map((marche) {
        return Marker(
          point: LatLng(
              double.parse(marche.latitude), double.parse(marche.longitude)),
          width: 50,
          height: 50,
          child: GestureDetector(
            onTap: () => _onMarkerTapped(marche.marche_id),
            child: Icon(
              Icons.location_on,
              size: 40,
              color: Colors.blue,
            ),
          ),
        );
      }).toList();
       // Vérifier le nombre de marqueurs créés
    print('Nombre de marqueurs : ${_markers.length}');
    });
  }

  List<String> _getImagesForMarche(int marcheId) {
    // Filtrer les images du marché sélectionné
    return _cartographieController.listeImagesMarches
        .where((marche) => marche.marche_id == marcheId)
        .map((marche) => marche.fichier)
        .toList();
  }
  ImageMarcheCartoModel _getImagesForMarcheId(int marcheId) {
    return _cartographieController.listeImagesMarches
        .firstWhere((marche) => marche.marche_id == marcheId);
  }

  void _onMarkerTapped(int marcheId) {
    // Récupérer la liste des images pour le marché sélectionné
    List<String> images = _getImagesForMarche(marcheId);
    print(_getImagesForMarcheId(marcheId).longitude);
    print(images);

    if (images.isEmpty) {
      Get.snackbar("Aucune image", "Ce marché n'a pas d'images disponibles.");
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 350,
          child: Column(
            children: [
              Text(
                "libellé:".toUpperCase(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              Text(
                "${_getImagesForMarcheId(marcheId).libelle}",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              Text(
                "montant:".toUpperCase(),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              Text(
                "250000",
                style: TextStyle(fontSize: 14),
              ),
              // Carrousel d'images avec PageView
              Expanded(
                child: PageView.builder(
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        '$imageUrl/imagemarches/${images[index]}',
                        width: double.infinity,
                        height: 40,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                              child: Icon(Icons.broken_image,
                                  size: 50, color: Colors.red));
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carte des livrables")),
      drawer: FiltreDrawer(),
      body: Column(
        children: [
          // Carte avec les marchés
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _center,
                zoom: 6.5,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(markers: _markers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
