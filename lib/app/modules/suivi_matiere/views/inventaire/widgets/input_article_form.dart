import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/controllers/inventaire_controller.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/article_model.dart';
import 'package:gestion_patrimoine_dcf/app/modules/suivi_matiere/models/nature_model.dart';
import 'package:get/get.dart';

class InputArticleFom extends StatefulWidget {
  const InputArticleFom({Key? key, required this.onSelected}) : super(key: key);
  final Function(int?) onSelected; //fonction qui envoie l id au parent

  @override
  _InputArticleFomState createState() => _InputArticleFomState();
}

class _InputArticleFomState extends State<InputArticleFom> {
  InventaireController _inventaireController = Get.put(InventaireController());
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  int? selectedItem;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inventaireController.getArticle();
    });
  }

  // Fonction pour obtenir les suggestions
  List<ArticleModel> _getSuggestions(String query) {
    return _inventaireController.listeArticle
        .where((item) =>
            item.libelleArticle!.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void _onItemSelected(ArticleModel suggestion) {
    setState(() {
  
      selectedItem = (suggestion.articleId ?? 0) as int?;
      _controller.text =
          suggestion.libelleArticle ?? ''; // Affiche le libellé dans le champ
    });
    widget.onSelected(selectedItem != 0 ? selectedItem : null);
    _focusNode.unfocus(); // Ferme le clavier après sélection
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<ArticleModel>(
          controller: _controller,
          focusNode: _focusNode,
          builder: (context, controller, focusNode) {
            return TextField(
              onTap: () {
                _controller.clear();
                _inventaireController.getArticle();
              },
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Article",
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
                    suggestion.libelleArticle ?? '',
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
