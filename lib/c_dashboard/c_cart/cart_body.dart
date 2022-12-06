import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartBody extends StatelessWidget {
  const CartBody({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    return FutureBuilder(
      future: fireRef.collection('user').doc(email).collection('cart').get(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppConstant.titlecolor,
              size: 40.sp,
            ),
          );
        } else if (snapShot.hasData) {
          var data = snapShot.data;
          return data!.docs.isEmpty
              ? const NoData()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            data.docs[index]['productId'].toString(),
                          ),
                          subtitle: Text(
                            data.docs[index]['selectedQuantity'].toString(),
                          ),
                        ),
                      );
                    },
                  ),
                );
        } else {
          return const Text('An error occured');
        }
      },
    );
  }
}
