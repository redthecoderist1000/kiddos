class Profile {
  final int? id;
  final String name;
  final String email;
  final String password; 
  final String role;

  Profile({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password, 
    'role': role,
  };

  factory Profile.fromMap(Map<String, dynamic> map) => Profile(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    password: map['password'], 
    role: map['role'],
  );
}