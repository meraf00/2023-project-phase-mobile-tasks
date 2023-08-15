import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/util/input_converter.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/usecases.dart' as usecases;

part 'task_event.dart';
part 'task_messages.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final usecases.GetTask getTask;
  final usecases.GetAllTasks getAllTasks;
  final usecases.CreateTask createTask;
  final usecases.UpdateTask updateTask;
  final usecases.DeleteTask deleteTask;

  final InputConverter inputConverter;

  TaskBloc(
      {required this.createTask,
      required this.deleteTask,
      required this.updateTask,
      required this.getTask,
      required this.getAllTasks,
      required this.inputConverter})
      : super(InitialState()) {
    //
    //
    // Get all tasks
    on<LoadAllTasksEvent>((event, emit) async {
      emit(LoadingState());

      final stream = getAllTasks(NoParams());

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = ErrorState(failure.message);
          },
          (task) {
            state = LoadedAllTasksState(task);
          },
        );

        return state;
      });
    });

    //
    // Get task
    on<GetSingleTaskEvent>((event, emit) async {
      emit(LoadingState());

      final stream = getTask(usecases.GetTaskParams(id: event.id));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = ErrorState(failure.message);
          },
          (task) {
            state = LoadedSingleTaskState(task);
          },
        );

        return state;
      });
    });

    //
    // Create task
    on<CreateTaskEvent>((event, emit) async {
      final parsedDate = inputConverter.stringToDateTime(event.date);

      if (parsedDate.isLeft()) {
        emit(const ErrorState(invalidDateFailureMessage));
        return;
      }

      final task = Task(
          id: -1,
          title: event.title,
          description: event.description,
          completed: false,
          dueDate: (parsedDate as Right).value);

      final stream = createTask(usecases.CreateParams(task: task));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = ErrorState(failure.message);
          },
          (task) {
            state = CreatedTaskState(task);
          },
        );

        return state;
      });
    });

    //
    // Update task
    on<UpdateTaskEvent>((event, emit) async {
      final parsedDate = inputConverter.stringToDateTime(event.date);

      if (parsedDate.isLeft()) {
        emit(const ErrorState(invalidDateFailureMessage));
        return;
      }

      final task = Task(
          id: event.id,
          title: event.title,
          description: event.description,
          completed: event.completed,
          dueDate: (parsedDate as Right).value);

      final stream = updateTask(usecases.UpdateParams(task: task));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = ErrorState(failure.message);
          },
          (task) {
            state = UpdatedTaskState(task);
          },
        );

        return state;
      });
    });

    //
    // Delete task
    on<DeleteTaskEvent>((event, emit) async {
      final stream = deleteTask(usecases.DeleteParams(id: event.id));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = ErrorState(failure.message);
          },
          (task) {
            state = DeletedTaskState(task);
          },
        );

        return state;
      });
    });
  }
}
