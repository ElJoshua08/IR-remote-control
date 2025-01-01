import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ir_remote_control/screens/add_new_button.dart';
import 'package:ir_remote_control/state/buttons_state.dart'; // Import your ButtonState file
import 'package:ir_remote_control/state/user_preferences_state.dart';
import 'package:provider/provider.dart';

// Import pages from the pages directory
import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // Initialize Hive

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ButtonStateManager()),
      ChangeNotifierProvider(create: (_) => UserPreferencesStateManager()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPreferencesStateManager>(context);

    return MaterialApp(
      title: 'IR Remote Control',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade500,
          brightness: userPreferences.getPreference("use-dark-mode")
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => RootScreen(), // Home page
        "/add-new-button": (context) => AddButton(),
      },
    );
  }
}
