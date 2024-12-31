import 'package:flutter/services.dart';

class IRService {
  static const MethodChannel _channel = MethodChannel('ir_transmitter');

  // Method to check if the IR transmitter is available
  static Future<bool> isIRSupported() async {
    try {
      final bool result = await _channel.invokeMethod('isIRSupported');
      return result;
    } catch (e) {
      print('Error checking IR support: $e');
      return false;
    }
  }

  // Method to send a generic IR signal
  static Future<void> sendIRSignal(List<int> pattern, int frequency) async {
    try {
      await _channel.invokeMethod('sendIR', {
        'pattern': pattern,
        'frequency': frequency,
      });
    } catch (e) {
      print('Error sending IR signal: $e');
    }
  }

  static List<int> encodeNEC(int address, int command) {
    List<int> pattern = [];

    // Add the leader code
    pattern.addAll([9000, 4500]);

    // Ensure address and command are 8-bit values
    address = address & 0xFF;
    command = command & 0xFF;

    // Helper to encode a byte in LSB order
    void encodeByte(int byte) {
      for (int i = 0; i < 8; i++) {
        if ((byte & (1 << i)) != 0) {
          // Logical '1'
          pattern.addAll([560, 1690]);
        } else {
          // Logical '0'
          pattern.addAll([560, 560]);
        }
      }
    }

    // Add the address and its complement
    encodeByte(address);
    encodeByte(~address & 0xFF);

    // Add the command and its complement
    encodeByte(command);
    encodeByte(~command & 0xFF);

    // Add the end signal
    pattern.add(560);

    return pattern;
  }

  static Future<void> sendNEC(int address, int command) async {
    try {
      List<int> pattern = encodeNEC(address, command);
      await sendIRSignal(pattern, 38000); // NEC uses a 38kHz carrier frequency
    } catch (e) {
      print('Error sending NEC signal: $e');
    }
  }
}
