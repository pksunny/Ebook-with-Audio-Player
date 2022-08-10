// ignore_for_file: unnecessary_this, prefer_const_constructors

import 'package:ebook_with_audio_player_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTabs extends StatelessWidget {
  const AppTabs({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: this.color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 7,
              offset: Offset(0, 0),
            )
          ]),
      alignment: Alignment.center,
      child: Text(
        this.text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      ),
    );
  }
}
