class UserModel {
  final String phone;
  final String password;

  UserModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'password': password};
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(phone: json['phone'], password: json['password']);
  }
}
