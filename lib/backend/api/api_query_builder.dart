/// Construtor simples de consultas para a API REST.
class ApiQueryBuilder {
  final Map<String, String> filters = {};
  String? orderBy;
  bool descending = false;
  int? limitValue;
  int? offsetValue;

  ApiQueryBuilder order(String column, {bool ascending = true}) {
    orderBy = column;
    descending = !ascending;
    return this;
  }

  ApiQueryBuilder eq(String column, dynamic value) {
    filters[column] = value?.toString() ?? '';
    return this;
  }

  ApiQueryBuilder limit(int value) {
    limitValue = value;
    return this;
  }

  ApiQueryBuilder offset(int value) {
    offsetValue = value;
    return this;
  }

  Map<String, String> build() {
    final params = Map<String, String>.from(filters);
    if (orderBy != null && orderBy!.isNotEmpty) {
      params['orderBy'] = orderBy!;
      params['orderDirection'] = descending ? 'desc' : 'asc';
    }
    if (limitValue != null) {
      params['limit'] = limitValue.toString();
    }
    if (offsetValue != null) {
      params['offset'] = offsetValue.toString();
    }
    return params;
  }
}
