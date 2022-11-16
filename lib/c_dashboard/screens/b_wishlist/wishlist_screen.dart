import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_loading_screen.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_scaffold.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WishlistScreen extends HookWidget {
  const WishlistScreen({
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
          return const CustomLoadingScreen(
            title: 'Wishlist',
          );
        } else if (snapshot.hasData) {
          return WishlistScaffold(
            productIdList: productId.value,
            email: email,
            dailyOffValue: dailyOffValue,
          );
        } else {
          return const ErrorScreen();
        }
      },
    );
  }
}
