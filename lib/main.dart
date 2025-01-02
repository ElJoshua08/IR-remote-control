import 'package:flutter/material.dart';
import 'package:ir_remote_control/screens/add_new_button.dart';
import 'package:ir_remote_control/state/custom_buttons_state.dart';
import 'package:provider/provider.dart';

// Import pages from the pages directory
// import 'screens/add_new_button.dart';
import 'screens/home.dart';
// Import state managers
// import 'state/buttons_state.dart';
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
            seedColor: Colors.blue.shade500,
            brightness: userPreferences.getPreference("theme") == "light"
                ? Brightness.light
                : Brightness.dark),
      ),
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => const RootScreen(), // Home page
        "/add-new-button": (context) => AddButton(),
      },
    );
  }
}
