import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          height: 5.h,
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
          height: 5.h,
        ),
      ],
    );
  }
}
