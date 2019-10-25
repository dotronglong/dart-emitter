import 'cancellable.dart';
import 'synchronizable.dart';

mixin CancelledEvent implements EventCancellable {
  bool _isCancelled = false;

  void cancel() => this._isCancelled = true;

  bool isCancelled() => this._isCancelled;
}

mixin SynchronizedEvent implements EventSynchronizable {
  bool isSynchronized() => true;
}

mixin ParameterizedEvent {
  Map<String, dynamic> _parameters = Map();

  dynamic get(String key) => this._parameters[key];

  void set(String key, dynamic value) => this._parameters[key] = value;
}
