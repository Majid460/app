import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class TextTest extends StatefulWidget {
  const TextTest({super.key});

  @override
  State<TextTest> createState() => _Text();
}

class _Text extends State<TextTest> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  List<ImageProvider> imageList = <ImageProvider>[];
  bool autoRotate = false;
  int rotationCount = 1;
  int swipeSensitivity = 1;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.clockwise;
  Duration frameChangeDuration = const Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 12; i++) {
      imageList
          .add(AssetImage('lib/src/resources/assets/images/avatars/$i.png'));
      await precacheImage(
          AssetImage('lib/src/resources/assets/images/avatars/$i.png'),
          context);
    }
    setState(() {
      imagePrecached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 72.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (imagePrecached == true)
                      ? ImageView360(
                          key: UniqueKey(),
                          imageList: imageList,
                          autoRotate: autoRotate,
                          rotationCount: rotationCount,
                          rotationDirection: rotationDirection,
                          frameChangeDuration: const Duration(milliseconds: 30),
                          swipeSensitivity: swipeSensitivity,
                          allowSwipeToRotate: allowSwipeToRotate,
                          onImageIndexChanged: (currentImageIndex) {
                            print("currentImageIndex: $currentImageIndex");
                          },
                        )
                      : const Text("Pre-Caching images..."),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Optional features:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("Auto rotate: $autoRotate"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("Rotation count: $rotationCount"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("Rotation direction: $rotationDirection"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                        "Frame change duration: ${frameChangeDuration.inMilliseconds} milliseconds"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                        "Allow swipe to rotate image: $allowSwipeToRotate"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text("Swipe sensitivity: $swipeSensitivity"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
