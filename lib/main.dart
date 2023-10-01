import 'package:eventhub/colors/colors.dart';
import 'package:eventhub/views/checksession.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
        appBarTheme: const AppBarTheme(centerTitle: true),
        textTheme: TextTheme(
          titleSmall: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kPrimary,
          ),
          titleLarge: GoogleFonts.poppins(
            fontSize: 45,
            fontWeight: FontWeight.w500,
            color: kPrimary,
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: kPrimary,
          ),
        ),
      ),
      home: const CheckSession(),
    );
  }
}
