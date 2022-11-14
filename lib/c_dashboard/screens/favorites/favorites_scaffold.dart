import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Items',
        ),
        leading: const BackScreenButton(),
      ),
      body: favItemData['favoriteItems'].length == 0
          ? const NoData()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: favItemData['favoriteItems'].length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('product')
                        .where('productId',
                            isEqualTo: favItemData['favoriteItems'][index])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: ShimmerListTile(),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data?.docs[index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              data!['image'],
                              height: 80.sp,
                            ),
                            title: Text(
                              data['title'],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
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
                        );
                      } else {
                        return const Center(
                          child: Text('An error occured'),
                        );
                      }
                    },
                  );
                },
              ),
            ),
    );
  }
}
