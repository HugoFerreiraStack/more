// Result pattern para padronizar retornos de operações assíncronas.
// Representa o resultado de uma operação que pode ter sucesso ou falhar.
// Evita o uso de exceções para controle de fluxo e torna o tratamento de erros mais explícito.
class Result<T> {
  const Result._(this._data, this._error, this._isSuccess);

  final T? _data;
  final String? _error;
  final bool _isSuccess;

  // Cria um Result de sucesso com os dados fornecidos.
  factory Result.success(T data) => Result._(data, null, true);

  // Cria um Result de falha com a mensagem de erro fornecida.
  factory Result.failure(String error) => Result._(null, error, false);

  // Verifica se o resultado é um sucesso.
  bool get isSuccess => _isSuccess;

  // Verifica se o resultado é uma falha.
  bool get isFailure => !_isSuccess;

  // Retorna os dados em caso de sucesso.
  
  // Lança uma exceção se chamado em um Result de falha.
  T get data {
    if (!_isSuccess) {
      throw StateError('Cannot get data from a failed Result');
    }
    return _data as T;
  }

  // Retorna a mensagem de erro em caso de falha.
  
  // Lança uma exceção se chamado em um Result de sucesso.
  String get error {
    if (_isSuccess) {
      throw StateError('Cannot get error from a successful Result');
    }
    return _error!;
  }

  // Executa uma função se o resultado for sucesso. 
  // Retorna um novo Result com o resultado da função.
  Result<R> map<R>(R Function(T data) mapper) {
    if (_isSuccess) {
      return Result.success(mapper(_data as T));
    }
    return Result.failure(_error!);
  }

  // Executa uma função se o resultado for falha.
  // Retorna o mesmo Result se for sucesso.
  Result<T> mapError(String Function(String error) mapper) {
    if (!_isSuccess) {
      return Result.failure(mapper(_error!));
    }
    return this;
  }

  /// Equivalente ao fold do dartz: (onFailure, onSuccess)
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