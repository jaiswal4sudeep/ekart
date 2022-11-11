import 'package:flutter/material.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({
    Key? key, required this.appName, required this.appVersion,
  }) : super(key: key);

  final String appName;
  final String appVersion;

  @override
  Widget build(BuildContext context) {
    return const Drawer();
  }
}
