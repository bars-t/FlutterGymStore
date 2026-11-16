import 'package:flutter/material.dart';
import 'sayfalar/ana_ekran.dart';

void main() {
  runApp(const GymStoreUygulamasi());
}

class GymStoreUygulamasi extends StatelessWidget {
  const GymStoreUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'gymStore',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const AnaEkran(),
    );
  }
}
