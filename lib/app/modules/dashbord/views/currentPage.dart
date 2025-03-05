import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/dashbord.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/module_page.dart';
import 'package:gestion_patrimoine_dcf/app/pages/profile/profile_view.dart';

import 'home/liste_activite.dart';

class CurentPage extends StatefulWidget {
  const CurentPage({super.key});

  @override
  State<CurentPage> createState() => _CurentPageState();
}

class _CurentPageState extends State<CurentPage> {
  int _currentIndex = 0; // Keeps track of the selected tab

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    Dashbord(),
    ModulePage(),
    ProfileView(),
  ];
   void _changerPage(int index) {
    setState(() {
      _currentIndex = index; // Mettre à jour l'index sélectionné
    });
     // Ajouter une action spécifique si nécessaire
    switch (index) {
      case 0:
        // Dashbord;
        break;
      case 1:
        // ModulePage();
        break;
      case 2:
        // print('Profil tapé');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? Dashbord() 
          :  _currentIndex == 1 ? ModulePage()
          : ProfileView(),
           // Display the current page,

    
    );
  }
}