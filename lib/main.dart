import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'screens/add_new_button.dart';
import 'screens/home.dart';
import 'state/custom_buttons_state.dart';
import 'state/user_preferences_state.dart';
import 'store.dart';

// Load db from objectbox
late ObjectBox objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CustomButtonsStateManager(objectBox)),
        ChangeNotifierProvider(
            create: (_) => UserPreferencesStateManager(objectBox)),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPreferencesStateManager>(context);
    // ignore: unused_local_variable
    final customButtons = Provider.of<CustomButtonsStateManager>(context);

    return MaterialApp(
      title: 'IR Remote Control',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: colorFromHex("219EBC")!,
              primary: colorFromHex("219EBC")!,
              secondary: colorFromHex("023047")!,
              brightness: userPreferences.getPreference("theme") == "light"
                  ? Brightness.light
                  : Brightness.dark),
          fontFamily: 'Outfit',
          switchTheme: SwitchThemeData()),
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => const RootScreen(), // Home page
        "/add-new-button": (context) => AddButton(),
      },
    );
  }
}
