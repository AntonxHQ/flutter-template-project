class AppUser {
  String id;
  String email;
  String password;
  String name;
  String imageUrl;

  AppUser({this.email, this.name, this.id, this.password, this.imageUrl});

  AppUser.fromJson(Map<String, dynamic> json, id) {
    id = this.id;
    email = json['email'];
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
