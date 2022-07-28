import 'package:flutter/material.dart';

class FormFieldName extends StatelessWidget {
  final String? label;

  FormFieldName({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      '${label}',
      style: const TextStyle(
          fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}

class CustomFormField extends StatelessWidget {
  final TextEditingController Controller;
  final TextInputType? textInputType;
  String? hintText;
  final bool isPhone;
  final bool isPassWord;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  VoidCallback? onTapped;
  final Widget? widget;
  final bool isDropDown;
  final List<String>? items;
  final TextStyle? style;

  CustomFormField({
    required this.Controller,
    this.textInputType,
    required this.hintText,
    this.isPhone = false,
    this.isPassWord = false,
    this.suffixIcon,
    this.prefixIcon,
    this.width,
    this.onTapped,
    this.widget,
    this.isDropDown = false,
    this.items,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          width: width,
          height: 65,
          child: TextFormField(
            controller: Controller,
            keyboardType: textInputType,
            onTap: onTapped,
            onFieldSubmitted: (value) {},
            onChanged: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return 'field must not be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: const Color(0xffF9F9F9),
              filled: true,
              prefixIcon: prefixIcon,
              hintText: hintText,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.all(20.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
