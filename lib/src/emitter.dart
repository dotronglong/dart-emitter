import 'cancellable.dart';
import 'listener.dart';

class EventEmitter {
  Map<String, List<EventListener>> _listeners = Map();

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

  void emit(String name, dynamic event) {
    if (this._listeners.containsKey(name)) {
      for (EventListener listener in this._listeners[name]) {
        listener(event);
        if (event is EventCancellable && event.isCancelled()) {
          break;
        }
      }
    }
  }
}
