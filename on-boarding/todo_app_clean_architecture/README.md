# Task manager app

### How to run

- Clone this repository
- Run `flutter pub get`
- Run `flutter run`

### Features

- create a new task
- Delete a task
- Mark a task as competed or incomplete
- Edit a task
- View task details
- Improved user experience

### Screenshots

<div style="display: flex; flex-direction:row; gap: 5px">
  <img width='180'    
    src="screenshots/1.png?raw=true"
  />
  <img width='180'
    src="screenshots/2.png?raw=true"
  />
  <img width='180'
    src="screenshots/3.png?raw=true"
  />
  <img width='180'
      src="screenshots/4.png?raw=true"
    />
  <img width='180'
      src="screenshots/5.png?raw=true"
    />
  <img width='180'
  src="screenshots/6.png?raw=true"
  />

<img width='180'
      src="screenshots/7.png?raw=true"
    />
<img width='180'
      src="screenshots/8.png?raw=true"
    />

<img width='180'
      src="screenshots/9.png?raw=true"
    />

<img width='180'
      src="screenshots/10.png?raw=true"
    />
<img width='180'
      src="screenshots/11.png?raw=true"
    />
<img width='180'
      src="screenshots/12.png?raw=true"
    />

</div>

### Updates

#### Repository interface

Add [task repository](/lib/features/todo/domain/repositories/task_repository.dart) interface to abstract data layer from domain layer.

#### Network info

Add external package `InternetConnectionChecker` to check internet connection.
Implement `NetworkInfo` class to check internet connection.

#### Use cases

Added use cases for view specific task, view all tasks creating, deleting, updating, marking as completed.

[Usecases](/lib/features/todo/domain/usecases/)

#### Create task entity

```
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [id, title, description, date, isCompleted];
}
```

### Folder structure

```
lib
├── main.dart
├── core
│   └── error
│   └── network
│   └── presentation
│       ├── util
├── features
│   ├── todo
│   │   ├── data
│   │   │   ├── datasources
│   │   │   │   └── task_local_data_source.dart
│   │   │   ├── models
│   │   │   │   └── task_model.dart
│   │   │   └── repositories
│   │   │       └── task_repository_impl.dart
│   │   ├── domain
│   │   │   ├── entities
│   │   │   │   └── task.dart
│   │   │   ├── repositories
│   │   │   │   └── task_repository.dart
│   │   │   └── usecases
│   │   │       ├── create_task.dart
│   │   │       ├── delete_task.dart
│   │   │       ├── get_task.dart
│   │   │       ├── get_task_list.dart
│   │   │       ├── mark_task_as_completed.dart
│   │   │       └── update_task.dart
│   │   └── presentation
│   │       ├── bloc
│   │       │   ├── task_bloc.dart
│   │       │   └── task_event.dart
│   │       ├── screens
│   │       │   ├── create_task_screen.dart
│   │       │   ├── edit_task_screen.dart
│   │       │   ├── home_screen.dart
│   │       │   └── task_details_screen.dart
│   │       └── widgets
│   │           ├── custom_button.dart
│   │           ├── custom_text_field.dart
│   │           ├── task_list_item.dart
│   │           └── task_tile.dart
```
