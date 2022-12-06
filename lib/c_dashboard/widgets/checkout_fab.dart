import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/app_constant.dart';

class CheckOutFAB extends HookWidget {
  const CheckOutFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);

    return FloatingActionButton.extended(
      onPressed: isLoading.value
          ? () {}
          : () {
              proceedToCheckOut(isLoading);
            },
      backgroundColor: AppConstant.primaryColor,
      icon: isLoading.value
          ? LoadingAnimationWidget.dotsTriangle(
              color: AppConstant.backgroundColor,
              size: 15.sp,
            )
          : Image.asset(
              'assets/icons/checkout.png',
              height: 15.sp,
              color: AppConstant.backgroundColor,
            ),
      label: Text(
        isLoading.value ? 'Plaese wait' : 'Checkout',
        style: Theme.of(context).textTheme.headline5!.copyWith(
              color: AppConstant.backgroundColor,
            ),
      ),
    );
  }
}

proceedToCheckOut(ValueNotifier<bool> isLoading) {
  isLoading.value = true;
  Future.delayed(const Duration(seconds: 2), () {
    isLoading.value = false;
  });
}
