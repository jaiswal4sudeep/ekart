import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImgStyle extends StatelessWidget {
  const ImgStyle({
    Key? key,
    required this.img,
  }) : super(key: key);

  final String img;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/$img.png',
      height: 20.sp,
      color: AppConstant.subtitlecolor,
    );
  }
}

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

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.textInputAction = TextInputAction.next,
    required this.textInputType,
    this.validator,
    this.isPassword = false,
    this.suffixIcon,
    this.readOnly = false,
    this.inputFormatters,
    this.minLines = 1,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final Widget? suffixIcon;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          validator == null ? labelText : '$labelText *',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          controller: controller,
          scrollPhysics: const BouncingScrollPhysics(),
          textInputAction: textInputAction,
          keyboardType: textInputType,
          cursorColor: AppConstant.primaryColor,
          autofocus: false,
          readOnly: readOnly!,
          obscureText: isPassword!,
          inputFormatters: inputFormatters,
          minLines: minLines,
          maxLines: minLines != 1 ? null : 1,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 2,
              minHeight: 2,
            ),
            suffixIcon: suffixIcon,
          ),
          style: Theme.of(context).textTheme.headline5,
          validator: validator,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 1.h,
        width: 0.5.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppConstant.backgroundColor,
              AppConstant.titlecolor.withOpacity(0.3),
              AppConstant.backgroundColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Center(
          child: CustomDivider(),
        ),
        Center(
          child: Container(
            color: AppConstant.backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'OR',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BackScreenButton extends StatelessWidget {
  const BackScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.keyboard_arrow_left_rounded,
      ),
    );
  }
}
