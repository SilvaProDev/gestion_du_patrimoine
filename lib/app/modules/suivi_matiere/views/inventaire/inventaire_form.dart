import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/marche/models/activite_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/views/inventaire/widgets/input_uo_form.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/input_article_form.dart';
import 'widgets/input_field_form.dart';
import 'widgets/input_modele_form.dart';
import 'widgets/input_nature_form.dart';
import 'widgets/input_service_form.dart';

class InventaireForm extends StatefulWidget {
  const InventaireForm({Key? key}) : super(key: key);

  @override
  _InventaireFormState createState() => _InventaireFormState();
}

class _InventaireFormState extends State<InventaireForm> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _numeroSerieController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();
  final TextEditingController _couleurController = TextEditingController();
  InventaireController _inventaireController = Get.put(InventaireController());
  int? uaId;
  int? economiqueId;
  int? articleId;
  int? modeleId;
  int? serviceId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulaire d'inventaire", 
      style:TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontSize: 20),)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              InputFormServiceCf(
                onSelected: (value) {
                  setState(() {
                    serviceId = value;
                  });
                },
              ),
               SizedBox(
                height: 20,
              ),
              InputFormUo(
                onSelected: (value) {
                  setState(() {
                    uaId = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputNatureForm(
                onSelected: (value) {
                  setState(() {
                    economiqueId = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputArticleFom(
                onSelected: (value) {
                  setState(() {
                    articleId = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputModeleForm(
                onSelected: (value) {
                  setState(() {
                    modeleId = value;
                  });
                },
              ),
              
              SizedBox(
                height: 20,
              ),
              InputFieldWidget(
                hintext: 'N° de série', 
                controller: _numeroSerieController,
                ),
              // TextField(
              //   controller: _numeroSerieController,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     labelText: "N° de série",
              //     labelStyle: TextStyle(
              //     color: Colors.blue[700], 
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20)
              //   ),
              // ),
                SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                  child:InputFieldWidget(
                hintext: 'Quantité', 
                controller: _quantiteController,
                ),
                  
                ),
                  SizedBox(width: 10),
                      Expanded(
                  child:InputFieldWidget(
                hintext: 'Couleur', 
                controller: _couleurController,
                ),
                
                ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: null,
                  controller: _commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Informations complémentaires',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _inventaireController.registerInventor(
                      uaId: uaId!,
                      economiqueId: economiqueId!,
                      articleId: articleId!,
                      modeleId: modeleId!,
                      serviceId: serviceId!,
                      numeroSerie: _numeroSerieController.text,
                      infoComplementaire: _commentController.text,
                      couleur: _couleurController.text,
                      quantite: _quantiteController.text
                      );
                },
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: Colors.blue[300],
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10)),
                        child: Obx(() {
                              return _inventaireController.isLoading.value
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text('Enregistrer',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16));
                            }
                            ),
                // child: Text(
                //   "Enregistrer",
                //   style: TextStyle(
                //       color: Colors.white, fontWeight: FontWeight.bold),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
