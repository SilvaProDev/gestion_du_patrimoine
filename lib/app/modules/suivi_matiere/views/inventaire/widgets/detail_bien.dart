import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/image_bien_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'form_bien_imagerie.dart';
import 'image_bien.dart';

class DetailBien extends StatefulWidget {
  const DetailBien({super.key});

  @override
  State<DetailBien> createState() => _DetailBienState();
}

class _DetailBienState extends State<DetailBien> {
  final ImageBienController _imageBienController = Get.put(ImageBienController());
  final args = Get.arguments;
  late int index;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _imageBienController.getImageBien(args['articleId']);
    });
    index = 0;
  }

  //Permet de changer de menu
  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8.5,
        backgroundColor: Colors.blue[400],
        title: Text(
          'Détail du bien',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Get.to(ImageFormBien(
                   stockArticleId: args['bienId'],
                   articleId: args['articleId'],
                  // longitude: _localisation.longitude.value,
                  // latitude: _localisation.latitude.value,
                ));
              })
        ],
      ),
      body: Column(
  children: [
    Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Libellé:',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14),
                ),
              ),
              Expanded(
                child: Text(
                  args['libelleBien'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Numéro de série',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14),
                ),
              ),
              Text(
                args['numeroSerie'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    const SizedBox(height: 20),
    // Ajout de Expanded pour gérer correctement l'espace restant
    Expanded(
      child: index == 0
          ? Obx(() {
              return _imageBienController.imageBien.isEmpty
                  ? const Center(
                      child: Text("Aucune image trouvée",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: _imageBienController.imageBien.length,
                      itemBuilder: (context, index) {
                        return ImageBien(
                          imageBien: _imageBienController.imageBien[index],
                        );
                      },
                    );
            })
          : const Center(child: Text('Vidéos')),
    )
  ],
),

      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Images',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            label: 'Vidéos',
          )
        ],
        onTap: switchIndex,
      ),
    );
  }
}
