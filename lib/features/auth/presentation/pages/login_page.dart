// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/routes.dart';
import 'package:blog_app/core/theme/palette.dart';
import 'package:blog_app/core/widgets/gap.dart';
import 'package:blog_app/core/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/core/widgets/themeButton.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/core/widgets/input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static String routeName = '/Login-page';
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            return showToastError(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          if (state is AuthSucces) {
            context.go(SignupPage.routeName);
          }
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Sign In.",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Gap(
                    axis: 'y',
                    height: 30,
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
                    title: 'Sign In',
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthLogin(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim()));
                      }
                    },
                  ),
                  const Gap(
                    axis: 'y',
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(SignupPage.routeName);
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Don\'t have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                              text: 'Sign Up',
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
            ),
          );
        },
      ),
    );
  }
}
