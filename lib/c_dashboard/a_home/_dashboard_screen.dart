import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/a_home/b_home_body.dart';
import 'package:ekart/c_dashboard/a_home/home_loading_screen.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  ConsumerState<HomeScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<HomeScreen> {
  DateTime datetime = DateTime.now();
  final fireRef = FirebaseFirestore.instance;
  int todayDate = 0;

  @override
  Widget build(BuildContext context) {
    final selCategoryIndex = useState<int>(0);
    final dailyOff = useState<int>(0);

    getOffers() async {
      var document = fireRef.collection('offer').doc('daily_off');
      document.get().then((document) {
        var data = document.data();
        dailyOff.value = data!['current_day'][todayDate - 1];
      });
    }

    useEffect(() {
      todayDate = datetime.day;
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

    return StreamBuilder(
      stream: fireRef.collection("user").doc(widget.email).snapshots(),
      builder: (BuildContext context, AsyncSnapshot usetSnapshot) {
        if (usetSnapshot.connectionState == ConnectionState.waiting) {
          return const HomeLoadingScreen();
        } else if (usetSnapshot.hasData) {
          return StreamBuilder(
            stream: fetchProductData(selCategoryIndex.value),
            builder: (BuildContext context, AsyncSnapshot productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return const HomeLoadingScreen();
              } else if (productSnapshot.hasData) {
                return HomeBody(
                  selCategoryIndex: selCategoryIndex,
                  email: widget.email,
                  productData: productSnapshot.data.docs,
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
    );
  }
}
