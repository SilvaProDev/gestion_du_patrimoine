import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/views/widgets/marche_input.dart';
import 'package:latlong2/latlong.dart';

import 'activite_input.dart';
import 'departement_input.dart';
import 'district_input.dart';
import 'region_input.dart';
import 'section_input.dart';
import 'sous_prefecture_input.dart';
import 'uo_input.dart';
import 'village_input.dart';

class FiltreDrawer extends StatefulWidget {
  
  const FiltreDrawer({super.key});

  @override
  State<FiltreDrawer> createState() => _FiltreDrawerState();
}

class _FiltreDrawerState extends State<FiltreDrawer> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  LatLng _center = LatLng(7.54, -5.55); // Côte d'Ivoire par défaut
  int? sectionId;
  int? uoId;
  int? activiteId;
  int? districtId;
  int? regionId;
  int? departementId;
  int? sousPrefectureId;
  int? villageId;
  int? marcheId;

  Future<void> _searchAddress() async {
    String address = _addressController.text;
    String city = _cityController.text;
    String fullAddress = "$address, $city";

    if (address.isEmpty && city.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(fullAddress);
      if (locations.isNotEmpty) {
        LatLng newLocation =
            LatLng(locations.first.latitude, locations.first.longitude);

        setState(() {
          _center = newLocation;
          _markers = [
            Marker(
              width: 40.0,
              height: 40.0,
              point: newLocation,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 40,
              ),
            ),
          ];
        });

        // Déplacer la carte vers la nouvelle position
        _mapController.move(_center, 12);
        Navigator.pop(context); // Fermer le Drawer après la recherche
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Adresse non trouvée : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                "Recherche Avancée",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    InputSection(
                      onSelected: (value) {
                        setState(() {
                          sectionId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputUoCartographie(
                      onSelected: (value) {
                        setState(() {
                          uoId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputActiviteCartographie(
                      onSelected: (value) {
                        setState(() {
                          activiteId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputDistrict(
                      onSelected: (value) {
                        setState(() {
                          districtId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputRegion(
                      onSelected: (value) {
                        setState(() {
                          regionId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputDepartement(
                      onSelected: (value) {
                        setState(() {
                          departementId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputSousPrefecture(
                      onSelected: (value) {
                        setState(() {
                          sousPrefectureId = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputVillage(
                      onSelected: (value) {
                        setState(() {
                          villageId = value;
                         
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputMarcheCartographie(
                      onSelected: (value) {
                        setState(() {
                          marcheId = value;
                           print("marche id $value");
                        });
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _searchAddress,
              child: Text("Rechercher"),
            ),
          ),
          SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
