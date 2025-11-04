import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S E T T I N G S"),
      ),
      body: Container(
        decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode",style: TextStyle(fontWeight: FontWeight.bold),),

            CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).IsDarkMode,
             onChanged: (value) => Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
             ),
          ],
        ),
      ),
    );
  }
}