import "package:ir_remote_control/models/custom_buttons.dart";
import "package:ir_remote_control/objectbox.g.dart";
import "package:ir_remote_control/store.dart";

class CustomButtonsService {
  final ObjectBox objectBox;

  CustomButtonsService(this.objectBox);

  List<CustomButton> getButtons() {
    final box = objectBox.store.box<CustomButton>();
    return box.getAll();
  }

  void addButton(CustomButton customButton) {
    final box = objectBox.store.box<CustomButton>();
    box.put(customButton);
  }

  void removeButtonByUuid(String uuid) {
    final box = objectBox.store.box<CustomButton>();
    final button =
        box.query(CustomButton_.uuid.equals(uuid)).build().findFirst();

    if (button == null) return;

    box.remove(button.id);
  }

  void removeButtons() {
    final box = objectBox.store.box<CustomButton>();
    box.removeAll();
  }
}
