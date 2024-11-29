import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_vision/flutter_vision.dart';
import '../models/obj_detection.dart';
import '../main.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ScanPage> {
  CameraController? _cameraController;
  bool _isModelLoaded = false;
  List<TrackedObject> _trackedObjects = [];
  int _frameCount = 0;
  int _nextTrackId = 0;

  static const int detectionInterval = 1;
  static const int maxTrackingAge = 15;
  static const double iouThreshold = 0.5;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
    setState(() {
      _isModelLoaded = true;
    });
    _cameraController?.startImageStream(_processCameraImage);
  }

  double _calculateIoU(Rect box1, Rect box2) {
    final intersection = box1.intersect(box2);
    if (intersection.isEmpty) return 0.0;

    final intersectionArea = intersection.width * intersection.height;
    final box1Area = box1.width * box1.height;
    final box2Area = box2.width * box2.height;

    return intersectionArea / (box1Area + box2Area - intersectionArea);
  }

  void _updateTracking(List<dynamic> detections, Size frameSize) {
    final scaleX = frameSize.width / _cameraController!.value.previewSize!.height;
    final scaleY = frameSize.height / _cameraController!.value.previewSize!.width;

    List<TrackedObject> newTrackedObjects = [];
    List<bool> detectionMatched = List.filled(detections.length, false);

    double adjustmentFactor = 0.03;
    double heightAdjustmentFactor = .83;

    for (var trackedObj in _trackedObjects) {
      bool matched = false;

      for (int i = 0; i < detections.length; i++) {
        if (detectionMatched[i]) continue;

        final detection = detections[i];
        final boundingBox = detection['box'];

        final newRect = Rect.fromLTRB(
          boundingBox[0] * scaleX,
          boundingBox[1] * scaleY - (boundingBox[3] * scaleY * adjustmentFactor),
          boundingBox[2] * scaleX,
          boundingBox[1] * scaleY + (boundingBox[3] * scaleY * heightAdjustmentFactor) - (boundingBox[3] * scaleY * adjustmentFactor),
        );

        final iou = _calculateIoU(trackedObj.boundingBox, newRect);
        if (iou > iouThreshold) {
          trackedObj.boundingBox = newRect;
          trackedObj.confidence = boundingBox[4];
          trackedObj.lastUpdateFrame = _frameCount;
          newTrackedObjects.add(trackedObj);
          detectionMatched[i] = true;
          matched = true;
          break;
        }
      }

      if (!matched && (_frameCount - trackedObj.lastUpdateFrame) < maxTrackingAge) {
        newTrackedObjects.add(trackedObj);
      }
    }

    for (int i = 0; i < detections.length; i++) {
      if (!detectionMatched[i]) {
        final detection = detections[i];
        final boundingBox = detection['box'];

        newTrackedObjects.add(TrackedObject(
          boundingBox: Rect.fromLTRB(
            boundingBox[0] * scaleX,
            boundingBox[1] * scaleY - (boundingBox[3] * scaleY * adjustmentFactor),
            boundingBox[2] * scaleX,
            boundingBox[1] * scaleY + (boundingBox[3] * scaleY * heightAdjustmentFactor) - (boundingBox[3] * scaleY * adjustmentFactor),
          ),
          label: detection['tag'],
          confidence: boundingBox[4],
          trackId: _nextTrackId++,
          lastUpdateFrame: _frameCount,
        ));
      }
    }

    setState(() {
      _trackedObjects = newTrackedObjects;
    });
  }

  Future<void> _processCameraImage(CameraImage cameraImage) async {
    if (_cameraController == null || !_isModelLoaded) return;

    _frameCount++;

    if (_frameCount % detectionInterval == 0) {
      final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5,
      );

      _updateTracking(result, Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ));
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isModelLoaded? 
      Stack(
        children: [
          SizedBox.expand(
            child: CameraPreview(_cameraController!),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 4, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white70,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Snapfolia Go", style: TextStyle(fontSize: 23, color: Colors.white70, fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(
                      width: 125,
                    ),
                    Icon(Icons.menu, size: 35, color: Colors.white70,)
                  ],
                ),
              ),
            ),
          ),
          CustomPaint(
            painter: TrackedObjectPainter(_trackedObjects),
            child: Container(),
          ),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
