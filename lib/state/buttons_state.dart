import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ir_remote_control/themes/app_themes.dart';

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
  final IconData? icon;
  final CustomButtonTheme theme;

  SimpleButton({
    required super.address,
    required super.command,
    required this.label,
    this.icon,
    required this.theme,
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
  late final Box<dynamic> buttonsBox;
  List<ButtonBase> _buttons = [];

  ButtonStateManager() {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    // Open Hive boxes
    buttonsBox = await Hive.openBox('buttons');

    // Load buttons from the box or initialize an empty list
    _buttons = buttonsBox.get('buttons', defaultValue: <ButtonBase>[])
        as List<ButtonBase>;
    notifyListeners();
  }

  List<ButtonBase> get buttons => _buttons;

  void addButton(ButtonBase button) {
    _buttons.add(button);
    buttonsBox.put('buttons', _buttons);
    notifyListeners();
  }

  void removeButton(int index) {
    _buttons.removeAt(index);
    buttonsBox.put('buttons', _buttons);
    notifyListeners();
  }

  void updateButton(int index, ButtonBase newButton) {
    _buttons[index] = newButton;
    buttonsBox.put('buttons', _buttons);
    notifyListeners();
  }
}
