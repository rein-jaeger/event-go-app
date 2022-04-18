import 'dart:math';

import 'package:flutter/material.dart';

class AdaptiveFormWidget extends StatelessWidget {
  final Widget child;
  final Size minSize;
  final ThemeData landscapeTheme;
  final ThemeData portraitTheme;

  const AdaptiveFormWidget(
      {Key? key,
      required this.child,
      this.minSize = const Size(360, 480),
      required this.landscapeTheme,
      required this.portraitTheme})
      : super(key: key);

  Size _getPortraitSize(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = max(minSize.width, size.width * 0.9);

    return Size(width, max(minSize.height, width / size.aspectRatio));
  }

  Size _getLandscapeSize(BuildContext context, BoxConstraints constraints) {
    var density = MediaQuery.of(context).devicePixelRatio;

    if (density > 1.3) {
      return Size(
          max(minSize.width, constraints.minWidth * 0.6),
          max(minSize.height,
              constraints.minWidth * 0.6 / minSize.aspectRatio));
    }

    return Size(
        max(minSize.width, constraints.minHeight * minSize.aspectRatio * 0.8),
        max(minSize.height, constraints.minHeight * 0.8));
  }

  Widget _forLandscape(BuildContext context, BoxConstraints constraints) {
    var formSize = _getLandscapeSize(context, constraints);

    var form = Theme(
        data: landscapeTheme,
        child: Container(
          width: formSize.width,
          height: formSize.height,
          child: DefaultTextStyle(
            style: landscapeTheme.textTheme.bodyMedium!,
            child: child,
          ),
          decoration: BoxDecoration(
              color: landscapeTheme.dialogBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(6, 6),
                    blurRadius: 8,
                    spreadRadius: 4)
              ]),
        ));

    return Center(child: form);
  }

  Widget _forPortrait(BuildContext context) {
    var formSize = _getPortraitSize(context);
    var form = Theme(
        data: portraitTheme,
        child: SizedBox(
          child: DefaultTextStyle(
            style: portraitTheme.textTheme.bodyMedium!,
            child: child,
          ),
          width: formSize.width,
          height: formSize.height,
        ));

    return Center(child: form);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    Widget content;

    if (media.orientation == Orientation.portrait) {
      content = _forPortrait(context);
    } else {
      content = LayoutBuilder(builder: _forLandscape);
    }

    return SizedBox(
        width: max(minSize.width, media.size.width),
        height: max(minSize.height, media.size.height),
        child: content);
  }
}
