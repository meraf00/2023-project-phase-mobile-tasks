// Mocks generated by Mockito 5.4.2 from annotations
// in todo_app_clean_architecture/test/features/todo/data/repositories/task_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:todo_app_clean_architecture/core/network/network_info.dart'
    as _i6;
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_local_data_source.dart'
    as _i3;
import 'package:todo_app_clean_architecture/features/todo/data/datasources/task_remote_data_source.dart'
    as _i5;
import 'package:todo_app_clean_architecture/features/todo/data/models/task_model.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTaskModel_0 extends _i1.SmartFake implements _i2.TaskModel {
  _FakeTaskModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TaskLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskLocalDataSource extends _i1.Mock
    implements _i3.TaskLocalDataSource {
  MockTaskLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<void> cacheTasks(List<_i2.TaskModel>? tasks) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheTasks,
          [tasks],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<List<_i2.TaskModel>> getTasks() => (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
        ),
        returnValue: _i4.Future<List<_i2.TaskModel>>.value(<_i2.TaskModel>[]),
      ) as _i4.Future<List<_i2.TaskModel>>);
  @override
  _i4.Future<_i2.TaskModel> getTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #getTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> createTask(_i2.TaskModel? todo) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [todo],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #createTask,
            [todo],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> updateTask(_i2.TaskModel? todo) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [todo],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #updateTask,
            [todo],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> deleteTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #deleteTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
}

/// A class which mocks [TaskRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskRemoteDataSource extends _i1.Mock
    implements _i5.TaskRemoteDataSource {
  MockTaskRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i2.TaskModel>> getTasks() => (super.noSuchMethod(
        Invocation.method(
          #getTasks,
          [],
        ),
        returnValue: _i4.Future<List<_i2.TaskModel>>.value(<_i2.TaskModel>[]),
      ) as _i4.Future<List<_i2.TaskModel>>);
  @override
  _i4.Future<_i2.TaskModel> getTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #getTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> createTask(_i2.TaskModel? todo) =>
      (super.noSuchMethod(
        Invocation.method(
          #createTask,
          [todo],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #createTask,
            [todo],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> updateTask(_i2.TaskModel? todo) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateTask,
          [todo],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #updateTask,
            [todo],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
  @override
  _i4.Future<_i2.TaskModel> deleteTask(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteTask,
          [id],
        ),
        returnValue: _i4.Future<_i2.TaskModel>.value(_FakeTaskModel_0(
          this,
          Invocation.method(
            #deleteTask,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.TaskModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}
