import 'package:flutter/material.dart';
import 'package:nche/components/colors.dart';
import 'package:nche/components/style.dart';

class MyTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validatior;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final Function(String)? onChanged;
  const MyTextForm(
      {Key? key,
      required this.controller,
      this.validatior,
      this.onChanged,
      this.hintText,
      this.suffixIcon,
      this.autofillHints,
      required this.obscureText,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style.copyWith(fontWeight: FontWeight.w400),
      obscureText: obscureText,
      autofillHints: autofillHints,
      cursorColor: Colors.black54,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      validator: validatior,
      decoration: InputDecoration(
        fillColor: AppColor.white,
        filled: true,
        hintText: hintText,
        hintStyle: style.copyWith(color: AppColor.darkerGrey),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: AppColor.red,
          ),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: AppColor.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(
            color: AppColor.darkerGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppColor.grey),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
