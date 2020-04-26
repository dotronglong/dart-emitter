import 'dart:async';

import 'cancellable.dart';
import 'listener.dart';
import 'synchronizable.dart';

class EventEmitter {
  static EventEmitter instance = EventEmitter();
  final Map<String, List<EventListener>> _listeners;

  EventEmitter([Map<String, List<EventListener>> listeners])
      : _listeners = listeners ?? Map();

  void on(String name, EventListener listener) {
    if (this._listeners.containsKey(name)) {
      this._listeners[name].add(listener);
    } else {
      this._listeners[name] = [listener];
    }
  }

  void off(String name) {
    this._listeners[name] = List();
  }

  Future<void> emit(String name, dynamic event) async {
    if (this._listeners.containsKey(name)) {
      for (EventListener listener in this._listeners[name]) {
        if (event is EventSynchronizable && event.isSynchronized()) {
          await listener(event);
        } else {
          listener(event);
        }
        if (event is EventCancellable && event.isCancelled()) {
          break;
        }
      }
    }
  }
}
