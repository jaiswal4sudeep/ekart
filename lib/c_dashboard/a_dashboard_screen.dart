import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/_dashboard_scaffold.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardScreen extends StatefulHookConsumerWidget {
  const DashboardScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  DateTime datetime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appVersion = useState<String>('');
    final appName = useState<String>('');
    getAppInfo() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      appName.value = packageInfo.appName;
    }

    useEffect(() {
      getAppInfo();
      return null;
    });
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(datetime) >= const Duration(seconds: 2)) {
          Fluttertoast.showToast(msg: 'Tap again to exit!');
          datetime = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            return DashboardScaffold(
              productData: snapshot.data.docs,
              appName: appName.value,
              appVersion: appVersion.value,
            );
          } else {
            return const ErrorScreen();
          }
        },
      ),
    );
  }
}
