import 'package:flutter/material.dart';
import 'package:ir_remote_control/themes/app_themes.dart';

class ThemePicker extends StatefulWidget {
  final Function(Color) onThemeSelect;

  const ThemePicker({super.key, required this.onThemeSelect});

  @override
  State<ThemePicker> createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  var _selectedTheme = CustomButtonThemes.blueTheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: CustomButtonThemes.customThemes.map((theme) {
          var colorScheme = ColorScheme.fromSeed(
            seedColor: theme,
            primary: theme,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: IconButton(
              icon: _selectedTheme == theme
                  ? Icon(Icons.check, color: colorScheme.onPrimary)
                  : Icon(null),
              iconSize: 32, // Make the icon button circular
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: CircleBorder(),
              ),
              onPressed: () {
                setState(() {
                  _selectedTheme = theme;
                });

                widget.onThemeSelect(theme); // Call the callback function
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
