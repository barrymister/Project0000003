import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/theme_constants.dart';
import 'providers/app_providers.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const CosmoscribeApp());
}

class CosmoscribeApp extends StatelessWidget {
  const CosmoscribeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TemplateProvider()),
        ChangeNotifierProvider(create: (_) => FormatProvider()),
      ],
      child: MaterialApp(
        title: 'Cosmoscribe',
        theme: AppTheme.getTheme(),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
