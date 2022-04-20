import 'package:flutter/material.dart';

class CustomFormButton extends ElevatedButton {
  CustomFormButton(
      {Key? key, required String text, required VoidCallback? onPressed})
      : super(
            key: key,
            onPressed: onPressed,
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ));
}
