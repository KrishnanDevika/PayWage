class SalaryType{
  int id;
  String type;


  SalaryType({ required this.id,required this.type});

  factory SalaryType.fromJson(Map<String, dynamic> parsedJson){
    return SalaryType(
        id: parsedJson['id'] as int,
        type: parsedJson['salary_type'] as String,
    );
  }
}