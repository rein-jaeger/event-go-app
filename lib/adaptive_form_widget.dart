import 'package:flutter/material.dart';

class AdaptiveFormWidget extends StatelessWidget {
  final Widget child;

  const AdaptiveFormWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
