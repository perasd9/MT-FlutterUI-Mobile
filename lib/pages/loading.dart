import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitFadingCircle(
        color: Color(0xFFF89A1C),
        size: 80.0,
      ),
    );
  }
}
