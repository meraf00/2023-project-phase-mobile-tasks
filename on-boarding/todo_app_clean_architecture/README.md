# Task manager app

This is a task manager app built with flutter following the clean architecture principles.

# Table of contents

- [Getting started](#getting-started)
- [Features & Usecases](#features-and-usecases)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
  - [Development dependencies](#development-dependencies)
- [Screenshots](#screenshots)
- [Folder structure](#folder-structure)

<details>
<summary><a href='#timeline'>Timeline<a></summary>

- [August 16, 2023](#august-16-2023)
- [August 15, 2023](#august-15-2023)
- [August 14, 2023](#august-14-2023)
- [August 13, 2023](#august-13-2023)
- [August 12, 2023](#august-12-2023)
- [August 11, 2023](#august-11-2023)
- [August 10, 2023](#august-10-2023)
- [August 9, 2023](#august-9-2023)
</details>

## Getting Started

Clone this repository <br>
`git clone https://github.com/meraf00/2023-project-phase-mobile-tasks.git`

Navigate to `todo_app_clean_architecture` folder <br>
`cd on-boarding/todo_app_clean_architecture`

Download dependencies <br>
`flutter pub get`

Run the app <br>
`flutter run`

## Features and usecases

User can do the following:

- Create new task
- Delete task
- Edit task details
- Mark task as competed or incomplete
- View specific task
- View all tasks

## Architecture

This project follows the clean architecture principles. The project is divided into three layers:

**Domain layer**: This layer is responsible for handling business logic. It consists of the following:

- Entities
- Repositories
- Usecases

**Data layer**: This layer is responsible for handling data operations. It consists of the following:

- Remote data source
- Local data source

**Presentation layer**: This layer is responsible for handling UI. It consists of the following:

- Bloc
- UI elements

The following diagram shows the flow of data between the layers:

![image](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course/blob/master/architecture-proposal.png?raw=true)

## Dependencies

- [Equatable](https://pub.dev/packages/equatable)
- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)
- [Get It](https://pub.dev/packages/get_it)
- [Dartz](https://pub.dev/packages/dartz)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Internet Connection Checker](https://pub.dev/packages/internet_connection_checker)
- [HTTP](https://pub.dev/packages/http)

### Development dependencies

- [Mockito](https://pub.dev/packages/mockito)
- [Bloc Test](https://pub.dev/packages/bloc_test)
- [Build Runner](https://pub.dev/packages/build_runner)

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

## Folder structure

```
lib
├── main.dart
├── injection_container.dart
├── bloc_observer.dart
├── core
│   └── constants
│   └── error
│   └── network
│   └── presentation
│       ├── util
│   └── usecases
├── features
│   ├── todo
│   │   ├── data
│   │   │   ├── datasources
│   │   │   │   └── task_local_data_source.dart
│   │   │   │   └── task_remote_data_source.dart
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
│   │       │   └── task_state.dart
│   │       ├── screens
│   │       │   ├── create_task_screen.dart
│   │       │   ├── edit_task_screen.dart
│   │       │   ├── home_screen.dart
│   │       │   └── task_details_screen.dart
│   │       └── widgets
│   │           ├── ... (widgets)

```

## Timeline

### August 16, 2023

- Error handling and reporting
  - Improve error handling and reporting

### August 15, 2023

- Use streams instead of futures for repository and usecases
- Update tests to use streams

### August 14, 2023

- UI and bloc integration

  - Write widget test
  - Refactor UI to use components and dependency injection
  - Integrate domain layer with presentation layer

- Dependency injection

  - Integrate `getIt` (external package) to manage dependency injection
  - Register dependencies in [dependency injection file](lib/injection_container.dart)

### August 13, 2023

- Bloc implementation

  - Integrate `flutter_bloc` (external package) to manage state
  - Write tests for task bloc
  - Define [task states](lib/features/todo/presentation/bloc/task_state.dart)
  - Define [task events](lib/features/todo/presentation/bloc/task_event.dart)
  - Implement [task bloc](lib/features/todo/presentation/bloc/task_bloc.dart)

### August 12, 2023

- Remote data source implementation
  - Write tests for remote data source repository
  - Add remote data source [task repository](lib/features/todo/data/datasources/task_remote_data_source.dart)
  - Integrate `http` (external package) to fetch data from remote server

### August 11, 2023

- Network info

  - Write tests for network info
  - Add external package `InternetConnectionChecker` (external package) to check internet connection.
  - Implement [NetworkInfo](lib/core/network/network_info.dart) class to check internet connection.

- Repository implementation
  - Modify [task repository](lib/features/todo/data/repositories/task_repository_impl.dart) to handle network connection.

### August 10, 2023

- Error handling

  - Utilize `dartz`'s (external package) `Either`(type) to handle error values.

- Repository implementation

  - Write tests for task repository
  - Implement [task repository](lib/features/todo/data/repositories/task_repository_impl.dart)
  - Define interfaces for local data source

- Local data source implementation

  - Write tests for TaskLocalDataSource concrete implementation
  - Implement [task local data source](lib/features/todo/data/datasources/task_local_data_source.dart) concrete implementation
  - Integrate `shared_preference` (external package) to store data locally

- Models

  - Write tests for data convertion logic between `JSON` and `TaskModel`
  - Add [task models](lib/features/todo/data/models/task_model.dart) in the data source layer to abstract data layer from domain layer.
  - Add [task mapper](lib/features/todo/data/models/task_mapper.dart) in the data source to convert between task model and task entity

### August 9, 2023

- Repository interface

  - Add [task repository interface](lib/features/todo/domain/repositories/task_repository.dart) to abstract data layer from domain layer.

- Usecases

  - Write tests for usecases
  - Define [base class](lib/core/usecases/usecase.dart) for all use cases
  - Add [usecases](lib/features/todo/domain/usecases/) to view specific task, view all tasks create, delete, update task.

- Entities
  - Create [task entity](lib/features/todo/domain/entities/task.dart) in the domain layer
