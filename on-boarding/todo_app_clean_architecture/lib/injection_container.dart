import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_clean_architecture/core/network/network_info.dart';
import 'package:todo_app_clean_architecture/core/presentation/util/input_converter.dart';
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart';
import 'package:todo_app_clean_architecture/features/todo/data/repositories/task_repository_impl.dart';
import 'package:todo_app_clean_architecture/features/todo/domain/repositories/task_repository.dart';
import 'features/todo/domain/usecases/usecases.dart' as usecases;
import 'features/todo/presentation/bloc/task_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! Features - Todo
  // Bloc
  serviceLocator.registerFactory(
    () => TaskBloc(
        createTask: serviceLocator(),
        deleteTask: serviceLocator(),
        updateTask: serviceLocator(),
        getTask: serviceLocator(),
        getAllTasks: serviceLocator(),
        inputConverter: serviceLocator()),
  );

  // Use cases
  serviceLocator.registerLazySingleton(
    () => usecases.CreateTask(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => usecases.UpdateTask(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => usecases.DeleteTask(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => usecases.GetAllTasks(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => usecases.GetTask(serviceLocator()),
  );

  // Core
  serviceLocator.registerLazySingleton(() => InputConverter());
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      localDataSource: serviceLocator(),
    ),
  );

  // Data sources
  serviceLocator.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
