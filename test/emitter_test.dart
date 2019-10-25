import 'package:emitter/emitter.dart';
import 'package:test/test.dart';

class DummyEvent with CancelledEvent, SynchronizedEvent {
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

  test('emit: can emit event', () async {
    var emitter = EventEmitter();
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
      return;
    });
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
      return;
    });
    DummyEvent event = DummyEvent();
    await emitter.emit(name, event);
    expect(event.count, 2);
  });

  test('cancellable: can cancel event', () async {
    var emitter = EventEmitter();
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
        event.cancel();
      }
      return;
    });
    emitter.on(name, (event) {
      if (event is DummyEvent) {
        event.count++;
      }
      return;
    });
    DummyEvent event = DummyEvent();
    await emitter.emit(name, event);
    expect(event.count, 1);
  });
}
