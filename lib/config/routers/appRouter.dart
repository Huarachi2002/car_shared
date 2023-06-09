import 'package:go_router/go_router.dart';
import 'package:car_share/features/auth/presentacion/screens/screens.dart';
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
    ),
  ]
);
