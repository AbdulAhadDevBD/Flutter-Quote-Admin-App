import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController? controller;
 final int? maxline;
  const CustomTextField({super.key,required this.text, this.controller, this.maxline});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,


      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: TextField(
          maxLines: maxline,
          keyboardType: TextInputType.text,
          controller: controller,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface, 
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withOpacity(0.5), 
            ),
          ),
        ),
      ),
    );
  }
}
