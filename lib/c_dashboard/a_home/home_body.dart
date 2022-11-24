import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/a_home/home_data.dart';
import 'package:ekart/c_dashboard/a_home/home_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeBody extends HookWidget {
  const HomeBody({
    super.key,
    required this.email,
    required this.dailyOffValue,
  });

  final String email;
  final int dailyOffValue;

  @override
  Widget build(BuildContext context) {
    final selCategoryIndex = useState<int>(0);
    final fireRef = FirebaseFirestore.instance;

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
      stream: fireRef.collection("user").doc(email).snapshots(),
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
                return HomeData(
                  selCategoryIndex: selCategoryIndex,
                  email: email,
                  productData: productSnapshot.data.docs,
                  dailyOffValue: dailyOffValue,
                );
              } else {
                return const Text('An error occured');
              }
            },
          );
        } else {
          return const Text('An error occured');
        }
      },
    );
  }
}
