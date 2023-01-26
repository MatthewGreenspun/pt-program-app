import 'package:flutter/material.dart';
import 'package:mobile/services/index.dart';
import 'package:mobile/stores/index.dart';
import 'screens/login/login.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "./widgets/root_container.dart";
import "package:flutter_mobx/flutter_mobx.dart";
import "package:provider/provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const secureStorage = FlutterSecureStorage();
  bool isLoggedIn = await secureStorage.containsKey(key: "token");
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<SettingsService>(
            create: (_) => SettingsService(),
          ),
          ProxyProvider<SettingsService, SettingsStore>(
              update: (_, settingsService, __) =>
                  SettingsStore(settingsService)..readSavedSettings()),
          Provider<ExercisesService>(
            create: (_) => ExercisesService(),
          ),
          ProxyProvider<ExercisesService, ExercisesStore>(
            update: (_, exercisesService, __) =>
                ExercisesStore(exercisesService)..fetchExercises(),
          ),
          Provider<RootStore>(create: (_) => RootStore())
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
                      home: isLoggedIn ? const RootContainer() : const Login(),
                      routes: {
                        RootContainer.routeName: (context) =>
                            const RootContainer(),
                        Login.routeName: (context) => const Login()
                      },
                    ))));
  }
}
