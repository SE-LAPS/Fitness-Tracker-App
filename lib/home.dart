import 'package:flutter/material.dart';
import 'add_workout.dart';
import 'add_goal.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Fitness Tracker',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Workout> workouts = [];
  List<Goal> goals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                return WorkoutTile(workouts[index]);
              },
            ),
          ),
          SizedBox(
            height: 48.0, // Set the height of the buttons
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddWorkoutDialog(
                    onWorkoutAdded: (workout) {
                      setState(() {
                        workouts.add(workout);
                      });
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Add Workout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 8.0), 
          SizedBox(
            height: 48.0, 
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddGoalDialog(
                    onGoalAdded: (goal) {
                      setState(() {
                        goals.add(goal);
                      });
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Add Goal',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkoutTile extends StatelessWidget {
  final Workout workout;

  const WorkoutTile(this.workout, {Key? key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workout.name),
      subtitle: Text('${workout.duration} minutes'),
      trailing: Text(workout.date.toString()),
    );
  }
}

class Workout {
  final String name;
  final int duration;
  final DateTime date;

  Workout({
    required this.name,
    required this.duration,
    required this.date,
  });
}

class Goal {
  final String name;
  final String description;
  final DateTime deadline;

  Goal({
    required this.name,
    required this.description,
    required this.deadline,
  });
}
