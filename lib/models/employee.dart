class Employee{
  int id;
  String firstName;
  String lastName;
  String startDate;
  String contactNo;
  String city;
  String state;
  String street;
  String occupation;
  String salaryType;
  int baseRate;


  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.startDate,
    required this.contactNo,
    required this.street,
    required this.city,
    required this.state,
    required this.occupation,
    required this.salaryType,
    required this.baseRate

   });

  factory Employee.fromJson(Map<String, dynamic> parsedJson){
    return Employee(
      id: parsedJson['id'] ,
      firstName: parsedJson['first_name'] ,
      lastName: parsedJson['last_name'],
      startDate: parsedJson['start_date'],
      contactNo: parsedJson['phone'],
        street: parsedJson['street'],
        city: parsedJson['city'],
        state: parsedJson['state'],
      occupation: parsedJson['occupation_type'],
      salaryType : parsedJson['salary_type'],
      baseRate: parsedJson['pay_rate']

    );
  }


}