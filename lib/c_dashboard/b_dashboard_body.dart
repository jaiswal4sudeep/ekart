import 'package:ekart/c_dashboard/screens/product_details_screen.dart';
import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    Key? key,
    required this.productData,
  }) : super(key: key);

  final dynamic productData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 200.sp / 220.sp,
          crossAxisSpacing: 8.sp,
          mainAxisSpacing: 8.sp,
        ),
        physics: const BouncingScrollPhysics(),
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
                  price: data['price'].toString(),
                  rating: data['rating'].toString(),
                  title: data['title'],
                  isFav: data['isFavorite'],
                ),
              ),
            ),
            child: Hero(
              tag: data['image'],
              transitionOnUserGestures: true,
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
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
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: AppConstant.titlecolor.withOpacity(0.8),
                            ),
                            Text(
                              data['rating'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const Spacer(),
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
            ),
          );
        },
      ),
    );
  }
}
