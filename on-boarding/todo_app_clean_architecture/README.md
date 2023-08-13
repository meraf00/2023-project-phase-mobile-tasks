# Task manager app

### How to run

- Clone this repository
- Run `flutter pub get`
- Run `flutter run`

### Features

- Create a new task
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

### [Change log]

#### Remote repository implementation

- Write tests for remote task repository
- Add remote data source to repository [task repository](lib/features/todo/data/repositories/task_repository_impl.dart)

### [Change log]

#### Remote data source implementation

- Write tests for remote data source repository
- Add remote data source [task repository](lib/features/todo/data/datasources/task_remote_data_source.dart)

### [Change log]

#### UI and bloc integration

- Write widget test
- Refactor UI to use components and dependency injection
- Integrate domain layer with presentation layer

### [Change log]

#### Dependency injection

- Integrate `getIt` (external package) to manage dependency injection
- Register dependencies in [dependency injection file](lib/injection_container.dart)

### [Change log]

#### Bloc implementation

- Integrate `flutter_bloc` (external package) to manage state
- Write tests for task bloc
- Define [task states](lib/features/todo/presentation/bloc/task_state.dart)
- Define [task events](lib/features/todo/presentation/bloc/task_event.dart)
- Implement [task bloc](lib/features/todo/presentation/bloc/task_bloc.dart)

### [Change log]

#### Local data source implementation

- Write tests for TaskLocalDataSource concrete implementation
- Implement [task local data source](lib/features/todo/data/datasources/task_local_data_source.dart) concrete implementation
- Integrate `shared_preference` (external package) to store data locally

### [Change log]

#### Repository implementation

- Write tests for task repository
- Implement [task repository](lib/features/todo/data/repositories/task_repository_impl.dart)
- Define interfaces for local data source

### [Change log]

#### Repository interface

- Add [task repository interface](lib/features/todo/domain/repositories/task_repository.dart) to abstract data layer from domain layer.

#### Network info

- Write tests for network info
- Add external package `InternetConnectionChecker` to check internet connection.
- Implement `NetworkInfo` class to check internet connection.

### [Change log]

#### Models

- Write tests for data convertion logic between `JSON` and `TaskModel`
- Add [task models](lib/features/todo/data/models/task_model.dart) in the data source layer to abstract data layer from domain layer.
- Add [task mapper](lib/features/todo/data/models/task_mapper.dart) in the data source to convert between task model and task entity

#### Error handling

- Utilize `dartz` `Either` to handle error values.

### [Change log]

#### Use cases

- Write tests for Use cases
- Define [base class](lib/core/usecases/usecase.dart) for all use cases
- Add [usecases](lib/features/todo/domain/usecases/) to view specific task, view all tasks create, delete, update task.

### [Change log]

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
