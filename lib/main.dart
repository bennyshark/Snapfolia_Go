import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:snapfolia_go/pages/homepage.dart';
import 'pages/scan_page.dart';

late FlutterVision vision;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

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
      title: 'ABY Prototype',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const home_page(),
    );
  }
}