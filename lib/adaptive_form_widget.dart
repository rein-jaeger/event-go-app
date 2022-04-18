import 'dart:math';

import 'package:flutter/material.dart';

class AdaptiveFormWidget extends StatelessWidget {
  final Widget Function(BuildContext context, Size formSize) builder;
  final Size minSize;
  final ThemeData landscapeTheme;
  final ThemeData portraitTheme;

  const AdaptiveFormWidget(
      {Key? key,
      required this.builder,
      this.minSize = const Size(480, 640),
      required this.landscapeTheme,
      required this.portraitTheme})
      : super(key: key);

  Size _getPortraitSize(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = max(minSize.width, size.width * 0.9);

    return Size(width, max(minSize.height, width / size.aspectRatio));
  }

  Size _getLandscapeSize(BuildContext context, BoxConstraints constraints) {
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
            child: builder(context, formSize),
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
            child: builder(context, formSize),
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
