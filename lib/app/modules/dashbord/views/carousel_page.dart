import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'currentPage.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final PageController controller = PageController();

  List<String> images = [
    "assets/images_codes_ethique/code1.jpg",
    "assets/images_codes_ethique/code2.jpg",
    "assets/images_codes_ethique/code3.jpg",
    "assets/images_codes_ethique/code4.jpg",
    "assets/images_codes_ethique/code5.jpg",
    "assets/images_codes_ethique/code6.jpg",
    "assets/images_codes_ethique/code1.jpg",
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(90.0), // Augmente la hauteur
  child: AppBar(
    title:  Padding(
          padding: const EdgeInsets.only(top: 12, left: 18),
          child: Text(
            maxLines: 2,
            "code d'éthique et de la déonthologie".toUpperCase(),
            style: TextStyle(color: Colors.black),),
        ),
    centerTitle: true,
    
    backgroundColor: Colors.orangeAccent,
  ),
),
      // appBar: AppBar(
        
      //   elevation: 5,
      //   backgroundColor: Colors.orangeAccent,
      //   title:  Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text(
      //       maxLines: 2,
      //       "code d'éthique et de la déonthologie".toUpperCase(),
      //       style: TextStyle(color: Colors.black),),
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            width: double.infinity,
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index % images.length;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 320,
                    width: double.infinity,
                    
                    child: Image.asset(
                      images[index % images.length],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < images.length; i++)
                buildIndicator(currentIndex == i)
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (currentIndex > 0) {
                      controller.jumpToPage(currentIndex - 1);
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    if (currentIndex < images.length - 1) {
                      controller.jumpToPage(currentIndex + 1);
                    }
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            
               child: ElevatedButton(
              onPressed: () {
                 Get.offAll(() => const CurentPage());
              },
              style: ElevatedButton.styleFrom(
                elevation: 3,
                backgroundColor: Colors.green[600],
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Pour éviter que le bouton prenne toute la largeur
            children: [
              Icon(Icons.login, color: Colors.white), // Icône
              SizedBox(width: 8), // Espacement entre l'icône et le texte
              Text("Dashbord",
                style: TextStyle(color: Colors.white, 
                fontWeight: FontWeight.bold,
                fontSize: 16),
              ),
            ],
          ),
          )
            )
        ],
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 10,
        width: isSelected ? 12 : 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
