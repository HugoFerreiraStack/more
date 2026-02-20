import 'package:b3/core/result/result.dart';
import 'package:b3/core/usecases/base_usecase.dart';
import 'package:b3/features/home/domain/models/get_quote_list_params.dart';
import 'package:b3/features/home/domain/models/quote_list_response.dart';
import 'package:b3/features/home/domain/repositories/home_repository.dart';

class FetchStocksUsecase
    extends UseCase<QuoteListResponse, GetQuoteListParams> {
  final HomeRepository repository;
  FetchStocksUsecase(this.repository);

  @override
  Future<Result<QuoteListResponse>> call(GetQuoteListParams params) async {
    return await repository.getQuoteList(params);
  }
}
