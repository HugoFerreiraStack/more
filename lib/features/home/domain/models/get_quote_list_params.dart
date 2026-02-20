class GetQuoteListParams {
  final int page;
  final int limit;

  GetQuoteListParams({required this.page, required this.limit});

  factory GetQuoteListParams.fromJson(Map<String, dynamic> json) {
    return GetQuoteListParams(
      page: json['page'] as int,
      limit: json['limit'] as int,
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
    };
  }
}