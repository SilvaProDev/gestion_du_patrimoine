import 'package:flutter/material.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/widgets/head_drawer.dart';
import 'package:gestion_patrimoine_dcf/app/modules/dashbord/views/home/widgets/text_icon_botton.dart';
import 'package:get/get.dart';

import '../../../auth/controllers/authentification.dart';
import '../dashbord.dart';
import '../home/widgets/my_profile.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
   final AuthentificationController _authentificationController = Get.put(AuthentificationController());

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header part of the drawer
          InkWell(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ),
            ),
            child: EnteteDrawer(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextIconButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => const Dashbord(),
                    ),
                  ),
                  icon: Icons.home,
                  label: 'Accueil',
                ),
                const TextIconButton(
                  icon: Icons.shopping_cart,
                  label: 'Traités',
                ),
                const TextIconButton(
                  icon: Icons.wallet_giftcard,
                  label: 'Non traités',
                ),
                const TextIconButton(
                  icon: Icons.settings,
                  label: 'Hors delai',
                ),
                const Divider(
                  height: 50,
                  color: Colors.black,
                  thickness: 1,
                ),
                TextIconButton(
                  onPressed: () async {
                   await _authentificationController.logout();
                  },
                  icon: Icons.logout,
                  label: 'Se déconnecter',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

