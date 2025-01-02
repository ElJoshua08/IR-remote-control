import 'package:flutter/material.dart';
import 'package:ir_remote_control/main.dart';
import 'package:ir_remote_control/models/custom_buttons.dart';
import 'package:ir_remote_control/services/custom_buttons_service.dart';
import 'package:ir_remote_control/store.dart';

class CustomButtonsStateManager extends ChangeNotifier {
  final List<CustomButton> _buttons = [];

  CustomButtonsStateManager(ObjectBox objectBox) {
    _loadButtons();
  }

  // Load buttons from objectbox
  Future<void> _loadButtons() async {
    print("------ Loading custom buttons ------");

    final customButtons = CustomButtonsService(objectBox).getButtons();
    _buttons.clear();

    print("Total custom buttons: ${_buttons.length}");
    print("Custom buttons");
    for (var button in customButtons) {
      print(
          "Button with uuid: ${button.uuid}: label = ${button.label} || address = ${button.address} || command = ${button.command} || themeHex = ${button.themeHex} || iconCodePoint = ${button.iconCodePoint}");

      _buttons.add(button);
    }

    notifyListeners();
  }

  //* Here are the manager methods

  // Get all buttons
  List<CustomButton> get buttons => _buttons;

  // Add a new button to the state and database
  Future<void> addButton(CustomButton button) async {
    print("------ Adding new custom button ------");

    // Insert the button into the database
    CustomButtonsService(objectBox).addButton(button);

    // Add the button to the state and notify listeners
    _buttons.add(CustomButton(
      uuid: button.uuid,
      address: button.address,
      command: button.command,
      label: button.label,
      themeHex: button.themeHex,
      iconCodePoint: button.iconCodePoint,
    ));

    print("Total custom buttons: ${_buttons.length}");
    print("Custom buttons");
    for (var button in buttons) {
      print(
          "Button with uuid: ${button.uuid}: label = ${button.label} || address = ${button.address} || command = ${button.command} || themeHex = ${button.themeHex} || iconCodePoint = ${button.iconCodePoint}");
    }

    notifyListeners();
  }

  // Remove a button from the state and database
  Future<void> removeButton(String uuid) async {
    print("------ Removing custom button with uuid: $uuid ------");

    // Delete the button from the database
    CustomButtonsService(objectBox).removeButtonByUuid(uuid);

    // Remove the button from the state and notify listeners
    _buttons.removeWhere((button) => button.uuid == uuid);

    notifyListeners();
  }

  // Remove all buttons from the state and database
  Future<void> removeButtons() async {
    print("------ Removing all custom buttons ------");

    // Delete the buttons from the database
    CustomButtonsService(objectBox).removeButtons();

    // Remove the buttons from the state and notify listeners
    _buttons.clear();

    notifyListeners();
  }
}
