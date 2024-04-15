import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF757575),
      selectedItemColor: const Color(0xFFF89A1C),
      unselectedItemColor: Colors.white,
      unselectedFontSize: 17,
      selectedFontSize: 17,
      unselectedLabelStyle: const TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w500),
      selectedLabelStyle: const TextStyle(fontFamily: "Raleway", fontWeight: FontWeight.w500),
      onTap: (index) {
        if (!(index == currentIndex)) {
          index == 0 ? Navigator.pushNamed(context, "/programs") : Navigator
              .pushNamed(context, "/home");
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: "Programs",
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
          label: "Home"
        )
      ],
    );
  }
}
