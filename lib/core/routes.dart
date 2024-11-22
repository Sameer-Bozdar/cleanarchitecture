import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:go_router/go_router.dart';

GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Define routes
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: SignupPage.routeName,
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: LoginPage.routeName,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: AddNewBlogScreen.routeName,
      builder: (context, state) => AddNewBlogScreen(),
    )
  ],
);
