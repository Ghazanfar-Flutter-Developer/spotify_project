class UserEntity {
  String? fullName;
  String? email;
  String? imageUrl;

  UserEntity({
    this.fullName,
    this.email,
    this.imageUrl,
  });

  @override
  String toString() {
    return 'UserEntity(fullName: $fullName, email: $email, imageUrl: $imageUrl)';
  }
}
