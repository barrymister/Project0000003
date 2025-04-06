import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/file_history_provider.dart';
import 'providers/format_provider.dart';
import 'providers/template_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CosmoscribeApp());

  if (Platform.isAndroid) {
    // Handle app lifecycle to clean up resources
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      if (msg == AppLifecycleState.detached.toString()) {
        await SystemNavigator.pop();
      }
      return null;
    });
  }
}

class CosmoscribeApp extends StatefulWidget {
  const CosmoscribeApp({super.key});

  @override
  State<CosmoscribeApp> createState() => _CosmoscribeAppState();
}

class _CosmoscribeAppState extends State<CosmoscribeApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      // Clean up any resources when app is being terminated
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FileHistoryProvider()),
        ChangeNotifierProvider(create: (_) => TemplateProvider()),
        ChangeNotifierProvider(create: (_) => FormatProvider()),
      ],
      child: MaterialApp(
        title: 'Cosmoscribe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
