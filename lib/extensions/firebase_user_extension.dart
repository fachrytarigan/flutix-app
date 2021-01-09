part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserModel convertToUser({
    String name = "No Name",
    List<String> selectedGenres = const [],
    String selectedLanguage = "Bahasa",
    int balance = 100000,
  }) =>
      UserModel(this.uid, this.email,
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage,
          balance: balance);

  Future<UserModel> fromFireStore() async =>
      await UserServices.getUser(this.uid);
}
