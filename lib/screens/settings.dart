import 'package:flutter/material.dart';
import 'package:ir_remote_control/state/custom_buttons_state.dart';
import 'package:ir_remote_control/state/user_preferences_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userPreferences = Provider.of<UserPreferencesStateManager>(context);
    final customButtons = Provider.of<CustomButtonsStateManager>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "Select your prefered theme",
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            DropdownMenu(
              width: double.infinity,
              textStyle: TextStyle(
                color: theme.colorScheme.onTertiaryContainer,
              ),
              initialSelection: userPreferences.getPreference("theme"),
              onSelected: (value) =>
                  userPreferences.setPreference("theme", value),
              menuStyle: MenuStyle(
                backgroundColor:
                    WidgetStatePropertyAll(theme.colorScheme.tertiaryContainer),
              ),
              dropdownMenuEntries: [
                DropdownMenuEntry(
                  value: "light",
                  leadingIcon: Icon(
                    Icons.light_mode,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                  label: "Light Mode",
                ),
                DropdownMenuEntry(
                  value: "dark",
                  leadingIcon: Icon(
                    Icons.dark_mode,
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                  label: "Dark Mode",
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Remove All Buttons'),
                        content: const Text(
                            'Are you sure you want to remove all your buttons?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              customButtons.removeButtons();
                            },
                            child: const Text('Reset'),
                          ),
                        ],
                      );
                    });
              },
              child: const Text('Remove All Buttons'),
            ),
          ],
        ),
      ),
    );
  }
}
