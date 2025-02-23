import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CubitBase<State> extends Cubit<State> {
  CubitBase(final State initialState) : super(initialState);

  final Set<CancelableOperation> _asyncOperations = {};
  final Set<StreamSubscription> _streamSubscriptions = {};

  Future<T> executeAsync<T>(final Future<T> asyncFunction) {
    final operation = CancelableOperation.fromFuture(asyncFunction);
    _asyncOperations.add(operation);
    operation.value.then((final result) {
      _asyncOperations.remove(operation);
    }).catchError((final _) {
      _asyncOperations.remove(operation);
    });
    return operation.value;
  }

  @override
  void emit(final State state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  void executeStream(final StreamSubscription subscription) {
    _streamSubscriptions.add(subscription);
    subscription.onDone(() => _streamSubscriptions.remove(subscription));
    subscription.onError((final _) => _streamSubscriptions.remove(subscription));
  }

  @mustCallSuper
  @override
  Future<void> close() async {
    await Future.wait(_asyncOperations.map((final operation) {
      if (!operation.isCanceled) {
        return operation.cancel();
      }
      return Future.value();
    }));

    await Future.wait(_streamSubscriptions.map((final subscription) => subscription.cancel()));

    _asyncOperations.clear();
    _streamSubscriptions.clear();

    return super.close();
  }
}