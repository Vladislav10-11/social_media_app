import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.public_rounded,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_screen');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.person_outlined),
                  title: Text("PROFILE"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile_screen');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(Icons.group_outlined),
                  title: Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/users_screen');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("L O G O U T"),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
