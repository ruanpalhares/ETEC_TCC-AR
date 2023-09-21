import 'package:automcao_residencial/presentation/pages/help_page.dart';
import 'package:automcao_residencial/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

class Aplicacao extends StatelessWidget {
  const Aplicacao({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iluminacao',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/help':(context) => const HelpPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}