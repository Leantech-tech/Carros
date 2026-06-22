import 'api_client.dart';
import 'api_query_builder.dart';
import 'api_row.dart';

abstract class ApiTable<T extends ApiDataRow> {
  String get tableName;
  T createRow(Map<String, dynamic> data);

  Future<List<T>> queryRows({
    required ApiQueryBuilder Function(ApiQueryBuilder) queryFn,
  }) async {
    final builder = queryFn(ApiQueryBuilder());
    final response = await ApiClient.get(
      '/$tableName',
      queryParams: builder.build(),
    );
    final rows = (response as List).cast<Map<String, dynamic>>();
    return rows.map(createRow).toList();
  }

  Future<List<T>> querySingleRow({
    required ApiQueryBuilder Function(ApiQueryBuilder) queryFn,
  }) async {
    try {
      final builder = queryFn(ApiQueryBuilder().limit(1));
      final response = await ApiClient.get(
        '/$tableName',
        queryParams: builder.build(),
      );
      final rows = (response as List).cast<Map<String, dynamic>>();
      if (rows.isEmpty) return [];
      return [createRow(rows.first)];
    } catch (e) {
      print('Error querying row: $e');
      return [];
    }
  }

  Future<T> insert(Map<String, dynamic> data) async {
    final response = await ApiClient.post('/$tableName', data);
    return createRow(response as Map<String, dynamic>);
  }

  Future<List<T>> update({
    required Map<String, dynamic> data,
    required ApiQueryBuilder Function(ApiQueryBuilder) matchingRows,
    bool returnRows = false,
  }) async {
    final builder = matchingRows(ApiQueryBuilder());
    final filters = builder.filters;

    if (filters.isEmpty) {
      throw Exception('Update requires at least one filter (e.g., eq("id", ...))');
    }

    // A API REST atualiza pelo id. Suporta múltiplos ids se necessário.
    final updatedRows = <T>[];
    for (final entry in filters.entries) {
      if (entry.key != 'id') continue;
      final response = await ApiClient.patch('/$tableName/${entry.value}', data);
      if (returnRows && response != null) {
        updatedRows.add(createRow(response as Map<String, dynamic>));
      }
    }
    return updatedRows;
  }

  Future<List<T>> delete({
    required ApiQueryBuilder Function(ApiQueryBuilder) matchingRows,
    bool returnRows = false,
  }) async {
    final builder = matchingRows(ApiQueryBuilder());
    final filters = builder.filters;

    if (filters.isEmpty) {
      throw Exception('Delete requires at least one filter (e.g., eq("id", ...))');
    }

    final deletedRows = <T>[];
    for (final entry in filters.entries) {
      if (entry.key != 'id') continue;
      final response = await ApiClient.delete('/$tableName/${entry.value}');
      if (returnRows && response != null && response['data'] != null) {
        deletedRows.add(createRow(response['data'] as Map<String, dynamic>));
      }
    }
    return deletedRows;
  }
}
