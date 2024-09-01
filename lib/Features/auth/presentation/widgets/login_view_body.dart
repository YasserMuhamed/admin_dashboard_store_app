import 'package:admin_dashboard_store_app/Core/helpers/app_regex.dart';
import 'package:admin_dashboard_store_app/Core/utils/images/my_images.dart';
import 'package:admin_dashboard_store_app/Features/auth/manager/login_cubit/login_cubit.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/not_have_account_text.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Variables
  String? email;
  String? password;
  bool? isObscure = true;

  // Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    BlocProvider.of<LoginCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: autovalidateMode,
      key: formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const Gap(40),
              // App Logo
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(MyImages.logo),
              ),
              const Gap(60),
              CustomTextFormField(
                validate: (value) {
                  if (value!.isEmpty || !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  } else {
                    return null;
                  }
                },
                controller: emailController,
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.email),
                    Gap(8),
                    Text('Email'),
                  ],
                ),
                key_type: TextInputType.emailAddress,
              ),
              const Gap(20),
              CustomTextFormField(
                validate: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  } else {
                    return null;
                  }
                },
                controller: passwordController,
                obscure: isObscure,
                suficon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure!;
                      });
                    },
                    icon: isObscure!
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility)),
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.password),
                    Gap(8),
                    Text('Password'),
                  ],
                ),
              ),
              const Gap(30),
              ButtonBlocBuilder(
                onPressed: () => loginLogic(context),
              ),
              const Gap(20),
              const NotHaveAccountText(),
              loginListener()
            ],
          ),
        ),
      ),
    );
  }

  void loginLogic(BuildContext context) {
    if (formKey.currentState!.validate()) {
      email = emailController.text;
      password = passwordController.text;
      BlocProvider.of<LoginCubit>(context)
          .login(email: email!, password: password!);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  BlocListener<LoginCubit, LoginState> loginListener() {
    return BlocListener<LoginCubit, LoginState>(
        child: const SizedBox.shrink(),
        listener: (context, state) {
          if (state is LoginLoading) {
          } else if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                content: const Text('Login Success',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );
            GoRouter.of(context).go(AppRoutes.kDashboardView);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red.shade800, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                content: Text(state.error,
                    style: const TextStyle(color: Colors.white)),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
  }
}

class ButtonBlocBuilder extends StatelessWidget {
  const ButtonBlocBuilder({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomButton(
          text: "Login",
          onPressed: state is LoginLoading ? () {} : onPressed,
        );
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final LoginState state = context.watch<LoginCubit>().state;
    return ElevatedButton(
      onPressed: onPressed,
      child: state is LoginLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
                const Gap(10),
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              ],
            )
          : Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
    );
  }
}
