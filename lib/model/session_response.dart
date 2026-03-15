class SessionResponse {
  final bool success;
  final String sessionId;

  SessionResponse({
    required this.success,
    required this.sessionId,
  });

  factory SessionResponse.fromJson(Map<String, dynamic> json) {
    return SessionResponse(
      success: json['success'] ?? false,
      sessionId: json['session_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'session_id': sessionId,
    };
  }
}
