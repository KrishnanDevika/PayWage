class City{
  int id;
  String cityName;


  City({ required this.id,required this.cityName});

  factory City.fromJson(Map<String, dynamic> parsedJson){
    return City(
      id: parsedJson['id'] ,
      cityName: parsedJson['city'] ,
    );
  }
}