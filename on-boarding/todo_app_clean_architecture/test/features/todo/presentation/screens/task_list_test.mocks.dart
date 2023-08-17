// Mocks generated by Mockito 5.4.2 from annotations
// in todo_app_clean_architecture/test/features/todo/presentation/screens/task_list_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i5;
import 'dart:typed_data' as _i6;

import 'package:http/http.dart' as _i3;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

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

class _FakeDuration_0 extends _i1.SmartFake implements Duration {
  _FakeDuration_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAddressCheckResult_1 extends _i1.SmartFake
    implements _i2.AddressCheckResult {
  _FakeAddressCheckResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_3 extends _i1.SmartFake
    implements _i3.StreamedResponse {
  _FakeStreamedResponse_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [InternetConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockInternetConnectionChecker extends _i1.Mock
    implements _i2.InternetConnectionChecker {
  MockInternetConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Duration get checkInterval => (super.noSuchMethod(
        Invocation.getter(#checkInterval),
        returnValue: _FakeDuration_0(
          this,
          Invocation.getter(#checkInterval),
        ),
      ) as Duration);
  @override
  Duration get checkTimeout => (super.noSuchMethod(
        Invocation.getter(#checkTimeout),
        returnValue: _FakeDuration_0(
          this,
          Invocation.getter(#checkTimeout),
        ),
      ) as Duration);
  @override
  List<_i2.AddressCheckOptions> get addresses => (super.noSuchMethod(
        Invocation.getter(#addresses),
        returnValue: <_i2.AddressCheckOptions>[],
      ) as List<_i2.AddressCheckOptions>);
  @override
  set addresses(List<_i2.AddressCheckOptions>? value) => super.noSuchMethod(
        Invocation.setter(
          #addresses,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<bool> get hasConnection => (super.noSuchMethod(
        Invocation.getter(#hasConnection),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.InternetConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i4.Future<_i2.InternetConnectionStatus>.value(
            _i2.InternetConnectionStatus.connected),
      ) as _i4.Future<_i2.InternetConnectionStatus>);
  @override
  _i4.Stream<_i2.InternetConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(
        Invocation.getter(#onStatusChange),
        returnValue: _i4.Stream<_i2.InternetConnectionStatus>.empty(),
      ) as _i4.Stream<_i2.InternetConnectionStatus>);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  bool get isActivelyChecking => (super.noSuchMethod(
        Invocation.getter(#isActivelyChecking),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<_i2.AddressCheckResult> isHostReachable(
          _i2.AddressCheckOptions? options) =>
      (super.noSuchMethod(
        Invocation.method(
          #isHostReachable,
          [options],
        ),
        returnValue:
            _i4.Future<_i2.AddressCheckResult>.value(_FakeAddressCheckResult_1(
          this,
          Invocation.method(
            #isHostReachable,
            [options],
          ),
        )),
      ) as _i4.Future<_i2.AddressCheckResult>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i3.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i3.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<_i3.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<_i3.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<_i3.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<_i3.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<_i3.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i5.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i3.Response>);
  @override
  _i4.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  _i4.Future<_i6.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i6.Uint8List>.value(_i6.Uint8List(0)),
      ) as _i4.Future<_i6.Uint8List>);
  @override
  _i4.Future<_i3.StreamedResponse> send(_i3.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i4.Future<_i3.StreamedResponse>.value(_FakeStreamedResponse_3(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i4.Future<_i3.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
