class UserModel {
  final String? photo;
  final String? userName;
  late final String? role;
  final String? email;
  final int? serviceId;
  final int? id;

  UserModel({
    this.photo,
    this.role,
    this.userName,
    this.email,
    this.serviceId,
    this.id,
  });

  // Factory pour créer une instance à partir du JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['name'],
      role: json['role'],
      photo: json['photo'],
      email: json['email'],
      serviceId: json['service_id'] is int
          ? json['service_id']
          : int.tryParse(json['service_id']?.toString() ?? ''),
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id']?.toString() ?? ''),
    );
  }

  // Méthode pour convertir une instance de UserModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': userName,
      'email': email,
      'service_id': serviceId,
      'photo': photo,
      'role': role,
      'id': id,
    };
  }
}
