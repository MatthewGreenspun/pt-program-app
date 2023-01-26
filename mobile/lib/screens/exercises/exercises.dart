import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile/stores/exercises.dart';
import 'package:provider/provider.dart';
import "./exercise_card.dart";

class Exercises extends StatelessWidget {
  static const double _spacing = 20;
  const Exercises({super.key});

  @override
  Widget build(BuildContext context) {
    final numColumns = MediaQuery.of(context).size.width > 500 ? 2 : 1;
    return Consumer<ExercisesStore>(
        builder: (_, exercisesStore, __) => Observer(
            builder: (_) => exercisesStore.exercises.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.count(
                    padding: const EdgeInsets.all(_spacing),
                    crossAxisCount: numColumns,
                    scrollDirection: Axis.vertical,
                    mainAxisSpacing: _spacing,
                    crossAxisSpacing: _spacing,
                    childAspectRatio: numColumns == 1 ? 1 : 6 / 5,
                    children: exercisesStore.exercises
                        .map((exercise) => ExerciseCard(
                              name: exercise.name,
                              mediaLink: "assets/images/exercise_img_test.png",
                              description: exercise.description,
                            ))
                        .toList())));
  }
}
