import 'package:ekart/c_dashboard/screens/product_details_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_chip.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardBody extends HookWidget {
  const DashboardBody({
    Key? key,
    required this.productData,
    required this.selCategoryIndex,
    required this.user,
  }) : super(key: key);

  final dynamic productData;
  final ValueNotifier<int> selCategoryIndex;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CustomChip(
                    chipText: 'All',
                    isCompleted: selCategoryIndex.value != 0,
                    onTap: () {
                      selCategoryIndex.value = 0;
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomChip(
                    chipText: 'Clothes',
                    isCompleted: selCategoryIndex.value != 1,
                    onTap: () {
                      selCategoryIndex.value = 1;
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomChip(
                    chipText: 'Accessories',
                    isCompleted: selCategoryIndex.value != 2,
                    onTap: () {
                      selCategoryIndex.value = 2;
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomChip(
                    chipText: 'Electronics',
                    isCompleted: selCategoryIndex.value != 3,
                    onTap: () {
                      selCategoryIndex.value = 3;
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomChip(
                    chipText: 'Books',
                    isCompleted: selCategoryIndex.value != 4,
                    onTap: () {
                      selCategoryIndex.value = 4;
                    },
                  ),
                ],
              ),
            ),
          ),
          if (productData.length == 0)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  'No items available',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 200.sp / 220.sp,
              crossAxisSpacing: 8.sp,
              mainAxisSpacing: 8.sp,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productData.length,
            itemBuilder: (context, index) {
              final data = productData[index].data();
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsScreen(
                      id: productData[index].reference.id.toString(),
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
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          data['image'],
                          height: 70.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          data['title'],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          data['description'],
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                color: AppConstant.subtitlecolor,
                              ),
                              Text(
                                '${data['rating']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                '₹ 10 ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                              ),
                              Text(
                                '₹${data['price']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
