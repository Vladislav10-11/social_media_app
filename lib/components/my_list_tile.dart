import 'package:flutter/material.dart';
import 'package:social_media_app/components/like_button.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyListTile({super.key, required this.subTitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        bottom: 25,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(
            subTitle,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
