import 'stock.dart';

class IndexSummary {
  final String stock;
  final String name;

  const IndexSummary({required this.stock, required this.name});

  factory IndexSummary.fromJson(Map<String, dynamic> json) {
    return IndexSummary(
      stock: json['stock'] as String,
      name: json['name'] as String,
    );
  }
}

class QuoteListResponse {
  final List<IndexSummary> indexes;
  final List<Stock> stocks;
  final List<String> availableSectors;
  final List<String> availableStockTypes;
  final int currentPage;
  final int totalPages;
  final int itemsPerPage;
  final int totalCount;
  final bool hasNextPage;

  const QuoteListResponse({
    required this.indexes,
    required this.stocks,
    required this.availableSectors,
    required this.availableStockTypes,
    required this.currentPage,
    required this.totalPages,
    required this.itemsPerPage,
    required this.totalCount,
    required this.hasNextPage,
  });

  factory QuoteListResponse.fromJson(Map<String, dynamic> json) {
    return QuoteListResponse(
      indexes: (json['indexes'] as List<dynamic>?)
              ?.map((e) => IndexSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      stocks: (json['stocks'] as List<dynamic>?)
              ?.map((e) => Stock.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      availableSectors:
          ((json['availableSectors'] ?? json['available_sectors']) as List<dynamic>?)?.cast<String>() ?? [],
      availableStockTypes:
          ((json['availableStockTypes'] ?? json['available_stock_types']) as List<dynamic>?)?.cast<String>() ?? [],
      currentPage: (json['currentPage'] ?? json['current_page']) as int? ?? 1,
      totalPages: (json['totalPages'] ?? json['total_pages']) as int? ?? 1,
      itemsPerPage: (json['itemsPerPage'] ?? json['items_per_page']) as int? ?? 10,
      totalCount: (json['totalCount'] ?? json['total_count']) as int? ?? 0,
      hasNextPage: (json['hasNextPage'] ?? json['has_next_page']) as bool? ?? false,
    );
  }
}
