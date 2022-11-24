import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekart/c_dashboard/c_cart/cart_body.dart';
import 'package:ekart/services/zoom_image.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/back_screen_button.dart';
import 'package:ekart/widgets/custom_button.dart';
import 'package:ekart/widgets/no_data.dart';
import 'package:ekart/widgets/shimmer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailsScreen extends HookWidget {
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
    required this.email,
    required this.dailyOffValue,
  });
  final String id;
  final String image;
  final String title;
  final String description;
  final int price;
  final String rating;
  final String category;
  final int availableStock;
  final String email;
  final int dailyOffValue;

  @override
  Widget build(BuildContext context) {
    final fireRef = FirebaseFirestore.instance;
    final noOfItems = useState<int>(1);
    final isWishlisted = useState<bool>(false);
    final isLoading = useState<bool>(false);

    Future<bool> isFavAdded(String id) async {
      var document = fireRef.collection('user').doc(email);
      document.get().then((document) {
        var data = document.data();
        if (data!['wishlist'].contains(id)) {
          isWishlisted.value = true;
          return true;
        }
      });
      return false;
    }

    checkIsFavAdded(String id) async {
      isWishlisted.value = await isFavAdded(id);
    }

    addToWishlist(String id) {
      if (isWishlisted.value) {
        fireRef.collection('user').doc(email).update(
          {
            'wishlist': FieldValue.arrayRemove([id])
          },
        ).then(
          (value) => checkIsFavAdded(id).then(
            (value) => Fluttertoast.showToast(msg: 'Removed from wishlist'),
          ),
        );
      } else {
        fireRef.collection('user').doc(email).set({
          'wishlist': FieldValue.arrayUnion([id])
        }, SetOptions(merge: true)).then(
          (value) => checkIsFavAdded(id).then(
            (value) => Fluttertoast.showToast(msg: 'Added in wishlist'),
          ),
        );
      }
    }

    useEffect(() {
      checkIsFavAdded(id);
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: const BackScreenButton(),
        actions: [
          IconButton(
            onPressed: () {
              addToWishlist(id);
            },
            icon: Icon(
              isWishlisted.value
                  ? Icons.favorite_rounded
                  : Icons.favorite_outline_rounded,
              color: isWishlisted.value
                  ? AppConstant.red
                  : AppConstant.titlecolor.withOpacity(0.8),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartBody(
                    email: email,
                  ),
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
                  category[0].toUpperCase() + category.substring(1),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      '$dailyOffValue% off',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppConstant.red,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Hero(
                  tag: image,
                  child: GestureDetector(
                    onLongPress: () {
                      zoomImage(
                        image,
                        context,
                      );
                    },
                    child: Center(
                      child: CircleAvatar(
                        radius: 80.r,
                        backgroundColor: AppConstant.secondaryColor,
                        child: Image.network(
                          image,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return ShimmerContainer(
                              width: 120.r,
                              height: 120.r,
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const ImageErrorBuilder(
                              containerW: 140,
                              containerH: 140,
                              imageSize: 50,
                            );
                          },
                          width: 120.r,
                          height: 120.r,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  description,
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
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 25.sp,
                        color: AppConstant.subtitlecolor,
                      ),
                      Text(
                        rating,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        '₹ $price ',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      Text(
                        '₹ ${(price * (100 - dailyOffValue) / 100).toStringAsFixed(0)}',
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Only $availableStock item(s) left in stock',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: AppConstant.subtitlecolor,
                    ),
              ),
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
                    '₹ ${((price * (100 - dailyOffValue) / 100) * noOfItems.value).toStringAsFixed(0)}',
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
                onPressed: noOfItems.value < availableStock
                    ? () {
                        noOfItems.value++;
                      }
                    : () {
                        Fluttertoast.showToast(
                          msg:
                              'Currently only $availableStock item(s) available.',
                        );
                      },
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: noOfItems.value < availableStock
                      ? AppConstant.subtitlecolor
                      : AppConstant.subtitlecolor.withOpacity(0.5),
                ),
              ),
              SizedBox(
                width: 0.65.sw,
                height: 40.h,
                child: GradientButton(
                  isLaoding: isLoading.value,
                  onTap: () {
                    addToCart(
                      id,
                      email,
                      noOfItems.value,
                      fireRef,
                      isLoading,
                    );
                  },
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

void addToCart(
  String productId,
  String email,
  int selectedQuantity,
  FirebaseFirestore fireRef,
  ValueNotifier<bool> isLoading,
) {
  isLoading.value = true;
  fireRef.collection('user').doc(email).collection('cart').doc(productId).set({
    'productId': productId,
    'selectedQuantity': selectedQuantity,
  }).then(
    (value) => isLoading.value = false,
  );
}
