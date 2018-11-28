

class UsersList{
  final List<Users> user;

  UsersList({
    this.user,
  });

  factory UsersList.fromJson(List<dynamic> parsedJson){

    List<Users> entireList = new List<Users>();

    entireList = parsedJson.map((i)=>Users.fromJson(i)).toList();

    return UsersList(
      user: entireList,
    );
  }
}

class Users{
  final String name;
  final String age;
  final String hobby;

  Users({
    this.name,
    this.age,
    this.hobby
  });

  factory Users.fromJson(Map<String, dynamic> json){
    return new Users(
      name: json['name'],
      age: json['age'],
      hobby: json['hobby'],
    );
  }

}