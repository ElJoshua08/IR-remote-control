abstract class ButtonBase {
  final int id;
  final String address;
  final String command;
  final String type;

  ButtonBase({
    required this.id,
    required this.address,
    required this.command,
    required this.type,
  });

  Map<String, dynamic> toMap();
}
