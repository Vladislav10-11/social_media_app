import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:social_media_app/components/my_drawer.dart';
import 'package:social_media_app/components/my_list_tile.dart';
import 'package:social_media_app/components/my_post_button.dart';
import 'package:social_media_app/components/my_textfield.dart';
import 'package:social_media_app/database/firestore.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final FirestoreDatabase database = FirestoreDatabase();
  void postMessage() {
    if (newpostController.text.isNotEmpty) {
      String message = newpostController.text;
      database.addPost(message);
    }

    newpostController.clear();
  }

  // new post controller

  final TextEditingController newpostController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "F E E D",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      bottomNavigationBar:
          GNav(activeColor: Theme.of(context).primaryColor, tabs: [
        GButton(
          onPressed: () {
            Navigator.pushNamed(context, '/home_screen');
          },
          icon: Icons.home,
          gap: 8,
          text: "Home",
        ),
        GButton(
          onPressed: () {
            Navigator.pushNamed(context, '/profile_screen');
          },
          icon: Icons.person,
          gap: 8,
          text: "Profile",
        ),
        GButton(
          onPressed: () {
            Navigator.pushNamed(context, '/users_screen');
          },
          gap: 8,
          icon: Icons.group,
          text: "Users",
        ),
      ]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      controller: newpostController,
                      hintText: "Write Something",
                      obscureText: false),
                ),
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;

                if (snapshot.data == null || posts.isEmpty) {
                  return Center(
                    child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text(
                          "No Posts",
                        )),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        String message = post['PostMessage'];
                        String userEmail = post['UserEmail'];

                        return MyListTile(subTitle: message, title: userEmail);
                      }),
                );
              })
        ],
      ),
    );
  }
}
