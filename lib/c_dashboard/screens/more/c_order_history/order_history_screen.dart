import 'package:ekart/widgets/custom_widgets.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        leading: const BackScreenButton(),
      ),
      body: const NoData(),
    );
  }
}
