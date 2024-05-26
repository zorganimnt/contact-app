class Contact {
  int id;
  String name;
  String email;
  String phone;
  String country;
  String city;
  String imageUrl;

  Contact(
      {required this.name,
      required this.email,
      required this.id,
      required this.country,
      required this.city,
      required this.phone,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'country': country,
      'city': city,
      'imageUrl': imageUrl,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      imageUrl: map['imageUrl'],
      country: map['country'],
      city: map['city'],
    );
  }
}
