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
      : super(TaskInitial()) {
    //
    //
    // Get all tasks
    on<GetTasks>((event, emit) async {
      emit(TaskLoading());

      final stream = getAllTasks(NoParams());

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = TaskError(failure.message);
          },
          (task) {
            state = TasksLoaded(task);
          },
        );

        return state;
      });
    });

    //
    // Get task
    on<GetTask>((event, emit) async {
      emit(TaskLoading());

      final stream = getTask(usecases.GetTaskParams(id: event.id));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = TaskError(failure.message);
          },
          (task) {
            state = TaskLoaded(task);
          },
        );

        return state;
      });
    });

    //
    // Create task
    on<CreateTask>((event, emit) async {
      final parsedDate = inputConverter.stringToDateTime(event.date);

      if (parsedDate.isLeft()) {
        emit(const TaskError(invalidDateFailureMessage));
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
            state = TaskError(failure.message);
          },
          (task) {
            state = TaskCreated(task);
          },
        );

        return state;
      });
    });

    //
    // Update task
    on<UpdateTask>((event, emit) async {
      final parsedDate = inputConverter.stringToDateTime(event.date);

      if (parsedDate.isLeft()) {
        emit(const TaskError(invalidDateFailureMessage));
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
            state = TaskError(failure.message);
          },
          (task) {
            state = TaskUpdated(task);
          },
        );

        return state;
      });
    });

    //
    // Delete task
    on<DeleteTask>((event, emit) async {
      final stream = deleteTask(usecases.DeleteParams(id: event.id));

      await emit.forEach(stream, onData: (result) {
        late TaskState state;

        result.fold(
          (failure) {
            state = TaskError(failure.message);
          },
          (task) {
            state = TaskDeleted(task);
          },
        );

        return state;
      });
    });
  }
}
