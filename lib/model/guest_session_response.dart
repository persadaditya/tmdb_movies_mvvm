class GuestSessionResponse {
  final bool success;
  final String guestSessionId;
  final DateTime? expiresAt;

  GuestSessionResponse({
    required this.success,
    required this.guestSessionId,
    this.expiresAt,
  });

  factory GuestSessionResponse.fromJson(Map<String, dynamic> json) {
    return GuestSessionResponse(
      success: json['success'] ?? false,
      guestSessionId: json['guest_session_id'] ?? '',
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'].replaceFirst(' UTC', 'Z'))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'guest_session_id': guestSessionId,
      'expires_at': expiresAt?.toUtc().toIso8601String(),
    };
  }
}
