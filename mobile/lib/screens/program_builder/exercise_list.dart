import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '/stores/index.dart';
import 'package:provider/provider.dart';
import '../../models/exercise.dart';
import "./exercise_card.dart";

class ExerciseList extends StatefulWidget {
  final List<Exercise> allExercises;
  const ExerciseList({super.key, required this.allExercises});

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  late TextEditingController _searchController;
  List<Exercise> _searchResults = [];

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
    _searchResults = widget.allExercises;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onSearchChange(String query, Set<String> addedExercises) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = widget.allExercises
            .where((exercise) => !addedExercises.contains(exercise.id))
            .toList();
      });
    } else {
      setState(() {
        _searchResults = widget.allExercises
            .where((exercise) =>
                exercise.name
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) &&
                !addedExercises.contains(exercise.id))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ExercisesStore, ProgramBuilderStore>(
        builder: (_, exercisesStore, programsBuilderStore, __) => Observer(
            builder: (_) => exercisesStore.exercises.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    color: Theme.of(context).hintColor))),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.search)),
                                onChanged: (query) => onSearchChange(
                                    query, programsBuilderStore.exerciseIds),
                              ),
                              Expanded(
                                  child: ListView(
                                      padding: const EdgeInsets.all(8),
                                      scrollDirection: Axis.vertical,
                                      children: _searchResults
                                          .map(
                                              (exercise) => Draggable<Exercise>(
                                                    data: exercise,
                                                    feedback: ExerciseCard(
                                                      name: exercise.name,
                                                      description:
                                                          exercise.description,
                                                    ),
                                                    child: ExerciseCard(
                                                      name: exercise.name,
                                                      description:
                                                          exercise.description,
                                                    ),
                                                  ))
                                          .toList()))
                            ])))));
  }
}
