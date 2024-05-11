import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/components/my_back_button.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  //
  final User? currentUser = FirebaseAuth.instance.currentUser;
  //
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, shapshot) {
            // loading
            if (shapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            // error
            else if (shapshot.hasError) {
              return Text("Error:${shapshot.error}");
            }

            // data received
            else if (shapshot.hasData) {
              // extract data
              Map<String, dynamic>? user = shapshot.data!.data();

              if (user != null) {
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, left: 25),
                        child: Row(
                          children: [
                            MyBackButton(),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: EdgeInsets.all(25),
                        child: Icon(Icons.person, size: 64),
                      ),
                      SizedBox(height: 25),
                      Text(
                        user['username']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user['email']!,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text("Flutter Best");
              }
            } else {
              return Text("No Data");
            }
          }),
    );
  }
}
