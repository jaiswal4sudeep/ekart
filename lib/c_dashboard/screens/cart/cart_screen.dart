import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_loading_screen.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
    required this.email,
  });
  final String email;
  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
        ),
        leading: const BackScreenButton(),
      ),
      body: FutureBuilder(
        future: fireRef.collection('user').doc(email).collection('cart').get(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingScreen(
              title: 'Cart',
            );
          } else if (snapShot.hasData) {
            var data = snapShot.data;
            return data!.docs.isEmpty
                ? const NoData()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.docs.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  title: Text(
                                      data.docs[index]['productId'].toString()),
                                  subtitle: Text(data.docs[index]
                                          ['selectedQuantity']
                                      .toString()),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 0.9.sw,
                          height: 40.h,
                          child: GradientButton(
                            onTap: () {
                              proceedToCheckout();
                            },
                            title: 'Proceed to checkout',
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  );
          } else {
            return const ErrorScreen();
          }
        },
      ),
    );
  }
}

proceedToCheckout() {}
