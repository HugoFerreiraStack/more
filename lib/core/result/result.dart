// Wrapper pra sucesso/erro sem depender de try-catch
class Result<T> {
  const Result._(this._data, this._error, this._isSuccess);

  final T? _data;
  final String? _error;
  final bool _isSuccess;

  factory Result.success(T data) => Result._(data, null, true);
  factory Result.failure(String error) => Result._(null, error, false);

  bool get isSuccess => _isSuccess;
  bool get isFailure => !_isSuccess;
  T get data {
    if (!_isSuccess) {
      throw StateError('Cannot get data from a failed Result');
    }
    return _data as T;
  }

  String get error {
    if (_isSuccess) {
      throw StateError('Cannot get error from a successful Result');
    }
    return _error!;
  }

  Result<R> map<R>(R Function(T data) mapper) {
    if (_isSuccess) {
      return Result.success(mapper(_data as T));
    }
    return Result.failure(_error!);
  }

  Result<T> mapError(String Function(String error) mapper) {
    if (!_isSuccess) {
      return Result.failure(mapper(_error!));
    }
    return this;
  }

  E fold<E>(E Function(String error) onFailure, E Function(T data) onSuccess) {
    if (_isSuccess) return onSuccess(_data as T);
    return onFailure(_error!);
  }

  Result<T> onSuccess(void Function(T data) callback) {
    if (_isSuccess) {
      callback(_data as T);
    }
    return this;
  }

  Result<T> onFailure(void Function(String error) callback) {
    if (!_isSuccess) {
      callback(_error!);
    }
    return this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result<T> &&
        other._isSuccess == _isSuccess &&
        other._data == _data &&
        other._error == _error;
  }

  @override
  int get hashCode => Object.hash(_isSuccess, _data, _error);

  @override
  String toString() {
    if (_isSuccess) {
      return 'Result.success($_data)';
    }
    return 'Result.failure($_error)';
  }
}