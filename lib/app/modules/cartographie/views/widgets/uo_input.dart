import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/cartographie/controllers/cartographie.dart';
import 'package:get/get.dart';

import '../../models/unite_operationnelle.dart';

class InputUoCartographie extends StatefulWidget {
  const InputUoCartographie({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(int?) onSelected; //fonction qui envoie l id de l uo au parent
  @override
  _InputUoCartographieState createState() => _InputUoCartographieState();
}

class _InputUoCartographieState extends State<InputUoCartographie> {
  CartographieController _cartographieController =
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
  List<UniteOperationnelleModel> _getSuggestions(String query) {
      return _cartographieController.listeUniteOperationnelle
          .where((item) =>
              item.libelleUo!.toLowerCase().contains(query.toLowerCase()))
          .toList();
   
  }

  void _onItemSelected(UniteOperationnelleModel suggestion) {
    setState(() {
      _cartographieController.getActiviteParUo(suggestion.id);
      selectedItem = (suggestion.id ?? 0) as int?;
      print("hello uo $selectedItem");
      _controller.text =
          suggestion.libelleUo ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<UniteOperationnelleModel>(
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
                  labelText: "Unité Opératinnelle",
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
                    suggestion.libelleUo ?? '',
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
