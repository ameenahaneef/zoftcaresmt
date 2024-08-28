import 'package:flutter/material.dart';
import 'package:zoftcares_mt/core/colors/colors.dart';

class Formfield extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const Formfield({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: kwhite, fontSize: 20),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kwhite)),
        label: Text(
          labelText,
          style: TextStyle(color: kwhite),
        ),
        floatingLabelStyle: TextStyle(color: kwhite, fontSize: 16),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kwhite)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kwhite)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kred)),
        errorStyle: TextStyle(color: kwhite),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: kwhite)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $labelText';
        }
        return null;
      },
    );
  }
}
