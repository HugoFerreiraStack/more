import 'package:b3/core/result/result.dart';
import 'package:b3/features/home/domain/models/get_quote_list_params.dart';
import 'package:b3/features/home/domain/models/quote_list_response.dart';

abstract class HomeRepository {
  Future<Result<QuoteListResponse>> getQuoteList(GetQuoteListParams params);
}