import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/screens/cart_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    required this.availableStock,
    required this.user,
  });
  final String id;
  final String image;
  final String title;
  final String description;
  final int price;
  final String rating;
  final String category;
  final int availableStock;
  final User user;

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final fireRef = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Future<bool> isFavAdded(String id) async {
      var isAddedRef =
          await fireRef.collection('users').doc(widget.user.email).get();
      if (isAddedRef.exists && isAddedRef['favoriteItems']['productId'] == id) {
        return true;
      }
      return false;
    }

    final noOfItems = useState<int>(1);
    final isFavorite = useState<bool>(false);

    addToFavorites(String id) async {
      // isFavorite.value = await isFavAdded(widget.id);
      // Fluttertoast.showToast(msg: isFavorite.value.toString());
    }

    checkIsFavAdded(String id) async {
      isFavorite.value = await isFavAdded(id);
    }

    useEffect(() {
      checkIsFavAdded(widget.id);
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: const BackScreenButton(),
        actions: [
          IconButton(
            onPressed: () {
              addToFavorites(widget.id);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.category[0].toUpperCase() +
                      widget.category.substring(1),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80.r,
                    backgroundColor: AppConstant.secondaryColor,
                    child: Image.network(
                      widget.image,
                      height: 90.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 25.sp,
                        color: AppConstant.subtitlecolor,
                      ),
                      Text(
                        widget.rating,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '₹ 10 ',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      Text(
                        '₹ ${widget.price}',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppConstant.primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Payable amount: ',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '₹${widget.price * noOfItems.value}',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppConstant.primaryColor,
                        ),
                  ),
                  Text(
                    ' (No extra charges)',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: noOfItems.value > 1
                    ? () {
                        noOfItems.value--;
                      }
                    : null,
                icon: Icon(
                  Icons.remove_circle_rounded,
                  color: noOfItems.value > 1
                      ? AppConstant.subtitlecolor
                      : AppConstant.subtitlecolor.withOpacity(0.5),
                ),
              ),
              Text(
                noOfItems.value.toString(),
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              IconButton(
                onPressed: noOfItems.value < widget.availableStock
                    ? () {
                        noOfItems.value++;
                      }
                    : () {
                        Fluttertoast.showToast(
                          msg:
                              'Currently only ${widget.availableStock} item(s) available.',
                        );
                      },
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: noOfItems.value < widget.availableStock
                      ? AppConstant.subtitlecolor
                      : AppConstant.subtitlecolor.withOpacity(0.5),
                ),
              ),
              SizedBox(
                width: 0.65.sw,
                height: 40.h,
                child: GradientButton(
                  onTap: () {},
                  title: 'Add to cart',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
