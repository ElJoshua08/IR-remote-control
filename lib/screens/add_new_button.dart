import 'package:flutter/material.dart';
import 'package:ir_remote_control/components/widgets/theme_picker.dart';
import 'package:ir_remote_control/state/button_state.dart';
import 'package:ir_remote_control/themes/app_themes.dart';
import 'package:ir_remote_control/utils/icon_items.dart';
import 'package:provider/provider.dart';

class AddButton extends StatefulWidget {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _commandController = TextEditingController();
  String _type = 'simple'; // Default button type is simple

  // For simple button
  final _simpleNameController = TextEditingController();
  IconData? _simpleIcon;
  CustomButtonTheme _simpleTheme = CustomButtonThemes.blueTheme;

  // For toggle button states
  final _onNameController = TextEditingController();
  IconData? _onIcon;

  final _offNameController = TextEditingController();
  IconData? _offIcon;

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
                      // Button Type selection
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _type,
                        decoration: InputDecoration(
                          labelText: 'Type',
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
                        items: const [
                          DropdownMenuItem(
                              value: 'toggle', child: Text('Toggle')),
                          DropdownMenuItem(
                              value: 'simple', child: Text('Simple')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _type = value ?? 'toggle';
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Select the type of the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Address input
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.blue),
                          hintText: 'Eg. 00 or A4',
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
                        autovalidateMode: AutovalidateMode.always,
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
                      // Fields for toggle button only
                      if (_type == 'toggle') ...[
                        SizedBox(height: 16),
                        Text('On State',
                            style: Theme.of(context).textTheme.headlineMedium),
                        Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _onNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(color: Colors.blue),
                                    hintText: 'Enter name for ON state',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name for ON state';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField<IconData>(
                                  value: _onIcon,
                                  decoration: InputDecoration(
                                    labelText: 'Icon',
                                    labelStyle: TextStyle(color: Colors.blue),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  items: iconItems,
                                  onChanged: (value) {
                                    setState(() {
                                      _onIcon = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text('Off State',
                            style: Theme.of(context).textTheme.headlineMedium),
                        Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _offNameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(color: Colors.blue),
                                    hintText: 'Enter name for OFF state',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name for OFF state';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                DropdownButtonFormField<IconData>(
                                  value: _offIcon,
                                  decoration: InputDecoration(
                                    labelText: 'Icon',
                                    labelStyle: TextStyle(color: Colors.blue),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                    ),
                                  ),
                                  items: iconItems,
                                  onChanged: (value) {
                                    setState(() {
                                      _offIcon = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ],
                      // Fields for simple button only
                      if (_type == 'simple') ...[
                        SizedBox(height: 16),
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
                        // ThemePicker(),
                      ],
                      SizedBox(height: 16),
                      // Here we select the theme for the button
                      ThemePicker(
                          onThemeSelect: (theme) => setState(() {
                                _simpleTheme = theme;
                              })),

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
                    // Create button based on type
                    if (_type == 'toggle') {
                      final newButton = ToggleButton(
                        address: _addressController.text,
                        command: _commandController.text,
                        onState: ButtonStateDetails(
                          name: _onNameController.text,
                          icon: _onIcon,
                        ),
                        offState: ButtonStateDetails(
                          name: _offNameController.text,
                          icon: _offIcon,
                        ),
                      );
                      Provider.of<ButtonStateManager>(context, listen: false)
                          .addButton(newButton);
                    } else if (_type == 'simple') {
                      final newButton = SimpleButton(
                          address: _addressController.text,
                          command: _commandController.text,
                          label: _simpleNameController.text,
                          icon: _simpleIcon,
                          theme: _simpleTheme);
                      Provider.of<ButtonStateManager>(context, listen: false)
                          .addButton(newButton);
                    }
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
                      color: theme.colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
