enum GroupType { rt, arisan, kajian }

groupTypeFromString(String v) {
  switch (v) {
    case 'RT':
      return GroupType.rt;
    case 'Arisan':
      return GroupType.arisan;
    default:
      return GroupType.kajian;
  }
}

class GroupModel {
  final String id;
  final String name;
  final GroupType type;
  final String period; // weekly | monthly
  final DateTime? nextCycleAt;
  final String createdBy;

  GroupModel({
    required this.id,
    required this.name,
    required this.type,
    required this.period,
    required this.nextCycleAt,
    required this.createdBy,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'type': typeToStr(type),
    'period': period,
    'nextCycleAt': nextCycleAt?.toIso8601String(),
    'createdBy': createdBy,
  };

  static GroupModel fromMap(String id, Map<String, dynamic> m) => GroupModel(
    id: id,
    name: m['name'],
    type: groupTypeFromString(m['type'] ?? 'RT'),
    period: m['period'] ?? 'monthly',
    nextCycleAt: m['nextCycleAt'] != null
        ? DateTime.parse(m['nextCycleAt'])
        : null,
    createdBy: m['createdBy'] ?? 'unknown',
  );

  String typeToStr(GroupType t) =>
      t == GroupType.rt ? 'RT' : (t == GroupType.arisan ? 'Arisan' : 'Kajian');
}
