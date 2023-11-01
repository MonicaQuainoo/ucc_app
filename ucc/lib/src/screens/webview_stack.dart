import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:logged/src/screens/constants/logs.dart';
import 'package:logged/src/screens/models/bars.dart';
import 'package:logged/src/screens/widgets/snackbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget with WidgetsBindingObserver {
  final int loadingPercentage;

  const WebViewStack(
      {required this.controller,
      required this.loadingPercentage,
      super.key}); // MODIFY

  final WebViewController controller; // ADD

  @override
  State<WebViewStack> createState() => WebViewStackState();
}

class WebViewStackState extends State<WebViewStack> {
  // REMOVE the controller that was here
  @override
  void initState() {
    super.initState();

    // widget.controller.setNavigationDelegate(
    //   NavigationDelegate(
    //     onPageStarted: (url) {
    //       setState(() {
    //         loadingPercentage = 0;
    //       });
    //     },
    //     onProgress: (progress) {
    //       setState(() {
    //         loadingPercentage = progress;
    //       });
    //     },
    //     onPageFinished: (url) {
    //       setState(() {
    //         loadingPercentage = 100;
    //       });
    //     },
    //   ),
    // );

    // @todo: Add the code from here...
    // ...to here.
    // Future.delayed(const Duration(seconds: 2), () {
    //   showDialogpop(context);
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this as WidgetsBindingObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          WebViewWidget(
            controller: widget.controller, // MODIFY
          ),
          if (widget.loadingPercentage < 100)
            LinearProgressIndicator(
              value: widget.loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}

Future<void> showDialogPop(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (BuildContext ctx) => AlertDialog(
      title: const Text('Agree to the following permissions'),
      content: const SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('1.Turn your device flight mode on.'),
            Text(
                '2. You should only be able to connect to the WIFI network to start quiz/ exams.'),
            Text(
                '3. You are not allowed to exit the application when the quiz start.'),
            Text('4. After 3 exit attempts you will be logged out of the app.')
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            closeAppUsingSystemPop();
          },
        ),
        Builder(
            builder: (ctx) => TextButton(
                  child: const Text('Agree'),
                  onPressed: () async {
                    final status =
                        await AirplaneModeChecker.checkAirplaneMode();
                    logger.d(status.name);
                    if (status.name == 'off') {
                      // ignore: use_build_context_synchronously
                      await showSnackBar(
                          ctx,
                          const Text(
                              'Flight Mode is Off, Turn it On to Proceed',
                              style: TextStyle(color: Colors.white)),
                          Colors.red);
                    }
                    Navigator.of(ctx).pop(); // Close the dialog
                  },
                )),
      ],
    ),
  );
}
