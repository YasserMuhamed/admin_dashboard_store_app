import 'package:flutter/material.dart';

class SmallLoadingWidget extends StatelessWidget {
  const SmallLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 17,
        width: 17,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ));
  }
}
