import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/sous_prefecture.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/uo_model.dart';
import 'package:get/get.dart';

import '../../controllers/cartographie.dart';

class InputSousPrefecture extends StatefulWidget {
  const InputSousPrefecture({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(int?) onSelected; //fonction qui envoie l id de l uo au parent
  @override
  _InputSousPrefectureState createState() => _InputSousPrefectureState();
}

class _InputSousPrefectureState extends State<InputSousPrefecture> {
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
  List<SousPrefectureModel> _getSuggestions(String query) {
    return _cartographieController.listeSousPrefecture
        .where((item) => item.libelleSousPrefecture!
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(SousPrefectureModel suggestion) {
    setState(() {
      _cartographieController.getVillageParSousPrefecture(suggestion.id);
      _cartographieController.getListeMarche(suggestion.id);
      selectedItem = (suggestion.id ?? 0) as int?;
      _controller.text = suggestion.libelleSousPrefecture ??
          ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<SousPrefectureModel>(
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
                  labelText: "Sous préfecture",
                  suffixIcon: const Icon(Icons.clear),
                  labelStyle: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            );
          },
          suggestionsCallback: _getSuggestions,
          itemBuilder: (context, suggestion) {
            return Column(
              children: [
                ListTile(
                  title: Text(
                    suggestion.libelleSousPrefecture ?? '',
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
