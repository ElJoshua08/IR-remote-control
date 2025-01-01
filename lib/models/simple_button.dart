import 'package:flutter/material.dart';

import 'button_base.dart';

class SimpleButton extends ButtonBase {
  final String label;
  final Color theme;
  final IconData? icon;

  SimpleButton({
    required super.address,
    required super.command,
    required super.id,
    required this.label,
    required this.theme,
    required this.icon,
  }) : super(
          type: 'simple',
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'command': command,
      'type': type,
      'label': label,
      'theme': theme,
      'icon': icon,
    };
  }

  static SimpleButton fromMap(Map<String, dynamic> map) {
    return SimpleButton(
      id: map['id'],
      address: map['address'],
      command: map['command'],
      label: map['label'],
      theme: map['theme'],
      icon: map['icon'],
    );
  }
}
