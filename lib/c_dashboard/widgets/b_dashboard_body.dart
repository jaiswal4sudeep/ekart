import 'package:ekart/c_dashboard/screens/product_details_screen.dart';
import 'package:ekart/services/zoom_image.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:ekart/widgets/custom_chip.dart';
import 'package:ekart/widgets/no_data.dart';
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
    return ListView(
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
        if (productData.length == 0) const NoData(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 200.sp / 230.sp,
              crossAxisSpacing: 4.sp,
              mainAxisSpacing: 4.sp,
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
                onLongPress: () {
                  zoomImage(
                    data['image'],
                    context,
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            color: AppConstant.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(12.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '10% off',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color: AppConstant.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Image.network(
                        data['image'],
                        height: 70.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          data['title'],
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 8,
                          right: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '₹ ${(data['price'] * 10 / 9).toStringAsFixed(0)} ',
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
                                  .headline4!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppConstant.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 8,
                        ),
                        child: Row(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
