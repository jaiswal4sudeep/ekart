import 'package:flutter/material.dart';
import 'package:ekart/utils/app_constant.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    Key? key,
    required this.chipText,
    this.isCompleted = false,
    this.onTap,
  }) : super(key: key);

  final String chipText;
  final bool? isCompleted;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color:
              isCompleted! ? AppConstant.subtitlecolor.withOpacity(0.35) : null,
          gradient: !isCompleted!
              ? const LinearGradient(
                  colors: [
                    AppConstant.gradientStart,
                    AppConstant.gradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          child: Text(
            chipText,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstant.backgroundColor,
                ),
          ),
        ),
      ),
    );
  }
}
