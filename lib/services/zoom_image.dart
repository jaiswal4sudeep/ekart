import 'package:flutter/material.dart';

void zoomImage(String imagePath, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Image.network(imagePath),
      );
    },
  );
}
