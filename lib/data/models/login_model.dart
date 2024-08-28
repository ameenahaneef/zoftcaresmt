class LoginResponse {
  final bool status;
  final Data data;

  LoginResponse({
    required this.status,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? false,
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final User user;
  final String accessToken;
  final int validity;

  Data({
    required this.user,
    required this.accessToken,
    required this.validity,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: User.fromJson(json['user'] ?? {}),
      accessToken: json['accessToken'] ?? '',
      validity: json['validity'] ?? 0,
    );
  }
}

class User {
  final String firstName;
  final String lastName;

  User({
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }
}
