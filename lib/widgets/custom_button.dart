import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.isLaoding = false,
    this.hvIcon = false,
    this.icon,
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final bool? isLaoding;
  final bool? hvIcon;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            isLaoding!
                ? AppConstant.gradientStart.withOpacity(0.85)
                : AppConstant.gradientStart,
            isLaoding!
                ? AppConstant.gradientEnd.withOpacity(0.85)
                : AppConstant.gradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.hardEdge,
        color: AppConstant.transparent,
        child: InkWell(
          onTap: !isLaoding! ? onTap : null,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLaoding!)
                  LoadingAnimationWidget.dotsTriangle(
                    color: AppConstant.backgroundColor,
                    size: 20.sp,
                  ),
                if (isLaoding!)
                  SizedBox(
                    width: 10.w,
                  ),
                if (hvIcon! && !isLaoding!) icon!,
                if (hvIcon! && !isLaoding!)
                  SizedBox(
                    width: 10.w,
                  ),
                Text(
                  isLaoding! ? 'Please wait' : title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppConstant.backgroundColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppConstant.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: AppConstant.primaryColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
        ),
      ),
    );
  }
}
