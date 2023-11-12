import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logged/src/screens/constants/logs.dart';
import 'package:logged/src/screens/webview_stack.dart';
import 'package:logged/src/screens/widgets/camera_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'navigation_controls.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  var _toggleCameraPreview = false, _loadingPercentage = 0;

  // ActiveState activeState = ActiveState();
  @override
  void initState() {
    super.initState();
    // activeState.initialise();

    enableKioskMode();
    _loadUrl();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Elearning'),
          actions: [
            if (!_toggleCameraPreview) ...{
              NavigationControls(controller: _controller),
            },
            CameraView(
              startCameraPreview: _toggleCameraPreview,
              onPermissionDenied: _handlePermissionDenied,
            ),
          ],
        ),
        body: WebViewStack(
            controller: _controller, loadingPercentage: _loadingPercentage),
      );

  void disableKioskMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  void enableKioskMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  void _loadUrl([String? url]) {
    _controller.loadRequest(
        Uri.parse(url ?? 'https://elearning.ucc.edu.gh/login/index.php'));
    _listenForUrlChanges();
  }

  void _listenForUrlChanges() => _controller.setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (url) {
            setState(() => _loadingPercentage = 0);
            // log the url
            logger.i('url updated to -> ${url.url}');
            if (url.url == null) return;

            // @todo -> when url matches a certain pattern, toggle camera preview
            var quizOrExamUrlRegex = RegExp(
                r'https:\/\/elearning\.ucc\.edu\.gh\/mod\/quiz\/view\.php\?id=\d+');
            _toggleCameraPreview = quizOrExamUrlRegex.hasMatch(url.url!);
            setState(() {});
          },
          onProgress: (progress) =>
              setState(() => _loadingPercentage = progress),
        ),
      );

  void _handlePermissionDenied() async {
    // @todo -> handle state when user denies camera permission
  }
}
