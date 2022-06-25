class SocialUser {
  String name;
  String email;
  String photoUrl;
  String id;
  SocialUser({
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.id,
  });

  @override
  String toString() {
    return 'SocialUser(name: $name, email: $email, photoUrl: $photoUrl, id: $id)';
  }
}
