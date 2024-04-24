import 'package:flutter/material.dart';
import 'package:ets_ppb/pages/edit_books_page.dart';
import 'package:ets_ppb/pages/books_page.dart';

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
      title: 'Books Collection',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: const Color.fromRGBO(38, 50, 56, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.white
          )
        ),
        useMaterial3: true,
      ),
      home: const BooksPage(),
    );
  }
}