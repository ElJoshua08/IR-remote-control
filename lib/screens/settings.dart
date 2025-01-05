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
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Use dark mode?",
                        style: theme.textTheme.headlineSmall),
                    Switch(
                      value: userPreferences.getPreference("theme") == "dark",
                      onChanged: (value) {
                        userPreferences.setPreference(
                            "theme", value ? "dark" : "light");
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.tertiary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: theme.colorScheme.tertiary,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            spacing: 16,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Are you sure you want to remove all buttons?",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: theme.colorScheme.onTertiary,
                                    fontSize: 24),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      customButtons.removeButtons();
                                    },
                                    child: Text("Yes, remove buttons"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("No"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Text("Remove all Buttons",
                        style: TextStyle(
                            color: theme.colorScheme.onTertiary, fontSize: 24)),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        Icons.warning,
                        color: theme.colorScheme.onTertiary,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
