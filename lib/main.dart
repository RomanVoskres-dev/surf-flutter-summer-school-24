import '../feature/theme/domain/theme_controller.dart';
import '../feature/theme/data/theme_repository.dart';
import '../storage/theme/theme_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeStorage = ThemeStorage(
    prefs: prefs,
  );
  final themeRepository = ThemeRepository(
    themeStorage: themeStorage,
  );
  final themeController = ThemeController(
    themeRepository: themeRepository,
  );

  runApp(MaterialApp(home: HomePage(themeController: themeController)));
}