class AppUser {
  String? id;
  String? name;
  String? email;
  String? image;
  String? phoneNumber;
  bool? isVerified;
  String? signInMethod;
  String? providerId;

  AppUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.image,
      required this.phoneNumber,
      required this.isVerified,
      this.signInMethod,
      this.providerId});
}
