import 'package:flutter/material.dart';
import 'package:todo_app/todo/presentation/screens/add_task.dart';
import 'todo/presentation/screens/task_detail.dart';
import 'todo/presentation/screens/task_list.dart';
import 'todo/domain/entities/task.dart';
import 'todo/presentation/screens/onboarding.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFEE6F57),
          secondary: Color(0xFF0C8CE9),
          surface: Color(0xFFF1EEEE),
          background: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onPrimary: Color(0xFFFFFFFF),
          onSecondary: Color(0xFFFFFFFF),
          onSurface: Color(0xFF000000),
          onBackground: Color(0xFF000000),
          onError: Color(0xFFFFFFFF),
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      onGenerateRoute: (settings) {
        //
        // onboarding
        if (settings.name == OnboardingScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          );
        }
        //
        // task list screen
        else if (settings.name == TaskListScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) => const TaskListScreen(),
          );
        }
        //
        // task detail screen
        else if (settings.name == TaskDetailScreen.routeName) {
          final task = settings.arguments as Task;

          return MaterialPageRoute(
            builder: (context) => TaskDetailScreen(task: task),
          );
        }
        //
        // task create/edit screen
        else if (settings.name == AddTaskScreen.routeName) {
          if (settings.arguments == null) {
            return MaterialPageRoute(builder: (context) => AddTaskScreen());
          }

          final task = settings.arguments as Task;

          return MaterialPageRoute(
            builder: (context) => AddTaskScreen(task: task),
          );
        }

        assert(false, 'Need to implement ${settings.name}');
      },
    );
  }
}
