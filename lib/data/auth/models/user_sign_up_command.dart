class UserSignUpCommand {
  final String email;
  final String password;
  final String socialType;
  String? username;
  String? birthDate;
  int? gender; // 0: 남, 1: 여
  DateTime? createdAt;

  UserSignUpCommand({
    required this.email,
    required this.password,
    required this.socialType,
    this.username,
    this.birthDate,
    this.gender,
    this.createdAt,
  });
}
