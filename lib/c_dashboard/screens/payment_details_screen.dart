import 'package:ekart/widgets/back_screen_button.dart';
import 'package:flutter/material.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Details',
        ),
        leading: const BackScreenButton(),
      ),
    );
  }
}
