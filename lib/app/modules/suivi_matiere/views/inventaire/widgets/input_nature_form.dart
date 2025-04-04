import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/nature_model.dart';
import 'package:get/get.dart';

class InputNatureForm extends StatefulWidget {
  const InputNatureForm({Key? key, required this.onSelected}) : super(key: key);
  final Function(int?) onSelected; //fonction qui envoie l id au parent

  @override
  _InputNatureFormState createState() => _InputNatureFormState();
}

class _InputNatureFormState extends State<InputNatureForm> {
  InventaireController _inventaireController = Get.put(InventaireController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getNatureEconomiqueClasse2();
    });
  }

  // Fonction pour obtenir les suggestions
  List<NatureEconomiqueModel> _getSuggestions(String query) {
    return _inventaireController.listeNatureEconomique
        .where((item) =>
            item.libelleLigne!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(NatureEconomiqueModel suggestion) {
    setState(() {
      selectedItem = (suggestion.ligneId ?? 0) as int?;
      _controller.text =
          suggestion.libelleLigne ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<NatureEconomiqueModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _controller.clear();
                _inventaireController.getNatureEconomiqueClasse2();
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Nature économique",
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
                    suggestion.libelleLigne ?? '',
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
