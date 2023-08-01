import 'dart:io';
import 'models/task_manager.dart';
import './screens/main_screen.dart';
import './screens/screen.dart';

void main(List<String> arguments) {
  var taskManager = TaskManager();

  Screen currentScreen = MainScreen(taskManager);

  print("Welcome to Task Manager App\n");

  while (true) {
    currentScreen.displayOptions();

    do {
      print("Enter your choice:");
      var userInput = stdin.readLineSync()!;
      var choice = int.tryParse(userInput);

      if (choice == null ||
          choice < 1 ||
          choice > currentScreen.options.length) {
        print("Invalid choice, please try again.\n");
      } else {
        print("");
        currentScreen = currentScreen.handleInput(choice);
        print("");
        break;
      }
    } while (true);
  }
}
