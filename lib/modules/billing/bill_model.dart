class BillModel {
  final String id;
  final String cycleLabel; // mis: Jan 2026 / Pekan-12
  final DateTime dueDate;
  final num amount;
  final DateTime createdAt;

  BillModel({
    required this.id,
    required this.cycleLabel,
    required this.dueDate,
    required this.amount,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'cycleLabel': cycleLabel,
    'dueDate': dueDate.toIso8601String(),
    'amount': amount,
    'createdAt': createdAt.toIso8601String(),
  };
}
