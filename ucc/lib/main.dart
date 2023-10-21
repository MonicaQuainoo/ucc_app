import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:logged/src/screens/models/bars.dart';
import 'package:logged/src/screens/webview.dart';
import 'package:logged/src/services/active_class.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  FlutterWindowManager.addFlags(
    FlutterWindowManager.FLAG_SECURE,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elearning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: ChangeNotifierProvider(
        create: (context) => ActiveState(),
        builder: (context, child) {
          final customDataProvider = Provider.of<ActiveState>(context);
          customDataProvider.initialise();
          final observer = MyWidgetsBindingObserver(customDataProvider);
          WidgetsBinding.instance.addObserver(observer);
          observer.activeState.dispose();
          return const WebViewApp();
        },
      ),
    );
  }
}
