import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ir_remote_control/components/widgets/theme_picker.dart';
import 'package:ir_remote_control/models/custom_buttons.dart';
import 'package:ir_remote_control/state/custom_buttons_state.dart';
import 'package:ir_remote_control/themes/app_themes.dart';
import 'package:ir_remote_control/utils/icon_items.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _commandController = TextEditingController();

  // For simple button
  final _simpleNameController = TextEditingController();
  IconData? _simpleIcon;
  Color _simpleTheme = CustomButtonThemes.blueTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Button'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Address input
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.blue),
                          hintText: 'Eg. 00 or A4',
                          fillColor: Colors.blue,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter the address for the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Command input
                      TextFormField(
                        controller: _commandController,
                        decoration: InputDecoration(
                          labelText: 'Command',
                          labelStyle: TextStyle(color: Colors.blue),
                          hintText: 'Eg. 40 or 28',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a command';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter the command for the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Simple button fields
                      TextFormField(
                        controller: _simpleNameController,
                        decoration: InputDecoration(
                          labelText: 'Label',
                          labelStyle: TextStyle(color: Colors.blue),
                          hintText: 'Eg. Power',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a label';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter the name of the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<IconData>(
                        value: _simpleIcon,
                        decoration: InputDecoration(
                          labelText: 'Icon',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        items: iconItems,
                        onChanged: (value) {
                          setState(() {
                            _simpleIcon = value;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      // ThemePicker
                      ThemePicker(
                        onThemeSelect: (theme) => setState(() {
                          _simpleTheme = theme;
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select the theme of the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Submit button to add new button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Create simple button
                    final newButton = CustomButton(
                      uuid: Uuid().v4(),
                      address: _addressController.text,
                      command: _commandController.text,
                      label: _simpleNameController.text,
                      iconCodePoint: _simpleIcon!.codePoint,
                      themeHex: _simpleTheme.toHexString(),
                    );
                    Provider.of<CustomButtonsStateManager>(context, listen: false)
                        .addButton(newButton);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  'Add New Button',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
