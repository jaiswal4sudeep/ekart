import 'package:ekart/utils/app_constant.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final Function() onTap;
  final String title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: icon,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppConstant.titlecolor,
            ),
      ),
    );
  }
}
