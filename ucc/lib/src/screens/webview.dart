import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logged/src/screens/navigation_controls.dart';
import 'package:logged/src/screens/webview_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  // ActiveState activeState = ActiveState();
  @override
  void initState() {
    super.initState();
    // activeState.initialise();
  
    enableKioskMode();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://elearning.ucc.edu.gh/login/index.php'),
      );

      
    showDialogpop(context);

      

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elearning'),
        actions: [
          NavigationControls(controller: controller),
        ],
      ),
      body: WebViewStack(
        controller: controller,
      ),
    );
  }

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


}
