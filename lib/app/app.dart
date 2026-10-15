import 'package:flutter/material.dart';
import 'package:smriti_setu/app/routes.dart';
import 'package:smriti_setu/app/theme/app_theme.dart';

/// The root application widget for Smriti Setu.
class SmritiSetuApp extends StatelessWidget {
  const SmritiSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smriti Setu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
