// ignore_for_file: non_constant_identifier_names

class UserTransactionModel {
  final String To;
  final String Date;
  final String Time;
  final int UPI_Transaction_Id;
  final int Amount_Paid;

  UserTransactionModel({
    required this.To,
    required this.Date,
    required this.Time,
    required this.UPI_Transaction_Id,
    required this.Amount_Paid,
  });

  factory UserTransactionModel.fromJson(Map<String, dynamic> json) {
    return UserTransactionModel(
      To: json['To'],
      Date: json['Date'],
      Time: json['Time'],
      UPI_Transaction_Id: json['UPI Transaction Id'],
      Amount_Paid: json['Amount Paid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'To': To,
      'Date': Date,
      'Time': Time,
      'UPI Transaction Id': UPI_Transaction_Id,
      'Amount Paid': Amount_Paid,
    };
  }
}
