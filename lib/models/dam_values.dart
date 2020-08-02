class ValueTime {
  final double value;
  final DateTime time;

  ValueTime({this.value, this.time});

  double get getValues => value;
  DateTime get getTime => time;
}

class DamValues {
  final List<ValueTime> forecastSeries;
  final List<ValueTime> waterSeries;
  final int damID;

  DamValues({this.damID, this.forecastSeries, this.waterSeries});

  List<ValueTime> get getForecastValues => forecastSeries;
  List<ValueTime> get getWaterValues => waterSeries;

  factory DamValues.fromJson(damID, Map<String, dynamic> json) {
    List<ValueTime> forecastValues = [];
    List<ValueTime> waterValues = [];
    for (dynamic forecast in json['forecast']) {
      forecastValues.add(ValueTime(
          value: forecast['water_level'],
          time: DateTime.parse(forecast['created_at'])));
    }
    for (dynamic value in json['values']) {
      waterValues.add(ValueTime(
          value: value['value'], time: DateTime.parse(value['datatime'])));
    }
    return DamValues(
      damID: damID,
      forecastSeries: forecastValues,
      waterSeries: waterValues,
    );
  }
}
