import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../../flutter_flow/lat_lng.dart';
import 'api_table.dart';

abstract class ApiDataRow {
  ApiDataRow(this.data);

  ApiTable get table;
  Map<String, dynamic> data;

  String get tableName => table.tableName;

  T? getField<T>(String fieldName, [T? defaultValue]) =>
      _apiDeserialize<T>(data[fieldName]) ?? defaultValue;

  void setField<T>(String fieldName, T? value) =>
      data[fieldName] = apiSerialize<T>(value);

  List<T> getListField<T>(String fieldName) =>
      _apiDeserializeList<T>(data[fieldName]) ?? [];

  void setListField<T>(String fieldName, List<T>? value) =>
      data[fieldName] = apiSerializeList<T>(value);

  @override
  String toString() => '''
Table: $tableName
Row Data: {${data.isNotEmpty ? '\n' : ''}${data.entries.map((e) => '  (${e.value.runtimeType}) "${e.key}": ${e.value},\n').join('')}}''';

  @override
  int get hashCode => Object.hash(
        tableName,
        Object.hashAllUnordered(
          data.entries.map((e) => Object.hash(e.key, e.value)),
        ),
      );

  @override
  bool operator ==(Object other) =>
      other is ApiDataRow && mapEquals(other.data, data);
}

dynamic apiSerialize<T>(T? value) {
  if (value == null) {
    return null;
  }

  switch (T) {
    case DateTime:
      return (value as DateTime).toIso8601String();
    case PostgresTime:
      return (value as PostgresTime).toIso8601String();
    case LatLng:
      final latLng = (value as LatLng);
      return {'lat': latLng.latitude, 'lng': latLng.longitude};
    default:
      return value;
  }
}

List? apiSerializeList<T>(List<T>? value) =>
    value?.map((v) => apiSerialize<T>(v)).toList();

T? _apiDeserialize<T>(dynamic value) {
  if (value == null) {
    return null;
  }

  switch (T) {
    case int:
      if (value is String) {
        return int.tryParse(value) as T?;
      }
      return (value as num).round() as T?;
    case double:
      if (value is String) {
        return double.tryParse(value) as T?;
      }
      return (value as num).toDouble() as T?;
    case DateTime:
      final str = value as String;
      final parsed = DateTime.tryParse(str);
      if (parsed == null) return null;
      if (!str.contains('T') && !str.contains(':')) {
        final parts = str.split('-');
        if (parts.length == 3) {
          final y = int.tryParse(parts[0]);
          final m = int.tryParse(parts[1]);
          final d = int.tryParse(parts[2]);
          if (y != null && m != null && d != null) {
            return DateTime(y, m, d) as T?;
          }
        }
      }
      if (parsed.isUtc && parsed.hour == 0 && parsed.minute == 0 && parsed.second == 0 && parsed.millisecond == 0) {
        return DateTime(parsed.year, parsed.month, parsed.day) as T?;
      }
      return parsed.toLocal() as T?;
    case PostgresTime:
      return PostgresTime.tryParse(value as String) as T?;
    case LatLng:
      final latLng = value is Map ? value : json.decode(value) as Map;
      final lat = latLng['lat'] ?? latLng['latitude'];
      final lng = latLng['lng'] ?? latLng['longitude'];
      return lat is num && lng is num
          ? LatLng(lat.toDouble(), lng.toDouble()) as T?
          : null;
    default:
      if (T == String && value != null && value is! String) {
        return value.toString() as T;
      }
      return value as T;
  }
}

List<T>? _apiDeserializeList<T>(dynamic value) => value is List
    ? value
        .map((v) => _apiDeserialize<T>(v))
        .where((v) => v != null)
        .map((v) => v as T)
        .toList()
    : null;

class PostgresTime {
  PostgresTime(this.time);
  DateTime? time;

  static PostgresTime? tryParse(String formattedString) {
    final datePrefix = DateTime.now().toIso8601String().split('T').first;
    return PostgresTime(
        DateTime.tryParse('${datePrefix}T$formattedString')?.toLocal());
  }

  String? toIso8601String() {
    return time?.toIso8601String().split('T').last;
  }

  @override
  String toString() {
    return toIso8601String() ?? '';
  }
}
