import 'package:flutter/material.dart';
import 'package:ir_remote_control/themes/app_themes.dart';

class ThemePicker extends StatefulWidget {
  final Function(CustomButtonTheme) onThemeSelect;

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
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: IconButton(
              icon: _selectedTheme == theme
                  ? Icon(Icons.check, color: theme.labelColor)
                  : Icon(null),
              iconSize: 32, // Make the icon button circular
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.buttonColor,
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
