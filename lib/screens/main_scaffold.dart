import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'itinerary_preferences_page.dart'; // Updated import
import 'profile_page.dart';
import 'image_recognition_page.dart';
import 'stats_page.dart';
import '../utils/constants.dart'; // For kPrimaryColor

class MainScaffoldWithBottomNavbar extends StatefulWidget {
  const MainScaffoldWithBottomNavbar({super.key});

  @override
  State<MainScaffoldWithBottomNavbar> createState() =>
      _MainScaffoldWithBottomNavbarState();
}

class _MainScaffoldWithBottomNavbarState
    extends State<MainScaffoldWithBottomNavbar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    ItineraryPreferencesPage(), // Updated page
    ProfilePage(),
    ImageRecognitionPage(),
    StatsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.map_pin_ellipse),
            label: 'Itinéraire',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.camera_viewfinder),
            label: 'Reconnaissance', // Shortened for better display
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar_square),
            label: 'Statistiques',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey, // Standard unselected color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
        showUnselectedLabels: true, // Shows labels for unselected items
      ),
    );
  }
}
