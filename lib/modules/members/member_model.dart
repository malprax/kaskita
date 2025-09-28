class MemberModel {
  final String id;
  final String name;
  final String phone;
  final String status; // active | inactive
  MemberModel({
    required this.id,
    required this.name,
    required this.phone,
    this.status = 'active',
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'status': status,
  };
  static MemberModel fromMap(String id, Map<String, dynamic> m) => MemberModel(
    id: id,
    name: m['name'] ?? '-',
    phone: m['phone'] ?? '-',
    status: m['status'] ?? 'active',
  );
}
