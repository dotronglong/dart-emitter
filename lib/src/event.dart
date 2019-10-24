part of emitter;

mixin Event implements EventCancellable {
  bool _isCancelled = false;
  Map<String, dynamic> _data = Map();

  void cancel() {
    this._isCancelled = true;
  }

  bool isCancelled() {
    return this._isCancelled;
  }

  dynamic get(String key) => this._data[key];

  void set(String key, dynamic value) => this._data[key] = value;
}
