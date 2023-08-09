part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class GetTasks extends TaskEvent {}

final class GetTask extends TaskEvent {
  final int id;

  const GetTask(this.id);

  @override
  List<Object> get props => [id];
}

final class CreateTask extends TaskEvent {
  final String title;
  final String description;
  final String date;

  const CreateTask(this.title, this.description, this.date);

  @override
  List<Object> get props => [title, description, date];
}

final class UpdateTask extends TaskEvent {
  final int id;
  final String title;
  final String description;
  final String date;
  final bool completed;

  const UpdateTask(
      this.id, this.title, this.description, this.date, this.completed);

  @override
  List<Object> get props => [id, title, description, date, completed];
}

final class DeleteTask extends TaskEvent {
  final int id;

  const DeleteTask(this.id);

  @override
  List<Object> get props => [id];
}
