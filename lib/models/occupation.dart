class Occupation{
  int id;
  String occupation;


  Occupation({ required this.id,required this.occupation});

  factory Occupation.fromJson(Map<String, dynamic> parsedJson){
    return Occupation(
      id: parsedJson['id'] ,
      occupation: parsedJson['occupation_type'] ,
    );
  }
}