import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Image.asset(
            'assets/icons/no_data.png',
            height: 150.h,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'No items available',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
