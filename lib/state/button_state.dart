import 'package:flutter/material.dart';

// Abstract base class for all button types
abstract class ButtonBase {
  final String type;
  final String address;
  final String command;

  ButtonBase({
    required this.type,
    required this.address,
    required this.command,
  });
}

// Specific implementation for ToggleButton
class ToggleButton extends ButtonBase {
  final ButtonStateDetails onState;
  final ButtonStateDetails offState;
  bool isOn; // Tracks the current state

  ToggleButton({
    required super.address,
    required super.command,
    required this.onState,
    required this.offState,
    this.isOn = false,
  }) : super(
          type: 'toggle',
        );

  void toggle() {
    isOn = !isOn;
  }
}

// Specific implementation for SimpleButton
class SimpleButton extends ButtonBase {
  final String label;

  SimpleButton({
    required super.address,
    required super.command,
    required this.label,
  }) : super(
          type: 'simple',
        );
}

// Common state details for buttons
class ButtonStateDetails {
  final String name;
  final IconData? icon;
  final Color? backgroundColor;

  ButtonStateDetails({
    required this.name,
    this.icon,
    this.backgroundColor,
  });
}

// Button state manager
class ButtonStateManager extends ChangeNotifier {
  final List<ButtonBase> _buttons = [];

  List<ButtonBase> get buttons => _buttons;

  void addButton(ButtonBase button) {
    _buttons.add(button);
    notifyListeners();
  }

  void removeButton(int index) {
    _buttons.removeAt(index);
    notifyListeners();
  }

  void updateButton(int index, ButtonBase newButton) {
    _buttons[index] = newButton;
    notifyListeners();
  }
}
