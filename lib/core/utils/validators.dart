class FormsValidators {
  static String? validateEmailField(String? email) {
    if (email == null || email.isEmpty) return 'Users must have email address';
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(email)) return 'Invalid email address';
    return null;
  }

  static String? validateNameField(String? name) {
    if (name == null || name.isEmpty) return 'Users must have name';
    return null;
  }

  static String? validatePasswordField(String? password) {
    if (password == null || password.isEmpty) return 'Users must have password';
    if (password.length < 6) return 'password must be 6 or more characters';
    return null;
  }
}
