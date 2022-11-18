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
  }) : super(key: key);

  final Function() onTap;
  final String title;
  final bool? isLaoding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
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
        borderRadius: BorderRadius.circular(200),
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
                Text(
                  isLaoding! ? 'Please wait' : title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
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

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.isLaoding = false,
  }) : super(key: key);

  final void Function()? onPressed;
  final String title;
  final bool? isLaoding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
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
        borderRadius: BorderRadius.circular(200),
        clipBehavior: Clip.hardEdge,
        color: AppConstant.transparent,
        child: InkWell(
          onTap: !isLaoding! ? onPressed : null,
          child: Padding(
            padding: const EdgeInsets.all(1.5),
            child: Container(
              decoration: BoxDecoration(
                color: AppConstant.backgroundColor,
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isLaoding!)
                      LoadingAnimationWidget.dotsTriangle(
                        color: AppConstant.gradientStart,
                        size: 20.sp,
                      ),
                    if (isLaoding!)
                      SizedBox(
                        width: 10.w,
                      ),
                    Text(
                      isLaoding! ? 'Please wait' : title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: AppConstant.gradientStart,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
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
        borderRadius: BorderRadius.circular(200),
        color: AppConstant.backgroundColor,
        border: Border.all(
          width: 1.5,
          color: !isLaoding!
              ? AppConstant.subtitlecolor.withOpacity(0.3)
              : AppConstant.subtitlecolor.withOpacity(0.15),
        ),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(200),
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
                    color: !isLaoding!
                        ? AppConstant.subtitlecolor
                        : AppConstant.subtitlecolor.withOpacity(0.5),
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
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: !isLaoding!
                            ? AppConstant.subtitlecolor
                            : AppConstant.subtitlecolor.withOpacity(0.5),
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
