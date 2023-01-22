import 'package:flutter/material.dart';

import '../../widgets/styled_text.dart';

class Programs extends StatelessWidget {
  const Programs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height: 75,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    "Person 1",
                    "Person 2",
                    "Matthew Greenspun",
                    "John Doe",
                  ]
                      .map((user) => Chip(
                            label: Text(user),
                            onDeleted: () {},
                          ))
                      .toList(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        StyledText(
                          "1/16/23",
                          size: 30,
                          bold: true,
                        ),
                        StyledText(
                          "Matthew Greenspun - Program Day 1",
                          size: 30,
                          bold: true,
                        )
                      ],
                    )),
                Flexible(
                    flex: 3,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Finish Workout")))
              ],
            )
          ]),
    );
  }
}
