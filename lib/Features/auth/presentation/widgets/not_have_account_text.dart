import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class NotHaveAccountText extends StatelessWidget {
  const NotHaveAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?',
            style: TextStyle(
                fontSize: 14, color: Colors.grey.shade300.withOpacity(0.7))),
        const Gap(8),
        GestureDetector(
          onTap: () => GoRouter.of(context).push(AppRoutes.kRegisterView),
          child: Text('Register',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade300)),
        ),
      ],
    );
  }
}
