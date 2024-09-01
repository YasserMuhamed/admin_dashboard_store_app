import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.width,
    required this.child,
  });
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Shimmer.fromColors(
          baseColor: Colors.grey[600]!,
          highlightColor: const Color.fromARGB(192, 224, 224, 224),
          child: child),
    );
  }
}
