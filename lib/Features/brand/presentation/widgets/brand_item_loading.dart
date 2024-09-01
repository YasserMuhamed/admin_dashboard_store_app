import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BrandItemLoading extends StatelessWidget {
  const BrandItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.05),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(8),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              right: 0,
              child: Center(child: Icon(Icons.more_vert, color: Colors.white)),
            ),
            Positioned(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  height: 20,
                ),
              ),
            ),
            Positioned(
              top: 35,
              bottom: 35,
              left: 15,
              right: 15,
              child: AspectRatio(
                aspectRatio: 1.3,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                width: 100,
                height: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
