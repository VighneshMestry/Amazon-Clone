import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/feautres/auth/services/auth_service.dart';
// import 'package:amazon_clone/feautres/home/screens/home_screen.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feautres/admin/screen/admin_screen.dart';
import 'feautres/auth/screens/auth_screen.dart';

void main() {
  // wrapped with multiProvider so that provider can be used anywhere in the our application
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    // log(Provider.of<UserProvider>(context).user.token.isNotEmpty.toString());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          // ? Provider.of<UserProvider>(context).user.type == 'user'
          //     ? const BottomBar()
          //     : const AdminScreen()
          // : const AuthScreen(),
      // home: const BottomBar(),
    home: const AdminScreen(),
    );
  }
}
