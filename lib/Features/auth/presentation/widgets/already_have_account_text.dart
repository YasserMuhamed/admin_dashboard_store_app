import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?',
            style: TextStyle(
                fontSize: 16, color: Colors.grey.shade300.withOpacity(0.7))),
        const Gap(8),
        GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Text('Login',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade300)),
        ),
      ],
    );
  }
}
