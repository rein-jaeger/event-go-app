import 'package:flutter/material.dart';

class CustomFormTextField extends TextField {
  CustomFormTextField(
      {Key? key,
      required String hintText,
      required TextEditingController controller,
      required Widget prefixIcon,
      bool obscuredText = false})
      : super(
            key: key,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              prefixIcon:
                  Padding(padding: const EdgeInsets.all(12), child: prefixIcon),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
              filled: true,
              hintText: hintText,
            ),
            obscureText: obscuredText);
}
