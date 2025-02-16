import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:snapfolia_go/pages/about_page.dart';
import 'package:snapfolia_go/pages/almanac_page.dart';
import 'package:snapfolia_go/pages/developers_page.dart';
import 'package:snapfolia_go/pages/home_page.dart';
import 'pages/scan_page.dart';

late FlutterVision vision;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  vision = FlutterVision();
  await vision.loadYoloModel(
    labels: 'assets/labels36class.txt',
    modelPath: 'assets/best36.tflite',
    modelVersion: "yolov8",
    quantization: false,
    numThreads: 1,
    useGpu: false,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
          '/almanac': (context) => const AlmanacPage(),
          '/developers': (context) => const DevelopersPage(),
          '/scan': (context) =>const ScanPage(),
        });
  }
}
