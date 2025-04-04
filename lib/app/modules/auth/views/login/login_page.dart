import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gestion_patrimoine_dcf/app/modules/auth/controllers/authentification.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../layout/background_image.dart';
import '../../../../layout/layout.dart';
import '../../../dashbord/views/marque_texte.dart';
import '../widgets/input_widget.dart';
import '../widgets/password_widget.dart';
import '../widgets/reset_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 final AuthentificationController _authentificationController =
      Get.put(AuthentificationController());
  bool _isObscured = true; //rend le mot de passe visible ou invisible
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
                child: Column(
              children: [
                Container(height: 40,),
                Container(
                  child: MarqueePage(),
                   height: 60,
                ),
                SizedBox(height: 20,),
                Text("Se connecter", style: kHeading),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      InputWidget(
                        hintext: 'Email',
                        controller: _emailController,
                        obscureText: false,
                        icon: Icon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      PasswordInput(
                        hintext: 'Password',
                        controller: _passwordController,
                        obscureText: _isObscured ? true : false,
                        icon: Icon(
                          FontAwesomeIcons.lock,
                          color: Colors.white,
                          size: 20,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured; // Toggle the state
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                           Get.to(() => ResetPasswordPage()); // Remplace avec ta page de récupération
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 6, left: 140),
                          child: Text(
                            "Mot de passe oublié ?",
                            style: TextStyle(
                               color: Colors.white,
                               fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(16)),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10)),
                              child: Obx(() {
                                return _authentificationController.isLoading.value
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Text('Connexion',
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16));
                              }),
                              onPressed: () async {
                                await _authentificationController.login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim());
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
          ),
        )
      ],
    );
  }
}
