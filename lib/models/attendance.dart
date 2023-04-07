class Attendance{
  int empId;
  String date;
  int daysWorked;
  String startTime;
  String endTime;
  String hoursWorked;
  String present;
  int salaryType;
  int payAmount;

  Attendance({
      required this.empId,
      required this.date,
      required this.daysWorked,
      required this.startTime,
      required this.endTime,
      required this.hoursWorked,
      required this.present,
      required this.salaryType,
      required this.payAmount});

  factory Attendance.fromJson(Map<String, dynamic> parsedJson){
   return Attendance(
       empId: parsedJson['employee_id'],
       date: parsedJson['date'],
       daysWorked: parsedJson['WorkedDays'],
       startTime: parsedJson['start_time'],
       endTime: parsedJson['end_time'],
       hoursWorked: parsedJson['difference'],
       present: parsedJson['present'],
       salaryType: parsedJson['salary_type'],
       payAmount: parsedJson['pay_rate']);
  }


}