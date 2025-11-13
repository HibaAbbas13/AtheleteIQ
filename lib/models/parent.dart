class Parent {
  final String email;
  final String password; 
  final String? name;

  Parent({
    required this.email,
    required this.password,
    this.name,
  });

  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
      email: map['email'],
      password: map['password'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      email: json['email'],
      password: json['password'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}

