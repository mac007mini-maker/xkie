class ApiRequest {
  final String model;
  final Map<String, dynamic> parameters;

  ApiRequest({
    required this.model,
    required this.parameters,
  });

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'parameters': parameters,
    };
  }
}

class ApiResponse {
  final bool success;
  final dynamic data;
  final String? error;
  final String? stackTrace;

  ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.stackTrace,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'] ?? false,
      data: json['data'],
      error: json['error'],
      stackTrace: json['stackTrace'],
    );
  }
}

class MediaResult {
  final String? url;
  final String? type; // 'image', 'video', 'audio'
  final Map<String, dynamic>? metadata;

  MediaResult({
    this.url,
    this.type,
    this.metadata,
  });

  factory MediaResult.fromJson(Map<String, dynamic> json) {
    return MediaResult(
      url: json['url'],
      type: json['type'],
      metadata: json['metadata'],
    );
  }
}

