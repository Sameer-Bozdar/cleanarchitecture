// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/routes.dart';
import 'package:blog_app/core/theme/palette.dart';
import 'package:blog_app/core/widgets/gap.dart';
import 'package:blog_app/core/widgets/loader.dart';
import 'package:blog_app/core/widgets/themeButton.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/core/widgets/input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/show_snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();

  static String routeName = '/sign-up';
}

class _SignupPageState extends State<SignupPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showToastError(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Sign Up.",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Gap(
                    axis: 'y',
                    height: 30,
                  ),
                  Input(
                    hint: 'Name',
                    controller: _nameController,
                  ),
                  const Gap(
                    axis: 'y',
                    height: 15,
                  ),
                  Input(
                    controller: _emailController,
                    hint: 'Email',
                  ),
                  const Gap(
                    axis: 'y',
                    height: 15,
                  ),
                  Input(
                    controller: _passwordController,
                    hint: 'Password',
                    isObscureText: true,
                  ),
                  const Gap(
                    axis: 'y',
                    height: 20,
                  ),
                  ThemeButton(
                    title: 'Sign Up',
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            _emailController.text.trim(),
                            _nameController.text.trim(),
                            _passwordController.text.trim()));
                      }
                      ;
                    },
                  ),
                  const Gap(
                    axis: 'y',
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(LoginPage.routeName);
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold))
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
