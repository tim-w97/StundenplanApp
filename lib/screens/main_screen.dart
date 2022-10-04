import 'package:flutter/material.dart';
import 'package:stundenplan_app/widgets/timetable.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blueGrey,
                      onPressed: () {},
                      child: const Text("Stundenplan"),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.blueGrey,
                      onPressed: () {},
                      child: const Text("Vertretungsplan"),
                    ),
                  ),
                ],
              ),
            ),
            const Timetable(),
          ],
        ),
      ),
    );
  }
}
