import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slad_app/auth/auth_service.dart';
import 'package:slad_app/firebase_options.dart';
import 'package:slad_app/pages/dashboard_page.dart';
import 'package:slad_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
      redirect: (context, state) {
        if (AuthService.currentUser == null) {
          return LoginPage.routeName;
        }
        return null;
      },
      routes: [
        GoRoute(
          name: DashboardPage.routeName,
          path: DashboardPage.routeName,
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        )
      ]);
}
