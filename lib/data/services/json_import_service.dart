import 'package:dio/dio.dart';

import '../models/reference.dart';

/// Loads a reference document either from a remote URL or from raw pasted text,
/// and parses it into [ReferenceManga] objects.
class JsonImportService {
  JsonImportService(this._dio);

  final Dio _dio;

  /// Fetches JSON from [url] and parses it. Throws [ReferenceParseException] on
  /// malformed content or a [JsonImportException] on network failure.
  Future<List<ReferenceManga>> fromUrl(String url) async {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      throw JsonImportException('Please enter a URL.');
    }
    try {
      final response = await _dio.get<String>(
        trimmed,
        options: Options(responseType: ResponseType.plain),
      );
      final body = response.data;
      if (body == null || body.isEmpty) {
        throw JsonImportException('The URL returned an empty response.');
      }
      return parseReferenceJson(body);
    } on DioException catch (e) {
      throw JsonImportException('Could not fetch URL: ${e.message ?? e}');
    }
  }

  /// Parses a raw JSON string (e.g. pasted by the user).
  List<ReferenceManga> fromRaw(String raw) {
    if (raw.trim().isEmpty) {
      throw JsonImportException('Please paste some JSON.');
    }
    return parseReferenceJson(raw);
  }
}

class JsonImportException implements Exception {
  JsonImportException(this.message);
  final String message;
  @override
  String toString() => message;
}
