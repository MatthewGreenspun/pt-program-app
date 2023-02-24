import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/models/program.dart';
import 'package:mobile/stores/index.dart';
import 'package:provider/provider.dart';
import '../../widgets/styled_text.dart';
import "./program_container.dart";

class Programs extends StatelessWidget {
  const Programs({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<ProgramsStore>(
        builder: (_, programsStore, __) => Observer(
            builder: (_) => Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView(children: [
                    SizedBox(
                        height: 75,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: programsStore.activePrograms
                              .asMap()
                              .entries
                              .map((entry) => ChoiceChip(
                                    label: Text(entry.value.identifier),
                                    selected:
                                        entry.key == programsStore.activeIdx,
                                    onSelected: (_) {
                                      programsStore.setActiveIdx(entry.key);
                                    },
                                  ))
                              .toList(),
                        )),
                    programsStore.activePrograms.isEmpty
                        ? const Center(
                            child: StyledText(
                            "No Active Programs",
                            size: 30,
                            bold: true,
                          ))
                        : Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    StyledText(
                                      DateFormat.yMd().format(
                                          programsStore.activeProgram.date),
                                      size: 30,
                                      bold: true,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(left: 32),
                                        child: StyledText(
                                          programsStore
                                              .activeProgram.identifier,
                                          size: 30,
                                          bold: true,
                                        )),
                                  ],
                                )),
                                ElevatedButton(
                                    onPressed: () {
                                      programsStore.popActiveProgram();
                                    },
                                    child: const Text("Finish Workout")),
                              ],
                            ),
                            const ProgramContainer()
                          ])
                  ]),
                )));
  }
}
