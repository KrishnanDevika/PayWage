class JobSite{
  int id;
  String siteName;

  JobSite({ required this.id,required this.siteName});

  factory JobSite.fromJson(Map<String, dynamic> parsedJson){
    return JobSite(
      id: parsedJson['id'] ,
      siteName: parsedJson['site_name'] ,
    );
  }
}