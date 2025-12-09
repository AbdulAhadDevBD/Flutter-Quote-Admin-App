import 'package:flutter/material.dart';
import 'package:flutter_quotes_admin_app/constant/utils/app_color.dart';

import '../constant/utils/app_style.dart';

class CustomListTile extends StatelessWidget {
  final String text;
  final String number;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  const CustomListTile({
    super.key,
    required this.text,
    required this.number,
    this.leadingIcon,
    this.trailingIcon,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).cardColor,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: AppColor.primary,
            child: Icon(
              leadingIcon,
              color: Colors.white,
              size: 20,
            ),
          ),

          title: Text(text,style: AppStyle.titleStyle,),
          subtitle: Text(number,style: AppStyle.subtitleStyle,),
          trailing: Icon(trailingIcon,),
        ),
      ),
    );
  }
}
