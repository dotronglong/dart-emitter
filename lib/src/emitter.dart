import 'dart:async';

import 'cancellable.dart';
import 'listener.dart';
import 'synchronizable.dart';

class EventEmitter {
  static EventEmitter instance = EventEmitter();
  final Map<String, List<_EventContainer>> _containers = Map();

  void on(String name, EventListener listener, {int limit}) {
    var container = _EventContainer(listener, limit);
    if (this._containers.containsKey(name)) {
      this._containers[name].add(container);
    } else {
      this._containers[name] = [container];
    }
  }

  void off(String name) {
    this._containers[name] = List();
  }

  void once(String name, EventListener listener) =>
      on(name, listener, limit: 1);

  Future<void> emit(String name, dynamic event) async {
    if (this._containers.containsKey(name)) {
      List<int> removeIndexes = [];
      for (int i = 0; i < this._containers[name].length; i++) {
        var container = this._containers[name][i];
        if (event is EventSynchronizable && event.isSynchronized()) {
          await container.listener(event);
        } else {
          container.listener(event);
        }
        if (container.limit != null && container.limit > 0) {
          container.limit--;
        }
        if (container.limit == 0) {
          removeIndexes.add(i);
        }
        if (event is EventCancellable && event.isCancelled()) {
          break;
        }
      }
      for (int index in removeIndexes) {
        this._containers[name].removeAt(index);
      }
    }
  }
}

class _EventContainer {
  final EventListener listener;
  int limit;

  _EventContainer(this.listener, this.limit);
}
