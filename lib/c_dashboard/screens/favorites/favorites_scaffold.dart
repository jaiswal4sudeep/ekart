import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/product_details_screen.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/error_screen.dart';
import 'package:ekart/widgets/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesScaffold extends HookWidget {
  const FavoritesScaffold({
    Key? key,
    required this.favItemData,
    required this.user,
  }) : super(key: key);

  final dynamic favItemData;
  final User user;

  @override
  Widget build(BuildContext context) {
    final productId = favItemData['favoriteItems']['productId'];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
        ),
        leading: const BackScreenButton(),
      ),
      body: favItemData['favoriteItems'].length == 0
          ? Center(
              child: Text(
                'No items added yet',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('product')
                    .doc(productId)
                    .snapshots(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen();
                  } else if (snapshot.hasData && data != null) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                id: data.reference.id.toString(),
                                category: data['category'],
                                description: data['description'],
                                image: data['image'],
                                price: data['price'],
                                rating: data['rating'].toString(),
                                title: data['title'],
                                availableStock: data['availableStock'],
                                user: user,
                              ),
                            ),
                          );
                        },
                        leading: Image.network(
                          data['image'],
                          height: 80.sp,
                        ),
                        title: Text(
                          data['title'],
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        subtitle: Text(
                          data['description'],
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    );
                  } else {
                    return const ErrorScreen();
                  }
                },
              ),
            ),
    );
  }
}
