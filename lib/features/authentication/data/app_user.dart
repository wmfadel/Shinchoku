class AppUser {
  String? id;
  String? name;
  String? email;
  String? image;
  String? phoneNumber;
  bool? isVerified;

  AppUser({
    this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.phoneNumber,
    required this.isVerified,
  });

  AppUser.fromFire(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    email = data['email'];
    image = data['image'];
    phoneNumber = data['phoneNumber'];
    isVerified = data['isVerified'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
      'isVerified': isVerified,
    };
  }

  @override
  String toString() {
    return 'AppUser: ' + toJson().toString();
  }
}
