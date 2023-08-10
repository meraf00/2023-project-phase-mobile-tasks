import 'package:flutter/material.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/screens/task_list_screen.dart';
import 'package:todo_app_clean_architecture/features/todo/presentation/widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/';

  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          // background image
          Center(
            child: Image.asset("assets/images/onboarding.jpg"),
          ),

          // get started button
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: CustomButton(
                label: "Get started",
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  Navigator.pushNamed(context, TaskListScreen.routeName);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
