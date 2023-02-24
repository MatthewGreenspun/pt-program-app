import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../../stores/patients.dart";
import "../../stores/root.dart";

class AddPatientsButton extends StatefulWidget {
  const AddPatientsButton({super.key});

  @override
  State<AddPatientsButton> createState() => _AddPatientsButtonState();
}

class _AddPatientsButtonState extends State<AddPatientsButton> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onCreate(RootStore rootStore, PatientsStore patientsStore) {
      rootStore.setIsLoading(true);
      patientsStore
          .createPatient(
              _nameController.value.text, _emailController.value.text)
          .then((_) => rootStore.setIsLoading(false));
      _nameController.clear();
      _emailController.clear();
      Navigator.of(context).pop();
    }

    return FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => Consumer2<RootStore, PatientsStore>(
                  builder: (_, rootStore, patientsStore, __) => AlertDialog(
                        alignment: Alignment.center,
                        title: const Text("New Patient"),
                        content: SizedBox(
                            width: 300,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                        label: Text("Patient Name")),
                                  ),
                                  TextField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        label:
                                            Text("Patient Email (optional) ")),
                                  ),
                                ])),
                        actions: [
                          ElevatedButton(
                              onPressed: rootStore.isLoading
                                  ? null
                                  : () {
                                      onCreate(rootStore, patientsStore);
                                    },
                              child: const Text("Create")),
                        ],
                      )));
        },
        child: const Icon(Icons.add));
  }
}
