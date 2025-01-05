import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ir_remote_control/services/ir_service.dart';
import 'package:ir_remote_control/state/custom_buttons_state.dart';
import 'package:ir_remote_control/themes/app_themes.dart';
import 'package:ir_remote_control/utils/icon_utils.dart';
import 'package:provider/provider.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonState =
        Provider.of<CustomButtonsStateManager>(context, listen: true);
    final buttons = buttonState.buttons;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 0,
            maxHeight: double.infinity,
          ),
          child: Column(
            children: buttons
                .asMap()
                .entries
                .map((entry) => Builder(builder: (context) {
                      final button = entry.value;

                      final primaryColor = button.themeHex != null
                          ? colorFromHex(button.themeHex!)!
                          : CustomButtonThemes.blueTheme;
                      final colorScheme = ColorScheme.fromSeed(
                          seedColor: primaryColor, primary: primaryColor);

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: colorScheme.primary,
                        child: ListTile(
                          leading: button.iconCodePoint != null
                              ? Icon(
                                  getIconFromCodePoint(button.iconCodePoint!),
                                  size: 32,
                                  color: colorScheme.onPrimary)
                              : Icon(null),
                          title: Text(
                            button.label,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () async {
                            try {
                              await IRService.sendNEC(
                                int.parse(button.address, radix: 16),
                                int.parse(button.command, radix: 16),
                              );

                              HapticFeedback.mediumImpact();
                              
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "No IR Transmitter Found",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            "Please make sure that your IR transmitter is connected and powered on.",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete,
                                color: colorScheme.onPrimary),
                            onPressed: () async {
                              buttonState.removeButton(button.uuid);
                            },
                          ),
                        ),
                      );
                    }))
                .toList(),
          ),
        ),
      ),
    );
  }
}
