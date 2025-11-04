import 'package:flutter/material.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/pages/home_pages.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, MultiProvider, Provider;

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(create: (context) => ProviderSong()),

    ],
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePages(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
