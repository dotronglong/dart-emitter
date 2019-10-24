import 'package:emitter/emitter.dart';
import 'package:test/test.dart';

class DummyEvent with Event {}

void main() {
  test('cancellable: can cancel', () {
    DummyEvent event = DummyEvent();
    expect(event.isCancelled(), false);
    event.cancel();
    expect(event.isCancelled(), true);
  });

  test('get/set: can get/set data', () {
    String key = "key", value = "value";
    DummyEvent event = DummyEvent();
    expect(event.get(key), null);
    event.set(key, value);
    expect(event.get(key), value);
  });
}