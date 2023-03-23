class Employee{
  int id;
  String firstName;
  String lastName;
  String startDate;
  int address;
  String contactNo;
  int wageType;

  Employee({ required this.id,  required this.firstName, required this.lastName, required this.startDate, required this.address,
      required this.contactNo, required this.wageType});

  factory Employee.fromJson(Map<String, dynamic> parsedJson){
    return Employee(
      id: parsedJson['id'] ,
      firstName: parsedJson['first_name'] ,
      lastName: parsedJson['last_name'],
      startDate: parsedJson['start_date'],
      address: parsedJson['address'],
      contactNo: parsedJson['phone'],
      wageType: parsedJson['salary_type'],

    );
  }


}