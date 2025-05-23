import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:social_e_commerce/webview.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.asset('assets/videos/splash_video.mp4')
      ..initialize().then((_) {
        setState(() {
          _videoInitialized = true;
        });
        _controller.play();
        _controller.setLooping(false);

        // Navigate when video ends
        _controller.addListener(() {
          if (_controller.value.position >= _controller.value.duration &&
              mounted) {
            _navigateToWebViewPage();
          }
        });
      }).catchError((error) {
        print("Video initialization error: $error");
        // Navigate if error occurs
        _navigateToWebViewPage();
      });
  }

  void _navigateToWebViewPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoInitialized
          ? Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
