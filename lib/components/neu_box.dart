import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;


  const NeuBox({
    super.key,
    required this.child,
});

  @override
  Widget build(BuildContext context) {

    bool IsDarkMode = Provider.of<ThemeProvider>(context).IsDarkMode;

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(color: IsDarkMode ? Colors.black : Colors.grey.shade300,
        blurRadius: 15,
        offset: const Offset(4,4)
               ),
      
       BoxShadow(color: IsDarkMode ? Colors.grey.shade500 : Colors.white,
        blurRadius: 15,
        offset: const Offset(-4,-4 )
               )
      ]
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}