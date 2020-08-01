import 'package:hive/hive.dart';

part 'dam.g.dart';

@HiveType(typeId: 0)
class DamInfo {
  @HiveField(0)
  final int damID;
  @HiveField(1)
  final String damName;
  @HiveField(2)
  final String riverName;
  @HiveField(3)
  final String doe;
  @HiveField(4)
  final String district;
  @HiveField(5)
  final String stationCode;

  DamInfo({
    this.damID,
    this.damName,
    this.riverName,
    this.doe,
    this.district,
    this.stationCode,
  });

  int get getDamID => damID;
  String get getDamName => damName;
  String get getRiverName => riverName;
  String get getDOE => doe;
  String get getDistrict => district;
  String get getStationCode => stationCode;

  static cleanName(String name) {
    List<String> splitName =
        name.replaceAll(RegExp(r'\([^()]*\)'), '').trim().split(' ');
    var cleanList = splitName
        .map((e) => e.length > 0
            ? '${e[0].toUpperCase()}${e.toLowerCase().substring(1)}'
            : e)
        .toList();
    String cleanName = cleanList.join(' ');
    return cleanName;
  }

  factory DamInfo.fromJson(Map<String, dynamic> json) {
    return DamInfo(
      damID: json['id'],
      damName: DamInfo.cleanName(json['name']),
      riverName: json['river'],
      doe: json['date_of_establishment'],
      district: DamInfo.cleanName(json['district']),
      stationCode: json['station_code'],
    );
  }
}
