import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/village.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/uo_model.dart';
import 'package:get/get.dart';

import '../../controllers/cartographie.dart';

class InputVillage extends StatefulWidget {
  const InputVillage({ Key? key,
      required this.onSelected,
    }) : super(key: key);

  final Function(int?) onSelected; //fonction qui envoie l id de l uo au parent
  @override
  _InputVillageState createState() => _InputVillageState();
}

class _InputVillageState extends State<InputVillage> {
   final CartographieController _cartographieController =
      Get.put(CartographieController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _cartographieController.getListeUoParService();
    });
  }

  // Fonction pour obtenir les suggestions
  List<VillageModel> _getSuggestions(String query) {
    return _cartographieController.listeVillage
        .where((item) =>
            item.libelleVillage!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(VillageModel suggestion) {
    setState(() {
      selectedItem = (suggestion.id ?? 0) as int?;
      _controller.text =suggestion.libelleVillage ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<VillageModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _controller.clear();
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Villages",
                suffixIcon: const Icon(Icons.clear),
               
                labelStyle: TextStyle(
                  color: Colors.blue[700], 
                  fontWeight: FontWeight.bold,
                  fontSize: 20)
              ),
            );
          },
          suggestionsCallback: _getSuggestions,
          itemBuilder: (context, suggestion) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    suggestion.libelleVillage ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                    height: 1, color: Colors.grey), // Ligne de séparation
              ],
            );
          },

          onSelected: _onItemSelected,
          // noItemsFoundBuilder: (context) => const Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Text("Aucun résultat trouvé"),
          // ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
