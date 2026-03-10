import 'package:flutter/material.dart';
import 'screens/scan_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MoticonApp());
}

class MoticonApp extends StatelessWidget {
  const MoticonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moticon Insoles',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ScanPage(),
    );
  }
}