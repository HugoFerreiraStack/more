import '../result/result.dart';

// Interface base para Use Cases seguindo Clean Architecture.

// Use Cases encapsulam lógica de negócio específica e são independentes de frameworks e bibliotecas externas.
abstract class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

// Classe para Use Cases que não precisam de parâmetros.
class NoParams {
  const NoParams();
}