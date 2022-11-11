import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/cart_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductDetailsScreen extends StatefulHookConsumerWidget {
  const ProductDetailsScreen({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.isFav,
  });
  final String id;
  final String image;
  final String title;
  final String description;
  final String price;
  final String rating;
  final String category;
  final bool isFav;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final fireRef = FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    final isFavorite = useState<bool>(widget.isFav);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const BackScreenButton(),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite.value = !isFavorite.value;
              fireRef.doc(widget.id).update({
                'isFavorite': isFavorite.value,
              });
            },
            icon: Icon(
              isFavorite.value
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              color: isFavorite.value
                  ? AppConstant.red
                  : AppConstant.titlecolor.withOpacity(0.8),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
      body: Hero(
        tag: widget.image,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.image,
                  height: 70.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  widget.description,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.rating,
                    ),
                    Text(
                      '₹${widget.price}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
