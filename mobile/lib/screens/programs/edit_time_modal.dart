import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:mobile/models/exercise.dart";
import "package:provider/provider.dart";
import "../../stores/programs.dart";
import "../../widgets/index.dart";

class _TextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  const _TextField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      margin: const EdgeInsets.only(left: 10),
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: const TextStyle(fontSize: 25),
        textAlign: TextAlign.right,
        controller: controller,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.only(right: 4),
        ),
        keyboardType: TextInputType.number,
        maxLength: 2,
      ),
    );
  }
}

class EditTimeModal extends StatefulWidget {
  final ProgramExercise exercise;
  const EditTimeModal({super.key, required this.exercise});

  @override
  State<EditTimeModal> createState() => _EditTimeModalState();
}

class _EditTimeModalState extends State<EditTimeModal> {
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;

  @override
  void initState() {
    _minutesController = TextEditingController();
    _secondsController = TextEditingController();
    super.initState();
    _minutesController.text = widget.exercise.minutes.toString();
    _secondsController.text = widget.exercise.seconds.toString();
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgramsStore>(
        builder: (_, programsStore, __) => AlertDialog(
            alignment: Alignment.center,
            content: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 60,
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  _TextField(
                      controller: _minutesController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          programsStore.editExercise(widget.exercise,
                              minutes: int.parse(value));
                        }
                      }),
                  const StyledText(
                    "m",
                    size: 25,
                  ),
                  _TextField(
                      controller: _secondsController,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          programsStore.editExercise(widget.exercise,
                              seconds: int.parse(value));
                        }
                      }),
                  const StyledText(
                    "s",
                    size: 25,
                  ),
                ]),
              ),
            )));
  }
}
