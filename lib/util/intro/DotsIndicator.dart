import 'dart:math';

import 'package:election_gh/ui/ui_helper.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: UIHelper.colorGrey,
  }) : super(listenable: controller);

  //-- The PageController that this DotsIndicator is representing.
  final PageController controller;

  //-- The number of items managed by the PageController
  final int itemCount;

  //-- Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  //-- The color of the dots.

  //-- Defaults to `UIHelper.colorGrey`.
  final Color color;

  //-- The base size of the dots
  static const double kDotSize = 8.0;

  //-- The increase in the size of the selected dot
  static const double kMaxZoom = 2.0;

  //-- The distance between the center of each dot
  static const double kDotSpacing = 25.0;

  Widget buildDot(int index) {
    double selected = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (kMaxZoom - 1.0) * selected;
    return new Container(
      width: kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: kDotSize * zoom,
            height: kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, buildDot),
    );
  }
}
