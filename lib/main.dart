import 'package:book_store_app/Data/bookstore.dart';
import 'package:flutter/material.dart';

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
      home: Bookstore(),
    );
    // return ChangeNotifierProvider(
    //     create: (context) => CartModel(),
    // child: MaterialApp(
    //   debugShowCheckedModeBanner: false,
    // home: BookstoreApp(),
    // )
    // );
  }
}