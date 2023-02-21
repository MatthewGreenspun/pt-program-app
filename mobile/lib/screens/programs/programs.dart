import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/stores/index.dart';
import 'package:provider/provider.dart';
import "./program.dart";
import '../../widgets/styled_text.dart';

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
                        ? SizedBox(
                            width: width,
                            height: height,
                            child: Stack(children: [
                              const Positioned(
                                  bottom: 500,
                                  right: 200,
                                  child: StyledText(
                                    "No Active Programs. Add one here!",
                                    size: 30,
                                    bold: true,
                                  )),
                              Positioned(
                                  bottom: 175,
                                  right: 80,
                                  child: Image.asset(
                                      //TODO: Responsive
                                      width: 400,
                                      "assets/images/no_programs_arrow.png"))
                            ]))
                        : Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                    flex: 3,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        StyledText(
                                          DateFormat.yMd().format(
                                              programsStore.activeProgram.date),
                                          size: 30,
                                          bold: true,
                                        ),
                                        StyledText(
                                          programsStore
                                              .activeProgram.identifier,
                                          size: 30,
                                          bold: true,
                                        )
                                      ],
                                    )),
                                Flexible(
                                    flex: 3,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          programsStore.popActiveProgram();
                                        },
                                        child: const Text("Finish Workout"))),
                              ],
                            ),
                            const Program()
                          ])
                  ]),
                )));
  }
}
