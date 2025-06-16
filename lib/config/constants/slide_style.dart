import 'package:flutter/material.dart';

class SlideStyle {
  static BoxDecoration slideDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      const BoxShadow(
        color: Colors.black45,
        blurRadius: 10,
        offset: Offset(0, 10),
      ),
    ],
  );

  static Widget slideLoading = Center(child: CircularProgressIndicator());
}
