import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/program.dart';
import '../../stores/patients.dart';
import '../../stores/programs.dart';
import '../../stores/root.dart';

class AddProgramsButton extends StatefulWidget {
  const AddProgramsButton({super.key});

  @override
  State<AddProgramsButton> createState() => _AddProgramsButtonState();
}

class _AddProgramsButtonState extends State<AddProgramsButton> {
  late TextEditingController _searchController;
  final List<ProgramData> _programsToAdd = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => Consumer3<RootStore, PatientsStore,
                      ProgramsStore>(
                  builder: (_, rootStore, patientsStore, programsStore, __) =>
                      AlertDialog(
                        alignment: Alignment.center,
                        title: const Text("Search Programs"),
                        content: StatefulBuilder(
                          builder: (ctx, setState) => SizedBox(
                              width: 700,
                              height: 200,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Wrap(
                                      alignment: WrapAlignment.start,
                                      children: _programsToAdd
                                          .map((program) => Chip(
                                                label: Text(program.name),
                                                onDeleted: () {
                                                  setState(() {
                                                    _programsToAdd.removeWhere(
                                                        (p) =>
                                                            p.id == program.id);
                                                  });
                                                },
                                              ))
                                          .toList(),
                                    ),
                                    LayoutBuilder(
                                      builder: (context, constraints) => Autocomplete<
                                              ProgramData>(
                                          optionsBuilder: (textEditingValue) =>
                                              patientsStore.programs.where(
                                                  (program) =>
                                                      program.name.contains(
                                                          textEditingValue
                                                              .text) &&
                                                      !_programsToAdd.contains(
                                                          program)), //TODO: Use a set if this gets too slow
                                          displayStringForOption: (option) =>
                                              option.name,
                                          optionsViewBuilder: (context,
                                                  onSelected, options) =>
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Material(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            bottom:
                                                                Radius.circular(
                                                                    4.0)),
                                                  ),
                                                  child: SizedBox(
                                                    //TODO: not sure about this
                                                    height:
                                                        50.0 * options.length,
                                                    width: constraints
                                                        .biggest.width,
                                                    child: ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      itemCount: options.length,
                                                      shrinkWrap: false,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final option = options
                                                            .elementAt(index);
                                                        return InkWell(
                                                          onTap: () =>
                                                              onSelected(
                                                                  option),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Text(
                                                                option.name),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          onSelected: (option) {
                                            setState(() {
                                              if (!_programsToAdd
                                                  .contains(option)) {
                                                _programsToAdd.add(option);
                                              }
                                              _searchController.clear();
                                            });
                                          },
                                          fieldViewBuilder: (context,
                                              textEditingController,
                                              focusNode,
                                              onFieldSubmitted) {
                                            _searchController =
                                                textEditingController;
                                            return TextField(
                                              focusNode: focusNode,
                                              controller: _searchController,
                                            );
                                          }),
                                    )
                                  ])),
                        ),
                        actions: [
                          ElevatedButton(
                              onPressed: rootStore.isLoading
                                  ? null
                                  : () {
                                      if (rootStore.isLoading) return;
                                      rootStore.setIsLoading(true);
                                      final futures = _programsToAdd.map(
                                          (program) => programsStore
                                              .addProgram(program.id));
                                      Future.wait(futures).then((_) {
                                        _programsToAdd.clear();
                                        rootStore.setIsLoading(false);
                                        Navigator.pop(context);
                                      });
                                    },
                              child: const Text("Add All")),
                        ],
                      )));
        },
        child: const Icon(Icons.add));
  }
}
