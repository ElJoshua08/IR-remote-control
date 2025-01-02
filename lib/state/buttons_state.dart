// import 'package:flutter/material.dart';
// import 'package:ir_remote_control/database/database_helper.dart';
// import 'package:ir_remote_control/models/simple_button.dart';

// class ButtonStateManager extends ChangeNotifier {
//   final List<SimpleButton> _buttons = [];
//   final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

//   List<SimpleButton> get buttons => _buttons;

//   ButtonStateManager() {
//     _loadButtonsFromDatabase();
//   }

//   // Load buttons from the database and populate the list
//   Future<void> _loadButtonsFromDatabase() async {
//     final buttonData = await _databaseHelper.getAllButtons();

//     _buttons.clear();
//     for (var data in buttonData) {
//       _buttons.add(SimpleButton.fromMap(data));
//     }
//     notifyListeners();
//   }

//   // Add a new button to the state and database
//   Future<void> addButton(SimpleButton button) async {
//     // Insert the button into the database
//     final id = await _databaseHelper.insertButton(button.toMap());

//     // Add the button to the state and notify listeners
//     _buttons.add(SimpleButton(
//       id: id,
//       address: button.address,
//       command: button.command,
//       label: button.label,
//       theme: button.theme,
//       icon: button.icon,
//     ));
//     notifyListeners();
//   }

//   // Update an existing button in the state and database
//   Future<void> updateButton(int index, SimpleButton updatedButton) async {
//     // Update the button in the database
//     await _databaseHelper.updateButton(
//         _buttons[index].toMap()['id'], updatedButton.toMap());

//     // Update the button in the state and notify listeners
//     _buttons[index] = updatedButton;
//     notifyListeners();
//   }

//   // Remove a button from the state and database
//   Future<void> removeButton(int index) async {
//     final button = _buttons[index];

//     // Delete the button from the database
//     await _databaseHelper.deleteButton(button.toMap()['id']);

//     // Remove the button from the state and notify listeners
//     _buttons.removeAt(index);
//     notifyListeners();
//   }
// }
