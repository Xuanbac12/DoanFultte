import 'package:doan1/pages/ContextPage.dart';
import 'package:doan1/pages/FoodDetailsPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //food menu
  List foodMenu = [
    //Học tiếng anh theo chủ đề
    Food(
      name: "Học tiếng anh theo chủ đề",
      imagePath: "lib/images/hi.png",
    ),
    Food(
      name: "Học tiếng anh theo ngữ cảnh",
      imagePath: "lib/images/hi1.png",
    ),
  ];

  final pageOpen = [
    FoodDetailsPage(),
    ContextPage(),
  ];

  //navigate to food item details page
  void navigateToFoodDetials(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pageOpen[index]),
    );
  }

  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Luffy',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.grey[900],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 133, 60, 55),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.all(35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //promo message
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Xin Chào',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 194, 120, 120),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // //redeem button
                        Text(
                          currentUser.email!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 230, 216, 216),
                          ),
                        ),
                      ],
                    ),

                    // MyButton(
                    //   onTap: (){},
                    //   text: "Redeem")
                  ],
                ),

                //image
                Image.asset(
                  'lib/images/chibichu.png',
                  height: 100,
                )
              ],
            ),
          ),

          const SizedBox(height: 25),

          //search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 0, 0, 0), width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: const Color.fromARGB(255, 214, 222, 214),
                      width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Search here...",
                hintStyle:
                    TextStyle(color: const Color.fromARGB(255, 158, 158, 158)),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),

          const SizedBox(height: 25),

          //menu list
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Danh mục",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 200, // Set a fixed height or calculate dynamically
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodMenu.length,
                      itemBuilder: (context, index) => FoodTile(
                        food: foodMenu[index],
                        onTap: () => navigateToFoodDetials(index),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                //popular food
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //image
                      Row(
                        children: [
                          Image.asset(
                            'lib/images/chude.png',
                            height: 60,
                          ),
                          const SizedBox(width: 20),
                          //name
                          Text(
                            "Salmon Eggs",
                            style: GoogleFonts.dmSerifDisplay(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(width: 30),
                      const Icon(
                        Icons.favorite_outline,
                        color: Colors.grey,
                        size: 28,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Food {
  final String name;
  final String imagePath;

  Food({required this.name, required this.imagePath});
}

class FoodTile extends StatelessWidget {
  final Food food;
  final Function onTap;

  FoodTile({required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              food.imagePath,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5),
            Text(
              food.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
