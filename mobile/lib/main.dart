import 'package:flutter/material.dart';
import 'package:mobile/services/settings.service.dart';
import 'package:mobile/stores/settings.dart';
import 'screens/login/login.dart';
import 'screens/patients/patients.dart';
import "package:shared_preferences/shared_preferences.dart";
import "./widgets/root_container.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences
      .getInstance(); //TODO change shared preferences to secure storage
  String? loginId = prefs.getString("login_id");
  runApp(MyApp(loginId: loginId));
}

class MyApp extends StatelessWidget {
  final String? loginId;
  MyApp({super.key, required this.loginId});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<SettingsService>(
            create: (_) => SettingsService(),
          ),
          ProxyProvider<SettingsService, SettingsStore>(
              update: (_, settingsService, __) =>
                  SettingsStore(settingsService)..readSavedSettings())
        ],
        child: Consumer<SettingsStore>(
            builder: (_, settingsStore, __) => Observer(
                builder: (_) => MaterialApp(
                      title: 'PT Program',
                      theme: settingsStore.isDark
                          ? ThemeData.dark().copyWith(
                              bottomAppBarColor: Colors.grey[900],
                              colorScheme: const ColorScheme.dark().copyWith(
                                primary: settingsStore.primaryColor,
                                secondary: settingsStore.primaryColor,
                              ))
                          : ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light().copyWith(
                              primary: settingsStore.primaryColor,
                              secondary: settingsStore.primaryColor,
                            )),
                      home: RootContainer(),
                      routes: {
                        "/patients": (context) => const Patients(),
                        "/root": (context) => RootContainer()
                      },
                    ))));
  }
}
