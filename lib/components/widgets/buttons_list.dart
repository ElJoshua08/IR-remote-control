import 'package:flutter/material.dart';
import 'package:ir_remote_control/services/ir_service.dart';
import 'package:ir_remote_control/state/buttons_state.dart';
import 'package:provider/provider.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<ButtonStateManager>(context);
    final buttons = buttonState.buttons;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildButtonTile(context, buttonState, buttons[0], 0)
        // child: ListView(
        //   children: buttons.asMap().entries.map((entry) => _buildButtonTile(context, buttonState, entry.value, entry.key)).toList(),
        // ),
        );
  }

  Widget _buildButtonTile(
    BuildContext context,
    ButtonStateManager buttonState,
    ButtonBase button,
    int index,
  ) {
    if (button is ToggleButton) {
      return _buildToggleButtonTile(context, buttonState, button, index);
    } else if (button is SimpleButton) {
      return _buildSimpleButtonTile(context, buttonState, button, index);
    } else {
      return const SizedBox(); // For unsupported button types
    }
  }

  Widget _buildToggleButtonTile(
    BuildContext context,
    ButtonStateManager buttonState,
    ToggleButton button,
    int index,
  ) {
    final isOn = button.isOn;
    final currentState = isOn ? button.onState : button.offState;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: currentState.backgroundColor,
      child: ListTile(
        leading: currentState.icon != null
            ? Icon(
                currentState.icon,
                size: 48,
              )
            : null,
        title: Text(currentState.name),
        onTap: () async {
          await IRService.sendNEC(
            int.parse(button.address, radix: 16),
            int.parse(button.command, radix: 16),
          );
          button.toggle();
          buttonState.updateButton(index, button);
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            buttonState.removeButton(index);
          },
        ),
      ),
    );
  }

  Widget _buildSimpleButtonTile(
    BuildContext context,
    ButtonStateManager buttonState,
    SimpleButton button,
    int index,
  ) {
    final colorScheme =
        ColorScheme.fromSeed(seedColor: button.theme.buttonColor);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: colorScheme.primary,
      child: ListTile(
        leading: Icon(button.icon, size: 32, color: colorScheme.onPrimary),
        title: Text(
          button.label,
          style: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
        onTap: () async {
          await IRService.sendNEC(
            int.parse(button.address, radix: 16),
            int.parse(button.command, radix: 16),
          );
        },
        trailing: IconButton(
          icon: Icon(Icons.delete, color: colorScheme.onPrimary),
          onPressed: () {
            buttonState.removeButton(index);
          },
        ),
      ),
    );
  }
}
