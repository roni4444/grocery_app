import 'package:flutter/material.dart';
import 'package:grocery_app/screens/Cart_screen.dart';
import 'package:grocery_app/screens/Home_screen.dart';

class MyBottomNavigationWidget extends StatefulWidget {
  @override
  _MyBottomNavigationWidgetState createState() =>
      _MyBottomNavigationWidgetState();
}

class _MyBottomNavigationWidgetState extends State<MyBottomNavigationWidget> {
  int _selectedIndex = 0;

  void itemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      } else if (index == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          )
        ],
        backgroundColor: Colors.green,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        onTap: itemTapped);
  }
}
