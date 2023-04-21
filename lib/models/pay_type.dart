class PayType{
  int id;
  String type;


  PayType({ required this.id,required this.type});

  factory PayType.fromJson(Map<String, dynamic> parsedJson){
    return PayType(
      id: parsedJson['id'] as int,
      type: parsedJson['pay_type'] as String,
    );
  }
}