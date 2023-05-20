import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gp/core/Colors/colors.dart';
import 'package:gp/core/widgets.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ColoredPoint {
  final Offset offset;
  final Color color;

  ColoredPoint(this.offset, this.color);
}

class TracingGame extends StatefulWidget {
  @override
  TracingGameState createState() => TracingGameState();
}

class TracingGameState extends State<TracingGame> {
  List<ColoredPoint?> _points = [];
  List<File> screenshots = [];
  ScreenshotController screenshotController = ScreenshotController();
  Color _currentColor = Colors.black;
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing Game'),
        backgroundColor: MyColors.color3,
        actions: [
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: _showScreenshots,
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: Screenshot(
            controller: screenshotController,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  _points = List.from(_points)
                    ..add(ColoredPoint(localPosition, _currentColor));
                });
              },
              onPanEnd: (details) {
                _points.add(null);
              },
              child: RepaintBoundary(
                key: _screenshotKey,
                child: CustomPaint(
                  painter: TracingPainter(_points, _currentColor),
                  size: Size.infinite,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 60),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Pick color'),
                  IconButton(
                    iconSize: 100,
                    icon: Icon(
                      Icons.color_lens,
                      color: MyColors.color3,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pick a color'),
                            content: BlockPicker(
                              pickerColor: _currentColor,
                              onColorChanged: (color) {
                                setState(() {
                                  _currentColor = color;
                                  Navigator.pop(context);
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Clear'),
                  IconButton(
                    iconSize: 100,
                    icon: Icon(
                      Icons.clear,
                      color: MyColors.color4,
                    ),
                    onPressed: () {
                      setState(() {
                        _points.clear();
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Save'),
                  IconButton(
                    iconSize: 100,
                    icon: Icon(
                      Icons.camera_alt,
                      color: MyColors.color2,
                    ),
                    onPressed: _captureScreenshot,
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Future<void> _captureScreenshot() async {
    // Capture a screenshot of the tracing game widget
    final image = await screenshotController.capture();
    // Save the screenshot to external storage
    final directory = await getExternalStorageDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final file = File('${directory!.path}/tracing_game_$timestamp.png');
    await file.writeAsBytes(image!.buffer.asUint8List());
    // Add the screenshot to the list of screenshots
    setState(() {
      screenshots.add(file);
    });
  }

  Future<void> _showScreenshots() async {
    // Show a dialog that displays a list of the screenshots
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Screenshots'),
          content: Container(
            width: double.maxFinite,
            height: 300.0,
            child: ListView.builder(
              itemCount: screenshots.length,
              itemBuilder: (BuildContext context, int index) {
                String idx = index.toString();
                return GestureDetector(
                  onTap: () {
                    // Navigate to a new screen that shows the selected screenshot
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(
                              title: Text("Drawing  ${idx}"),
                            ),
                            body: Center(
                              child: Hero(
                                tag: 'Drawing_${screenshots[index].path}',
                                child: Image.file(screenshots[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: Text('Screenshot ${index + 1}'),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class TracingPainter extends CustomPainter {
  final List<ColoredPoint?> points;
  final Color color;

  TracingPainter(this.points, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!.offset, points[i + 1]!.offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(TracingPainter oldDelegate) {
    return true;
  }
}
