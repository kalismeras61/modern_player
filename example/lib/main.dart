import 'package:flutter/material.dart';
import 'package:modern_player/modern_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Player Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Modern Player Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VlcPlayerController? _controller;
  late ValueNotifier<bool> isFavoriteNotifier;
  Color? iconColor = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavoriteNotifier = ValueNotifier<bool>(true);
  }

  // Theme option for modern_player
  var themeOptions = ModernPlayerThemeOptions(
      backgroundColor: Colors.black,
      menuBackgroundColor: Colors.black,
      backIcon: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Colors.white,
      ),
      loadingColor: Colors.blue,
      menuIcon: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
      volumeSlidertheme: ModernPlayerToastSliderThemeOption(
          sliderColor: Colors.blue, iconColor: Colors.white),
      progressSliderTheme: ModernPlayerProgressSliderTheme(
          activeSliderColor: Colors.blue,
          inactiveSliderColor: Colors.white70,
          bufferSliderColor: Colors.black54,
          thumbColor: Colors.white,
          progressTextStyle: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.white, fontSize: 18)));

  @override
  Widget build(BuildContext context) {
    // Controls option for modern_player
    var controlsOptions = ModernPlayerControlsOptions(
        showControls: true,
        doubleTapToSeek: true,
        showMenu: true,
        showMute: false,
        showBackbutton: true,
        enableVolumeSlider: true,
        enableBrightnessSlider: true,
        showBottomBar: true,
        autoHideTime: const Duration(seconds: 5),
        isControlsVisible: (v) {},
        customActionButtons: [
          ModernPlayerCustomActionButton(
            icon: Icon(
              Icons.info_rounded,
              color: iconColor,
            ),
            onPressed: () async {
              setState(() {
                iconColor =
                    iconColor == Colors.black ? Colors.white : Colors.black;
              });
            },
          ),
        ]);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  ModernPlayer.createPlayer(
                    onControllerInitialized: (controller) {
                      _controller = controller;
                    },
                    controlsOptions: controlsOptions,
                    callbackOptions: ModernPlayerCallbackOptions(
                      onBackPressed: () {
                        // On Back Pressed
                        print("Back Pressed");
                      },
                      onChangedAudio: (audio) {
                        // On Audio Changed
                        print("Audio Changed");
                      },
                    ),
                    options: ModernPlayerOptions(
                      allowScreenSleep: true,
                    ),
                    video: ModernPlayerVideo.multiple([
                      ModernPlayerVideoData.youtubeWithUrl(
                          label: "DEdede",
                          url: "https://www.youtube.com/watch?v=alD3UHIBnY8"),
                      ModernPlayerVideoData.youtubeWithUrl(
                          label: "DEdede 2",
                          url: "https://www.youtube.com/watch?v=alD3UHIBnY8"),
                    ]),
                  ),
                  Positioned(
                    left: 100,
                    top: 100,
                    child: IconButton(
                      onPressed: () async {
                        _controller?.value.videoTracksCount;
                      },
                      icon: const Icon(Icons.abc, color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
