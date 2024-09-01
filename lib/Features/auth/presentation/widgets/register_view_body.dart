import 'package:admin_dashboard_store_app/Core/helpers/app_regex.dart';
import 'package:admin_dashboard_store_app/Core/utils/images/my_images.dart';
import 'package:admin_dashboard_store_app/Features/auth/manager/register_cubit/register_cubit.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/already_have_account_text.dart';
import 'package:admin_dashboard_store_app/Features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:admin_dashboard_store_app/configs/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  // Init State
  @override
  void initState() {
    BlocProvider.of<RegisterCubit>(context);
    super.initState();
  }

  // Controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // Dispose
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  //Variables
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  bool? isObscured = true;

  // Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
                  if (value!.isEmpty) {
                    return 'Please enter your Username';
                  } else {
                    return null;
                  }
                },
                controller: usernameController,
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person),
                    Gap(8),
                    Text('Username'),
                  ],
                ),
              ),
              const Gap(20),
              CustomTextFormField(
                validate: (value) {
                  if (value!.isEmpty || !AppRegex.isEmailValid(value)) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
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
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  } else {
                    return null;
                  }
                },
                suficon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured!;
                    });
                  },
                  icon: isObscured!
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
                controller: passwordController,
                obscure: isObscured,
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.password),
                    Gap(8),
                    Text('Password'),
                  ],
                ),
              ),
              const Gap(20),
              CustomTextFormField(
                validate: (value) {
                  if (value!.isEmpty || !AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter your phone number';
                  } else {
                    return null;
                  }
                },
                controller: phoneNumberController,
                key_type: TextInputType.phone,
                label: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone),
                    Gap(8),
                    Text('Phone Number'),
                  ],
                ),
              ),
              const Gap(30),
              RegisterButtonBlocBuilder(
                onPressed: () => registerLogic(context),
              ),
              const Gap(20),
              const AlreadyHaveAccountText(),
              registerListener(),
            ],
          ),
        ),
      ),
    );
  }

  void registerLogic(BuildContext context) {
    if (formKey.currentState!.validate()) {
      username = usernameController.text;
      email = emailController.text;
      password = passwordController.text;
      phoneNumber = phoneNumberController.text;
      BlocProvider.of<RegisterCubit>(context).register(
          username: username!,
          email: email!,
          password: password!,
          phoneNumber: phoneNumber!);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  BlocListener<RegisterCubit, RegisterState> registerListener() {
    return BlocListener<RegisterCubit, RegisterState>(
        child: const SizedBox.shrink(),
        listener: (context, state) {
          if (state is RegisterLoading) {
          } else if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.greenAccent, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                content: const Text('Admin Account Created Successfully',
                    style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.green,
              ),
            );

            GoRouter.of(context).go(AppRoutes.kLoginView);
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red.shade800, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                content: Text(
                  state.error,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
  }
}

class RegisterButtonBlocBuilder extends StatelessWidget {
  const RegisterButtonBlocBuilder({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomButton(
          onPressed: onPressed,
          text: 'Register',
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
    final RegisterState state = context.watch<RegisterCubit>().state;
    return ElevatedButton(
      onPressed: state is RegisterLoading ? () {} : onPressed,
      child: state is RegisterLoading
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
