import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/controllers/cartographie.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/models/activite.dart';
import 'package:get/get.dart';


class InputActiviteCartographie extends StatefulWidget {
  const InputActiviteCartographie({
    super.key,
    required this.onSelected,
  });

  final Function(int?) onSelected; //fonction qui envoie l id de l uo au parent
  @override
  _InputActiviteCartographieState createState() => _InputActiviteCartographieState();
}

class _InputActiviteCartographieState extends State<InputActiviteCartographie> {
  final CartographieController _cartographieController =
      Get.put(CartographieController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _cartographieController.getListeSection();
    });
  }

  // Fonction pour obtenir les suggestions
  List<ActiviteModel> _getSuggestions(String query) {
      return _cartographieController.listeActivite
          .where((item) =>
              item.libelleActivite!.toLowerCase().contains(query.toLowerCase()))
          .toList();

  }

  void _onItemSelected(ActiviteModel suggestion) {
    setState(() {
      _cartographieController.getDistrictParActivite(suggestion.id);
      selectedItem = (suggestion.id ?? 0) as int?;
      _controller.text =
          suggestion.libelleActivite ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<ActiviteModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _controller.clear();
                _cartographieController.getActiviteParUo(selectedItem);
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Activité",
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
                    suggestion.libelleActivite ?? '',
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
