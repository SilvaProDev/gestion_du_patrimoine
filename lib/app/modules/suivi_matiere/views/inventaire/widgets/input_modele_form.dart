import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/modele_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/nature_model.dart';
import 'package:get/get.dart';

class InputModeleForm extends StatefulWidget {
  const InputModeleForm({Key? key, required this.onSelected,}) : super(key: key);
  final Function(int?) onSelected; //fonction qui envoie l id au parent

  @override
  _InputModeleFormState createState() => _InputModeleFormState();
}

class _InputModeleFormState extends State<InputModeleForm> {
  InventaireController _inventaireController = Get.put(InventaireController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getModeles();
    });
  }

  // Fonction pour obtenir les suggestions
  List<ModeleArticleModel> _getSuggestions(String query) {
    return _inventaireController.listeModeleArticle
        .where((item) =>
            item.libelleModele!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(ModeleArticleModel suggestion) {
    setState(() {
      selectedItem = (suggestion.modeleId ?? 0) as int?;
      _controller.text =
          suggestion.libelleModele ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<ModeleArticleModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _inventaireController.getModeles();
                _controller.clear();
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Modèle",
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
                    suggestion.libelleModele ?? '',
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
