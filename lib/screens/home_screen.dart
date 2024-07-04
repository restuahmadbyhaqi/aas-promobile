import 'package:flutter/material.dart';
import 'package:mobile/screens/getData/getdata_screen.dart';
import 'package:mobile/screens/profile/profle_screen.dart';
import 'package:mobile/screens/toDoList/todolist_screen.dart';
import 'package:mobile/screens/webview_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    try {
      User? userData = Provider.of<AuthProvider>(context, listen: false).user;
      if (userData != null) {
        user = await Provider.of<AuthProvider>(context, listen: false)
            .fetchUserById(userData.userId);
      }
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;

    if (user == null) {
      return LoginScreen();
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
            ),
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Kelompok 4',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: user?.image != null
                          ? NetworkImage(user!.image!)
                          : null,
                      child: user?.image == null
                          ? Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Hi, ${user.name}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                _buildMenuItem(Icons.image, 'Gallery', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetDataScreen()),
                  );
                }),
                _buildMenuItem(Icons.web, 'Web View', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WebViewScreen()),
                  );
                }),
                _buildMenuItem(Icons.person, 'Profile', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                }),
                _buildMenuItem(Icons.edit, 'ToDoList', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TodolistScreen()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
