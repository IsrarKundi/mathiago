import 'package:flutter/material.dart';
import 'package:social_e_commerce/webview.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startGifDisplay();
  }

  void _startGifDisplay() {
    // Show loading for a moment, then display GIF
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Navigate after GIF completes (adjust timing to match your GIF duration)
        Future.delayed(Duration(seconds: 4), () {
          if (mounted) {
            _navigateToWebViewPage();
          }
        });
      }
    });
  }

  void _navigateToWebViewPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading ? _buildLoadingWidget() : _buildGifWidget(),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 20),
          Text(
            'Loading...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGifWidget() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.cover, // or BoxFit.contain if you want to see the full GIF
        child: Image.asset(
          'assets/pngs/splash_video.gif',
          errorBuilder: (context, error, stackTrace) {
            print("GIF loading error: $error");
            // Navigate immediately if GIF fails
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToWebViewPage();
            });
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: Center(
                child: Text(
                  'Loading App...',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}