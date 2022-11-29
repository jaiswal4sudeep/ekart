import 'package:flutter/material.dart';

class TextStyle3 extends StatelessWidget {
  const TextStyle3({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.headline3!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class TextStyle5 extends StatelessWidget {
  const TextStyle5({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}
