import 'package:ekart/widgets/back_screen_button.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order History',
        ),
        leading: const BackScreenButton(),
      ),
    );
  }
}
