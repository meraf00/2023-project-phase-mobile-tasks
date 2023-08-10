import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/presentation/util/input_converter.dart';
import '../../domain/usecases/usecases.dart' as usecases;
import '../../domain/entities/task.dart';

part 'task_event.dart';
part 'task_state.dart';
part 'task_messages.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final usecases.ViewTask getTask;
  final usecases.ViewAllTasks getAllTasks;
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

      final result = await getAllTasks(NoParams());

      result.fold(
        (failure) => emit(const TaskError(cacheFailureMessage)),
        (task) => emit(TasksLoaded(task)),
      );
    });

    //
    // Get task
    on<GetTask>((event, emit) async {
      emit(TaskLoading());

      final result = await getTask(usecases.GetTaskParams(id: event.id));

      result.fold(
        (failure) => emit(const TaskError(cacheFailureMessage)),
        (task) => emit(TaskLoaded(task)),
      );
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

      final result = await createTask(usecases.CreateParams(task: task));

      result.fold(
        (failure) => emit(const TaskError(cacheFailureMessage)),
        (task) => emit(TaskCreated(task)),
      );
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

      final result = await updateTask(usecases.UpdateParams(task: task));

      result.fold(
        (failure) => emit(const TaskError(cacheFailureMessage)),
        (_) => emit(TaskUpdated(task)),
      );
    });

    //
    // Delete task
    on<DeleteTask>((event, emit) async {
      final result = await deleteTask(usecases.DeleteParams(id: event.id));

      result.fold(
        (failure) => emit(const TaskError(cacheFailureMessage)),
        (task) => emit(TaskDeleted(task)),
      );
    });
  }
}
