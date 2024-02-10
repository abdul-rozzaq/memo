import 'package:flutter/material.dart';
import 'package:memo/providers/app_provider.dart';
import 'package:memo/screens/home_screen.dart';
import 'package:memo/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppProvider())],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
