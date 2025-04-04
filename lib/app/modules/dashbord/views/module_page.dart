import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/controllers/info_dossier.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/liste_module.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/my_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ModulePage extends StatefulWidget {
  const ModulePage({
    super.key,
  });

  @override
  State<ModulePage> createState() => _ModulePageState();
}

class _ModulePageState extends State<ModulePage> {
  final AuthentificationController _authentificationController =
      Get.put(AuthentificationController());
 
      
  @override
  void initState() {
    
    super.initState();
  }

List<Map<String, dynamic>> listeModule = [
  {"id": 1, "libelle": "Marché"},
  {"id": 2, "libelle": "Rapport"},
  {"id": 3, "libelle": "Suivi des matières"},
  {"id": 4, "libelle": "Cartographie"},
  {"id": 5, "libelle": "Hors ligne"},
];

  @override
  Widget build(BuildContext context) {
  // TextEditingController searchController TextEditingController();
    DateTime dateDuJour = DateTime.now(); //La date du jour
    String formateDate = DateFormat("dd/MM/yyyy").format(dateDuJour);

    return Scaffold(
      backgroundColor: Colors.blue[800],
      drawer: MyDrawer(),
      body: SafeArea(
                      child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, top: 25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                 
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: 
                                        NetworkImage('${imageUrl}/${_authentificationController.user.value?.photo}') == 
                                        NetworkImage('${imageUrl}/default.png') ? 
                                        AssetImage("assets/images/default-profil.jpg")
                                        :NetworkImage('${imageUrl}/${_authentificationController.user.value?.photo}')
                                      ),
                                      Text(
                                        _authentificationController
                                            .user.value?.userName as String,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "$formateDate",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
             
                                ],
                              ),

  
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                             padding: EdgeInsets.all(25.0),
                            // color: Colors.grey[100],
                            child: Center(
                              child: Column(
                                children: [
                                  //exercice
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Liste des modules",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  //List view
                                  Expanded(
                                      child:  GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 1.1,
                                                      mainAxisSpacing: 8),
                                              itemCount: listeModule.length,
                                              itemBuilder: (context, index) {
                                                return ListeModule(
                                                  icon: 
                                                  index==1 ? Icons.badge
                                                  :index ==0 ? (Icons.view_compact_alt_sharp)
                                                  :index ==2 ? (Icons.autorenew_outlined )
                                                  :index ==3 ? (Icons.map_rounded )
                                                  :Icons.offline_bolt_outlined,
                                                  numero: index,
                                                  backgroundColor: 
                                                  index ==0  ? Colors.yellow[200]
                                                  :index ==1 ? Colors.blue[200]
                                                  :index ==2 ? Colors.red[200]
                                                  :index ==3 ? Colors.green[200]
                                                  : Colors.grey[200],
                                                  libelle:listeModule[index]["libelle"],
                                                );
                                              }
                                              )
                                              )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    )
           
  
    );
  }
}
