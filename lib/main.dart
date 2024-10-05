import 'package:flutter/material.dart';
import 'package:gallery/screens/gallery_screen/gallery_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery',
      theme: ThemeData(),
      home: GalleryPage(),
    );
  }
}
