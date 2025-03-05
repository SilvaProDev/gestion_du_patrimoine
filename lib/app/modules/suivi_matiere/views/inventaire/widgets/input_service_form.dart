import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/uo_model.dart';
import 'package:get/get.dart';

import '../../../models/servicecf_model.dart';

class InputFormServiceCf extends StatefulWidget {
  const InputFormServiceCf({ Key? key,
      required this.onSelected,
    }) : super(key: key);

  final Function(int?) onSelected; //fonction qui envoie l id de l uo au parent
  @override
  _InputFormServiceCfState createState() => _InputFormServiceCfState();
}

class _InputFormServiceCfState extends State<InputFormServiceCf> {
 final InventaireController _inventaireController = Get.put(InventaireController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getListeService();
    });
  }

  // Fonction pour obtenir les suggestions
  List<SeriviceCfModel> _getSuggestions(String query) {
    return _inventaireController.listeServiceCf
        .where((item) =>
            item.libelleService!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(SeriviceCfModel suggestion) {
    setState(() {
      selectedItem = (suggestion.serviceId ?? 0) as int?;
      _controller.text =suggestion.libelleService ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<SeriviceCfModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _controller.clear();
                _inventaireController.getListeService();
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Service CF",
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
                    suggestion.libelleService ?? '',
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
