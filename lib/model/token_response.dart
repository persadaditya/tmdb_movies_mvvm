class TokenResponse {
  final bool success;
  final DateTime? expiresAt;
  final String requestToken;

  TokenResponse({
    required this.success,
    required this.expiresAt,
    required this.requestToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      success: json['success'] ?? false,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'].replaceFirst(' UTC', 'Z'))
          : null,
      requestToken: json['request_token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'expires_at': expiresAt?.toUtc().toIso8601String(),
      'request_token': requestToken,
    };
  }
}
