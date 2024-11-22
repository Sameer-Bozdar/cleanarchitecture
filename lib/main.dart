import 'package:blog_app/core/cubit/app_user_cubit.dart';
import 'package:blog_app/core/init_dependencies.dart';
import 'package:blog_app/core/routes.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserCubit;
      },
      builder: (context, isLoggedIn) {
        if (isLoggedIn) {
          return const BlogScreen();
        }

        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'Blog App',
          theme: AppTheme.darkThemeMode,
        );
      },
    );
  }
}
