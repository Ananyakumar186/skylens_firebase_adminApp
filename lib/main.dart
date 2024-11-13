import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:slad_app/auth/auth_service.dart';
import 'package:slad_app/firebase_options.dart';
import 'package:slad_app/pages/add_telescope_page.dart';
import 'package:slad_app/pages/brand_page.dart';
import 'package:slad_app/pages/dashboard_page.dart';
import 'package:slad_app/pages/login_page.dart';
import 'package:slad_app/pages/view_telescope_page.dart';
import 'package:slad_app/providers/telescope_provider.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TelescopeProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
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
          routes: [
            GoRoute(
              name: AddTelescopePage.routeName,
              path: AddTelescopePage.routeName,
              builder: (context, state) => const AddTelescopePage(),
            ),
            GoRoute(
              name: ViewTelescopePage.routeName,
              path: ViewTelescopePage.routeName,
              builder: (context, state) => const ViewTelescopePage(),
            ),
            GoRoute(
              name: BrandPage.routeName,
              path: BrandPage.routeName,
              builder: (context, state) => const BrandPage(),
            )
          ]
        ),
        GoRoute(
          name: LoginPage.routeName,
          path: LoginPage.routeName,
          builder: (context, state) => const LoginPage(),
        )
      ]);
}
