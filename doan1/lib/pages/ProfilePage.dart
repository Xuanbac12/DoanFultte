import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Current user
  final currentUser = FirebaseAuth.instance.currentUser!;
  String fullName = '';
  String userImage = '';

  @override
  void initState() {
    super.initState();
    _loadUserInfo(); // Load shared_preferences data
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('fullName') ?? currentUser.email!;
      userImage = prefs.getString('userImage') ?? 'assets/images/conkhi.jpg';
    });
  }

  // Sign out method
  Future<void> signUserOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear shared_preferences
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
                onTap: () {},
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Thông Tin Cá Nhân",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            //color: Color.fromARGB(255, 133, 60, 55),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[50],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile information
            Container(
              height: 210,
              width: MediaQuery.of(context).size.width * 0.85,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 133, 60, 55),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person, // Icon bạn muốn sử dụng
                      size: 50, // Kích thước của icon
                      color: Colors.grey, // Màu sắc của icon
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    fullName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 194, 120, 120),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    currentUser.email!,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromARGB(255, 219, 212, 212)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildListTile(
                    icon: Icons.person_outline,
                    title: "Hồ Sơ",
                    onTap: () {
                      // Navigate to Profile details page
                    },
                  ),
                  _buildListTile(
                    icon: Icons.settings,
                    title: "Cài Đặt",
                    onTap: () {
                      // Navigate to Settings page
                    },
                  ),
                  _buildListTile(
                    icon: Icons.policy,
                    title: "Chính Sách",
                    onTap: () {
                      // Navigate to Policies page
                    },
                  ),
                  _buildListTile(
                    icon: Icons.info_outline,
                    title: "Giới Thiệu Về Ứng Dụng",
                    onTap: () {
                      // Navigate to About page
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => signUserOut(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 200, 193, 193),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Đăng Xuất",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for list tiles
  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
