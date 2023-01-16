import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/widgets/color_picker.dart';
import '../../widgets/styled_text.dart';
import '../../widgets/toggle_switch.dart';
import "./settings_container.dart";
import "./setting.dart";
import "../../stores/settings.dart";
import "../../models/settings.dart";
import "package:provider/provider.dart";

class Settings extends StatelessWidget {
  final colorChoices = [
    Colors.red,
    Colors.amber,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];
  // final settingsStore = SettingsStore();
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsStore>(
        builder: (_, settingsStore, __) => Observer(
            builder: (_) => SafeArea(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const Text(
                        "Settings",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SettingsContainer(
                        title: "Appearance",
                        child: Column(children: [
                          Setting(
                              name: "Dark Mode",
                              child: ToggleSwitch(
                                  value: settingsStore.isDark,
                                  onChanged: (value) =>
                                      settingsStore.setIsDark(value))),
                          Setting(
                            name: "Primary Color",
                            child: ColorPicker(
                                boxWidth:
                                    MediaQuery.of(context).size.width > 500
                                        ? 30
                                        : 20,
                                choices: colorChoices,
                                selectedIdx: colorChoices
                                    .indexOf(settingsStore.primaryColor),
                                onChange: (value) =>
                                    settingsStore.setPrimaryColor(value)),
                          )
                        ]),
                      ),
                      SettingsContainer(
                          title: "Exercises",
                          child: Column(
                            children: [
                              Setting(
                                  name: "Units",
                                  child: DropdownButton(
                                    onChanged: (value) =>
                                        settingsStore.setUnits(value!),
                                    value: settingsStore.units,
                                    items: const [
                                      DropdownMenuItem<Unit>(
                                          value: Unit.imperial,
                                          child: Text("lbs")),
                                      DropdownMenuItem<Unit>(
                                          value: Unit.metric, child: Text("kg"))
                                    ],
                                  ))
                            ],
                          )),
                      SettingsContainer(
                          title: "Account",
                          child: Column(
                            children: [
                              Setting(
                                  name: "Account Type",
                                  child: Observer(
                                      builder: (_) => DropdownButton(
                                            onChanged: (value) => settingsStore
                                                .setAccountType(value!),
                                            value: settingsStore.accountType,
                                            items: const [
                                              DropdownMenuItem<AccountType>(
                                                  value: AccountType.doctor,
                                                  child: Text("Doctor")),
                                              DropdownMenuItem<AccountType>(
                                                  value: AccountType.patient,
                                                  child: Text("Patient"))
                                            ],
                                          ))),
                              Setting(
                                name: "Join Code",
                                child: StyledText(
                                  text: settingsStore.joinCode,
                                  size: 20,
                                ),
                              ),
                              Setting(
                                name: "Log Out",
                                child: ElevatedButton(
                                  child: const Text("Log out"),
                                  onPressed: () {},
                                ),
                              ), //TODO use auth service
                            ],
                          ))
                    ],
                  ),
                ))));
  }
}
