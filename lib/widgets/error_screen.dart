import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Widget getErrorScreen(FlutterErrorDetails error) {
  return const ErrorScreen();
}

class ErrorScreen extends HookWidget {
  const ErrorScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lottieController = useAnimationController(
      duration: const Duration(seconds: 6),
    );
    lottieController.repeat(reverse: false);

    return Scaffold(
      body: Center(
        child: Text(
          'There is an error, Please try again...',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
