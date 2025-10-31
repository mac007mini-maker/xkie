import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/api_models.dart';

class ApiService {
  static Future<ApiResponse> callApi(String endpoint, Map<String, dynamic> data) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      final responseData = jsonDecode(response.body);
      
      return ApiResponse.fromJson(responseData);
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: e.toString(),
        stackTrace: stackTrace.toString(),
      );
    }
  }

  static Future<ApiResponse> uploadFile(String filePath) async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.uploadEndpoint}');
      
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('file', filePath));
      
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final responseData = jsonDecode(response.body);
      
      return ApiResponse.fromJson(responseData);
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: e.toString(),
        stackTrace: stackTrace.toString(),
      );
    }
  }

  static Future<ApiResponse> getAccountInfo() async {
    try {
      final url = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.commonEndpoint}/account');
      
      final response = await http.get(url);
      final responseData = jsonDecode(response.body);
      
      return ApiResponse.fromJson(responseData);
    } catch (e, stackTrace) {
      return ApiResponse(
        success: false,
        error: e.toString(),
        stackTrace: stackTrace.toString(),
      );
    }
  }
}

