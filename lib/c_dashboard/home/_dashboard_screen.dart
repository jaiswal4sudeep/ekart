import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/home/a_dashboard_scaffold.dart';
import 'package:ekart/c_dashboard/widgets/dashboard_loading_screen.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DashboardScreen extends StatefulHookConsumerWidget {
  const DashboardScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  DateTime datetime = DateTime.now();
  final fireRef = FirebaseFirestore.instance;
  int todayDate = 0;

  @override
  Widget build(BuildContext context) {
    final appVersion = useState<String>('');
    final appName = useState<String>('');
    final selCategoryIndex = useState<int>(0);
    final dailyOff = useState<int>(0);

    getAppInfo() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion.value = packageInfo.version;
      appName.value = packageInfo.appName;
    }

    getOffers() async {
      var document = fireRef.collection('offer').doc('daily_off');
      document.get().then((document) {
        var data = document.data();
        dailyOff.value = data!['current_day'][todayDate - 1];
      });
    }

    useEffect(() {
      todayDate = datetime.day;
      getAppInfo();
      getOffers();
      return null;
    });

    Stream<dynamic>? fetchProductData(int selCategoryIndex) {
      dynamic snapShot;
      switch (selCategoryIndex) {
        case 1: // clothes
          snapShot = fireRef
              .collection('product')
              .where('category', isEqualTo: 'clothes')
              .snapshots();
          break;
        case 2: // accessories
          snapShot = fireRef
              .collection('product')
              .where('category', isEqualTo: 'accessories')
              .snapshots();
          break;
        case 3: // electronics
          snapShot = fireRef
              .collection('product')
              .where('category', isEqualTo: 'electronics')
              .snapshots();
          break;
        case 4: // books
          snapShot = fireRef
              .collection('product')
              .where('category', isEqualTo: 'books')
              .snapshots();
          break;
        default: // all
          snapShot = fireRef.collection('product').snapshots();
      }
      return snapShot;
    }

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
        stream: fireRef.collection("user").doc(widget.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot usetSnapshot) {
          if (usetSnapshot.connectionState == ConnectionState.waiting) {
            return const DashboardLoadingScreen();
          } else if (usetSnapshot.hasData) {
            return StreamBuilder(
              stream: fetchProductData(selCategoryIndex.value),
              builder: (BuildContext context, AsyncSnapshot productSnapshot) {
                if (productSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const DashboardLoadingScreen();
                } else if (productSnapshot.hasData) {
                  return DashboardScaffold(
                    selCategoryIndex: selCategoryIndex,
                    email: widget.email,
                    userData: usetSnapshot.data,
                    productData: productSnapshot.data.docs,
                    appName: appName.value,
                    appVersion: appVersion.value,
                    dailyOffValue: dailyOff.value,
                  );
                } else {
                  return const ErrorScreen();
                }
              },
            );
          } else {
            return const ErrorScreen();
          }
        },
      ),
    );
  }
}
