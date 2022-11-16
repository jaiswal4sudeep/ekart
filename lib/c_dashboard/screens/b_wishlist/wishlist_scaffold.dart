import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/b_wishlist/wishlist_loading_screen.dart';
import 'package:ekart/c_dashboard/screens/product_details_screen.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistScaffold extends HookWidget {
  const WishlistScaffold({
    Key? key,
    required this.productIdList,
    required this.email,
    required this.dailyOffValue,
  }) : super(key: key);

  final List<String> productIdList;
  final String email;
  final int dailyOffValue;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
        ),
        leading: const BackScreenButton(),
      ),
      body: productIdList.isEmpty
          ? const NoData()
          : FutureBuilder(
              future: fireRef
                  .collection('product')
                  .where('productId', whereIn: productIdList)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CustomLoadingScreen(
                    title: 'Wishlist',
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  id: data['productId'],
                                  image: data['image'],
                                  title: data['title'],
                                  description: data['description'],
                                  price: data['price'],
                                  rating: data['rating'].toString(),
                                  category: data['category'],
                                  availableStock: data['availableStock'],
                                  email: email,
                                  dailyOffValue: dailyOffValue,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                data['image'],
                                height: 40.sp,
                                width: 40.sp,
                              ),
                              title: Text(
                                data['title'],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                data['description'],
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                          ),
                        ),
                      );
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
