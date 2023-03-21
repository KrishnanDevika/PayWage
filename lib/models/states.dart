class States{
  int id;
  String stateName;


  States({ required this.id,required this.stateName});

  factory States.fromJson(Map<String, dynamic> parsedJson){
    return States(
      id: parsedJson['id'] ,
      stateName: parsedJson['state'],
    );
  }
}