import 'package:ekart/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackScreenButton(),
        title: const Text('About App'),
      ),
    );
  }
}
