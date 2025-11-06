import 'package:flutter/material.dart';
import 'package:music_player/models/provider_song.dart';
import 'package:music_player/pages/home_pages.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_pages.dart';
import 'models/provider_song.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderSong()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
      
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const HomePages(),
    );
  }
}
