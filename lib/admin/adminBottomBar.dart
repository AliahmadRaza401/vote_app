import 'package:flutter/material.dart';
import '../task/fb_Con.dart';
import 'adminHome.dart';
import 'characterScreen.dart';

class AdminBottomNavigationBarScreen extends StatefulWidget {
  const AdminBottomNavigationBarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminBottomNavigationBarScreenState createState() =>
      _AdminBottomNavigationBarScreenState();
}

class _AdminBottomNavigationBarScreenState
    extends State<AdminBottomNavigationBarScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeAdminScreen(),
    AdminCharacterScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.how_to_vote),
                label: 'Character',
                backgroundColor: Colors.white),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
