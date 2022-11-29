import 'package:ekart/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class ECZoneScreen extends StatelessWidget {
  const ECZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackScreenButton(),
        title: const Text('EC Zone'),
      ),
    );
  }
}
