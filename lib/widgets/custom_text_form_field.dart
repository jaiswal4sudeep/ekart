import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';

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
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      cursorColor: AppConstant.primaryColor,
      autofocus: false,
      obscureText: isPassword!,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: AppConstant.titlecolor,
            ),
        focusedBorder: const UnderlineInputBorder(),
        border: const UnderlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      style: Theme.of(context).textTheme.headline5,
      validator: validator,
    );
  }
}