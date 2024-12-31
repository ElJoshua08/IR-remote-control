import 'package:flutter/material.dart';
import 'package:ir_remote_control/state/button_state.dart';
import 'package:provider/provider.dart';
import 'package:ir_remote_control/services/ir_service.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonState = Provider.of<ButtonStateManager>(context);
    final buttons = buttonState.buttons;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          final button = buttons[index];

          return _buildButtonTile(context, buttonState, button, index);
        },
      ),
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.grey[200],
      child: ListTile(
        leading: const Icon(Icons.radio_button_unchecked, size: 48),
        title: Text(button.label),
        onTap: () async {
          await IRService.sendNEC(
            int.parse(button.address, radix: 16),
            int.parse(button.command, radix: 16),
          );
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
}
