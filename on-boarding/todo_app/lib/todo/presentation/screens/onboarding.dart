import 'package:flutter/material.dart';
import '../screens/task_list.dart';
import '../widgets/button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/images/onboarding.jpg"),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Button(
                label: "Get started",
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TaskListScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
