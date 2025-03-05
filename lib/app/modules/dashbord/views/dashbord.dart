import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_patrimoine_dcf/app/constants/constants.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/controllers/info_dossier.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/module_page.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/grille_nature_dossier.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/liste_nature_dossier.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/my_drawer.dart';
import 'package:gestion_patrimoine_dcf/app/pages/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class Dashbord extends StatefulWidget {
  const Dashbord({
    super.key,
  });

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  int _selectedView = 1; //  2= GridView, 1 = ListView
  int _currentIndex = 0; // Index de l'élément sélectionné
  final AuthentificationController _authentificationController =
      Get.put(AuthentificationController());
  final InfoDossierController _infoDossierController =
      Get.put(InfoDossierController());
      
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _infoDossierController.getAllTypeDossier();
    });
    super.initState();
  }

  void _changerPage(int index) {
    setState(() {
      _currentIndex = index; // Mettre à jour l'index sélectionné
    });
    // Ajouter une action spécifique si nécessaire
    if (index==0) {
      
    }
    switch (index) {
      case 0:
        Dashbord;
        break;
      case 1:
        ModulePage();
        break;
      case 2:
        print('Profil tapé');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
  // TextEditingController searchController TextEditingController();
    DateTime dateDuJour = DateTime.now(); //La date du jour
    String formateDate = DateFormat("dd/MM/yyyy").format(dateDuJour);

    return Scaffold(
      backgroundColor: Colors.blue[800],
      drawer: MyDrawer(),
      body: _currentIndex == 0
          ? Obx(() {
              return _infoDossierController.isLoading.value
                  ? Container(
                      color: Colors.blue[400], // Couleur de fond
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white, // Couleur de l'indicateur
                        ),
                      ),
                    )
                  : SafeArea(
                      child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, top: 25),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      return IconButton(
                                        icon: Icon(Icons.menu,
                                            color: Colors.white),
                                        onPressed: () {
                                          Scaffold.of(context)
                                              .openDrawer(); // Ouvre le Drawer
                                        },
                                      );
                                    },
                                  ),
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
                                            color: Colors.blue[100],
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[600],
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: badges.Badge(
                                      showBadge: true,
                                      ignorePointer: false,
                                      badgeContent: Text(
                                        '5',
                                        // Nombre du badge
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      child:  Icon(
                                        Icons.notifications,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      position: badges.BadgePosition.topEnd(
                                          top: -10, end: -10),
                                      badgeAnimation:
                                          badges.BadgeAnimation.slide(
                                        animationDuration: Duration(seconds: 1),
                                        colorChangeAnimationDuration:
                                            Duration(seconds: 1),
                                        loopAnimation: false,
                                        curve: Curves.fastOutSlowIn,
                                        colorChangeAnimationCurve:
                                            Curves.easeInCubic,
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        shape: badges.BadgeShape.square,
                                        badgeColor: Colors.red,
                                        padding: EdgeInsets.all(5),
                                        borderRadius: BorderRadius.circular(4),
                                        elevation: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  onChanged: (value) {
                                      _infoDossierController.query.value = value;
                                      _infoDossierController.searchDossier(value);
                                    },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(0, 20, 16, 10),
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                      hintText: 'Recherche...'),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  
                                 Expanded(
                              child: Column(
                                children: [
                                  Container(
                                     height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.8), // Bleu avec 50% de transparence
                                      shape: BoxShape.circle,
                                    ),
                                  //  margin: EdgeInsets.all(3), // Espacement autour
                                    child: Center(
                                      child: Container(
                                        child: Text(
                                          "12500",
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text('Traité', 
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              ),
                                 Expanded(
                              child: Column(
                                children: [
                                  Container(
                                     height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.8), // Bleu avec 50% de transparence
                                      shape: BoxShape.circle,
                                    ),
                                    margin: EdgeInsets.all(5), // Espacement autour
                                    child: Center(
                                      child: Text(
                                        "200",
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Text('Encours', 
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              ),
                                 Expanded(
                              child: Column(
                                children: [
                                  Container(
                                     height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.8), // Bleu avec 50% de transparence
                                      shape: BoxShape.circle,
                                    ),
                                  //  margin: EdgeInsets.all(5), // Espacement autour
                                    child: Center(
                                      child: Text(
                                        "150",
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  Text('Hors délai', 
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                              ),
                    
                              
                                  PopupMenuButton(
                                      elevation: 5,
                                      icon: Icon(
                                        Icons.sort,
                                        color: Colors.white,
                                      ),
                                      onSelected: (value) {
                                        setState(() {
                                          _selectedView = value;
                                        });
                                      },
                                      offset: Offset(0, 40),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text("Par liste"),
                                              value: 1,
                                            ),
                                            PopupMenuItem(
                                              child: Text("Grille"),
                                              value: 2,
                                            ),
                                          ])
                                ],
                              ),
                              SizedBox(
                                height: 25,
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
                                        "Mes dossiers traités",
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
                                      child: _selectedView == 1
                                          ? ListView.builder(
                                              itemCount: _infoDossierController
                                                  .filterDossiers.length,
                                              itemBuilder: (context, index) {
                                                return ListeNatureDossier(
                                                    icon: _infoDossierController
                                                                .filterDossiers[index]
                                                                .typeDossier ==
                                                            12
                                                        ? Icons.person
                                                        : _infoDossierController
                                                                    .filterDossiers[
                                                                        index]
                                                                    .typeDossier ==
                                                                13
                                                            ? Icons.access_alarm
                                                            : Icons.abc_sharp,
                                                    typeDossier:
                                                        _infoDossierController
                                                            .filterDossiers[index],
                                                    color: _infoDossierController
                                                                .filterDossiers[index]
                                                                .typeDossier ==
                                                            6
                                                        ? Colors.deepPurple
                                                        : _infoDossierController
                                                                    .filterDossiers[
                                                                        index]
                                                                    .typeDossier ==
                                                                7
                                                            ? const Color
                                                                .fromARGB(
                                                                255, 65, 3, 83)
                                                            : Colors.blue[100]);
                                              },
                                            )
                                          : GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      childAspectRatio: 1.1,
                                                      mainAxisSpacing: 8),
                                              itemCount: _infoDossierController
                                                  .filterDossiers.length,
                                              itemBuilder: (context, index) {
                                                return GrilleNatureDossier(
                                                  icon: Icons.badge,
                                                  backgroundColor:
                                                      Colors.blue[200],
                                                  typeDossier:
                                                      _infoDossierController
                                                          .filterDossiers[index],
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
                    );
            }
            )
          : _currentIndex == 1
              ? ModulePage()
              : ProfileView(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Index sélectionné
          onTap: _changerPage, // Gestion des clics
          selectedItemColor: Colors.blue, // Couleur de l'élément sélectionné
          unselectedItemColor:
              Colors.grey, // Couleur des éléments non sélectionnés
          backgroundColor: Colors.white, // Couleur de fond
          selectedLabelStyle: TextStyle(fontSize: 16),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.solidMoon,
                ),
                label: 'Modules'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Compte'),
          ]),
    );
  }
}
