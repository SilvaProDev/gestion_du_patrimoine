import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/controllers/image_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/header_detail.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_form.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/image_marche.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/views/widgets/video_marche.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBien extends StatefulWidget {
  const DetailBien({super.key});

  @override
  State<DetailBien> createState() => _DetailBienState();
}

class _DetailBienState extends State<DetailBien> {
  final InventaireController _inventaireController = Get.put(InventaireController());
  final args = Get.arguments;
  late int index;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _imageController.getImageParMarche(args['marcheId']);
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
                // Get.to(ImageForm(
                //   marcheId: args['marcheId'],
                //   longitude: _localisation.longitude.value,
                //   latitude: _localisation.latitude.value,
                // ));
              })
        ],
      ),
      body: Column(
        children: [
         Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    args['libelleBien'],
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400], 
                      fontSize: 16),
                  ),
                ),
               
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Numéro de serie',
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
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    ),
         // Expanded(
              // child: index == 0
              //     ? Obx(() {
              //         return _imageController.imageMarche.isEmpty
              //             ? Center(
              //                 child: Text("Aucune image trouvée",
              //                     style: TextStyle(
              //                         color: Colors.red,
              //                         fontSize: 25,
              //                         fontWeight: FontWeight.bold)))
              //             : GridView.builder(
              //                 gridDelegate:
              //                     const SliverGridDelegateWithFixedCrossAxisCount(
              //                   crossAxisCount: 2,
              //                   crossAxisSpacing: 1,
              //                 ),
              //                 itemCount: _imageController.imageMarche.length,
              //                 itemBuilder: (context, index) {
              //                   return ImageMarche(
              //                     imageMarche:
              //                         _imageController.imageMarche[index],
              //                   );
              //                 },
              //               );
              //       })
              //     : VideoMarche()
              //    )
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
