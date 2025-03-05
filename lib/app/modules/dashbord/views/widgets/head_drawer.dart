import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../auth/controllers/authentification.dart';

class EnteteDrawer extends StatefulWidget {
  const EnteteDrawer({super.key});

  @override
  State<EnteteDrawer> createState() => _EnteteDrawerState();
}

class _EnteteDrawerState extends State<EnteteDrawer> {
  final AuthentificationController _authentificationController =
      Get.put(AuthentificationController());

  void initState() {
    _authentificationController.user_role.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.only(
          top: 40,
          bottom: 30,
        ),
        color: const Color(0xff3444B5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 60,
                backgroundImage: 
                NetworkImage('${imageUrl}/${_authentificationController.user.value?.photo}') == 
                NetworkImage('${imageUrl}/default.png') ? 
                AssetImage("assets/images/default-profil.jpg")
                :NetworkImage('${imageUrl}/${_authentificationController.user.value?.photo}')
              ),
            const SizedBox(height: 15),
            Text(
              _authentificationController.user.value?.userName as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.swift, color: Colors.white),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _authentificationController.user_role.value,
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
