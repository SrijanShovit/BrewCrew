class TheUser{

  final String uid;

  TheUser({ required this.uid });
}

class UserData{
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(this.uid, { required this.name, required this.sugars, required this.strength});
}