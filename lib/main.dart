import 'package:e_c_website/Screens/productcatalog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      theme: ThemeData(
        primaryColor: const Color(0xFF333333),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: ProductCatalogScreen(),
    );
  }
}
