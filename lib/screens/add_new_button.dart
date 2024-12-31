import 'package:flutter/material.dart';
import 'package:ir_remote_control/components/widgets/theme_picker.dart';
import 'package:ir_remote_control/state/button_state.dart';
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

  // For toggle button states
  final _onNameController = TextEditingController();
  IconData? _onIcon;
  Color _onBackgroundColor = Colors.white;

  final _offNameController = TextEditingController();
  IconData? _offIcon;
  Color _offBackgroundColor = Colors.white;

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
                      DropdownButtonFormField<String>(
                        value: _type,
                        decoration: InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'toggle', child: Text('Toggle')),
                          DropdownMenuItem(value: 'simple', child: Text('Simple')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _type = value ?? 'toggle';
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Select the type of the button',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Address input
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          hintText: 'Eg. 00 or A4',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                        child: Text(
                          'Enter the address for the button',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Command input
                      TextFormField(
                        controller: _commandController,
                        decoration: InputDecoration(
                          labelText: 'Command',
                          hintText: 'Eg. 40 or 28',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
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
                        child: Text(
                          'Enter the command for the button',
                          style: TextStyle(color: Colors.grey),
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
                                    hintText: 'Enter name for ON state',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Background Color',
                                    hintText:
                                        'Enter background color for ON state (e.g., #FFFFFF)',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _onBackgroundColor = Color(
                                          int.parse(value.replaceFirst('#', '0xff')));
                                    });
                                  },
                                ),
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
                                    hintText: 'Enter name for OFF state',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
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
                            hintText: 'Eg. Power',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
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
                          child: Text(
                            'Enter the name of the button',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<IconData>(
                          value: _simpleIcon,
                          decoration: InputDecoration(
                            labelText: 'Icon',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
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
                      ThemePicker(onThemeSelect: (theme) => print(theme)),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Select the theme of the button',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Submit button to add new button
            ElevatedButton(
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
                        backgroundColor: _onBackgroundColor,
                      ),
                      offState: ButtonStateDetails(
                        name: _offNameController.text,
                        icon: _offIcon,
                        backgroundColor: _offBackgroundColor,
                      ),
                    );
                    Provider.of<ButtonStateManager>(context, listen: false)
                        .addButton(newButton);
                  } else if (_type == 'simple') {
                    final newButton = SimpleButton(
                      address: _addressController.text,
                      command: _commandController.text,
                      label: _simpleNameController.text,
                    );
                    Provider.of<ButtonStateManager>(context, listen: false)
                        .addButton(newButton);
                  }
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(theme.colorScheme.primary)),
              child: Text(
                'Add New Button',
                style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 20, color: theme.colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
