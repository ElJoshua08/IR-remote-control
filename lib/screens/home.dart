import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:ir_remote_control/components/widgets/buttons_list.dart';
import 'package:ir_remote_control/screens/settings.dart';
import 'package:ir_remote_control/services/ir_service.dart';
import 'package:ir_remote_control/state/buttons_state.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    const SettingsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'IR Remote Control' : 'Settings'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: theme.colorScheme.primary,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        enableFeedback: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: theme.colorScheme.secondary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: theme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonState = Provider.of<ButtonStateManager>(context);
    final buttons = buttonState.buttons;

    // First thing we need to check is if we have a compatible device
    Future<void> checkCompatibility() async {
      if (!await IRService.isIRSupported()) {
        return showDialog(
          context: context,
          barrierDismissible: false, // Make the dialog not skippable
          builder: (context) => AlertDialog(
            title: Text('Incompatible Device',
                style: TextStyle(fontSize: 20, color: theme.colorScheme.error)),
            content: const Text(
                'It seems like your device is not compatible with this app. Please make sure that your device is compatible with IR transmitters and try again.'),
            icon: Icon(Icons.error),
            iconColor: theme.colorScheme.error,
            actions: [
              TextButton(
                onPressed: () => SystemNavigator.pop(), // Closes the app
                child: Text('Close App'),
              ),
            ],
          ),
        );
      }
    }

    // ! Remove when ready
    // checkCompatibility();

    // Here if we have no buttons, we show a different scaffold
    if (buttons.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/no-buttons.svg',
                width: 256,
                height: 256,
              ),
              Text(
                "It seems like you don't have any buttons yet.",
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/add-new-button"),
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(theme.colorScheme.primary)),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Add Your First Button",
                        style: theme.textTheme.labelLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onPrimary),
                      ),
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: theme.colorScheme.onPrimary,
                            weight: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Text("Here are your buttons: "),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ButtonsList(),
          ),
        ],
      ),
      floatingActionButton: Ink(
        decoration: ShapeDecoration(
            shape: CircleBorder(), color: theme.colorScheme.primary),
        child: IconButton(
          onPressed: () => Navigator.pushNamed(context, "/add-new-button"),
          icon: Icon(Icons.add),
          color: theme.colorScheme.onPrimary,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
