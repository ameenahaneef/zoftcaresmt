class VersionResponse {
  final bool status;
  final VersionData data;

  VersionResponse({
    required this.status,
    required this.data,
  });

  factory VersionResponse.fromJson(Map<String, dynamic> json) {
    return VersionResponse(
      status: json['status'],
      data: VersionData.fromJson(json['data']),
    );
  }
}

class VersionData {
  final String version;

  VersionData({
    required this.version,
  });

  factory VersionData.fromJson(Map<String, dynamic> json) {
    return VersionData(
      version: json['version'],
    );
  }
}
