import "package:objectbox/objectbox.dart";

@Entity()
class CustomButton {
  int id = 0;

  @Unique()
  String uuid;

  String address;
  String command;
  String label;
  String? themeHex;
  int? iconCodePoint;

  CustomButton({
    required this.uuid,
    required this.address,
    required this.command,
    required this.label,
    this.themeHex,
    this.iconCodePoint,
  });
}
