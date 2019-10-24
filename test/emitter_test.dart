import 'package:emitter/emitter.dart';
import 'package:test/test.dart';

class DummyEvent with Event {
  int count = 0;
}

void main() {
  var name = "some-event";

  test('on: can subscribe event', () {
    var emitter = EventEmitter();
    emitter.on(name, (event) {});
  });

  test('off: can unsubscribe event', () {
    var emitter = EventEmitter();
    emitter.on(name, (event) {});
    emitter.off(name);
  });

  test('emit: can emit event', () {
    var emitter = EventEmitter();
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
    });
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
    });
    DummyEvent event = DummyEvent();
    emitter.emit(name, event);
    expect(event.count, 2);
  });

  test('cancellable: can cancel event', () {
    var emitter = EventEmitter();
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
        event.cancel();
      }
    });
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
    });
    DummyEvent event = DummyEvent();
    emitter.emit(name, event);
    expect(event.count, 1);
  });
}
