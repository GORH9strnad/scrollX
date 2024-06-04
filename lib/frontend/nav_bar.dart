import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.purple,
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                "ScrollX",
                style: TextStyle(
                  fontSize: 48
                ),
              ),
            ),
            ListTile(
              // leading: Image.asset('img/btn_prace_icon.png'),
              title: const Text('Continue watching'),
              titleTextStyle: const TextStyle(fontSize: 24),
              onTap: () {

              },
            ),
            ListTile(
              // leading: Image.asset('img/btn_smeny_icon.png'),
              title: const Text('Search'),
              titleTextStyle: const TextStyle(fontSize: 24),
              onTap: () {

              },
            ),
            ListTile(
              // leading: Image.asset('img/btn_vydelky_icon.png'),
              title: const Text('Hot news'),
              titleTextStyle: const TextStyle(fontSize: 24),
              onTap: () {

              },
            ),
            ListTile(
              // leading: Image.asset('img/btn_vydelky_icon.png'),
              title: const Text('Recommendation'),
              titleTextStyle: const TextStyle(fontSize: 24),
              onTap: () {

              },
            )
          ],
        ),
      ),
    );
  }
}
