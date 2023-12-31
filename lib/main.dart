import 'package:flutter/material.dart';
import 'package:logged/src/config/config.dart';
import 'package:logged/src/screens/models/bars.dart';
import 'package:logged/src/screens/webview.dart';
import 'package:logged/src/services/active_class.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await configureApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  final _activeState = ActiveState();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration()).then((_) async {
      await _activeState.initialise();
      final observer = MyWidgetsBindingObserver(_activeState);
      WidgetsBinding.instance.addObserver(observer);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Elearning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.dmSansTextTheme(),
        ),
        navigatorKey: navigatorKey,
        home: ChangeNotifierProvider(
          create: (context) => _activeState,
          builder: (context, child) => const WebViewApp(),
        ),
      );
}
