import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laundry_app/config/app_session.dart';
import 'package:laundry_app/pages/auth/login_page.dart';
import 'package:laundry_app/pages/dahboard/dashboard_page.dart';

import 'config/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zaza',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.latoTextTheme(),
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary[400]!,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(AppColors.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                padding: const MaterialStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
                textStyle:
                    const MaterialStatePropertyAll(TextStyle(fontSize: 15)))),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: AppSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const LoginPage();
          }
          return const DashboardPage();
        },
      ),
    );
  }
}
