import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/components/my_back_button.dart';
import 'package:social_media_app/components/my_list_tile.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  void displayMessagetoUser(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          // any errors
          if (snapshot.hasError) {
            displayMessagetoUser("Something went wrong", context);
          }
          //show loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Text("No Data");
          }

          //get all users

          final users = snapshot.data!.docs;

          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    String username = user['username'];
                    String email = user['email'];
                    return MyListTile(subTitle: username, title: email);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
