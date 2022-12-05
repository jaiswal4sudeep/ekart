import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/b_wishlist/wishlist_data.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WishlistBody extends HookWidget {
  const WishlistBody({
    super.key,
    required this.email,
    required this.dailyOffValue,
  });

  final String email;
  final int dailyOffValue;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance.collection('user');
    final productId = useState<List<String>>([]);

    useEffect(() {
      productId.value.clear();
      return null;
    });

    return FutureBuilder<Object>(
      future: fireRef.get(),
      builder: (context, snapshot) {
        fireRef.get().then((value) {
          for (var item in value.docs) {
            for (var i = 0; i < item.get('wishlist').length; i++) {
              productId.value.add(item.get('wishlist')[i].toString());
            }
          }
        });
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoadingAnimationWidget.dotsTriangle(
              color: AppConstant.titlecolor,
              size: 40.sp,
            ),
          );
        } else if (snapshot.hasData) {
          return WishlistData(
            productIdList: productId.value,
            email: email,
            dailyOffValue: dailyOffValue,
          );
        } else {
          return const Text('An error occured');
        }
      },
    );
  }
}
