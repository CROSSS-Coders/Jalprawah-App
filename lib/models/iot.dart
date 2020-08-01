class ValueIOT {
  final double value;
  final DateTime time;

  ValueIOT({this.value, this.time});

  double get getValues => value;
  DateTime get getTime => time;
}

class IOTValues {
  final List<ValueIOT> forecastSeries;
  final List<ValueIOT> waterSeries;
  final int damID;

  IOTValues({this.damID, this.forecastSeries, this.waterSeries});

  List<ValueIOT> get getForecastValues => forecastSeries;
  List<ValueIOT> get getWaterValues => waterSeries;

  factory IOTValues.fromJson(damID, Map<String, dynamic> json) {
    List<ValueIOT> forecastValues = [];
    List<ValueIOT> waterValues = [];
    for (dynamic forecast in json['forecast']) {
      forecastValues.add(ValueIOT(
          value: forecast['water_level'],
          time: DateTime.parse(forecast['created_at'])));
    }
    for (dynamic value in json['values']) {
      waterValues.add(ValueIOT(
          value: value['value'], time: DateTime.parse(value['datatime'])));
    }
    return IOTValues(
      damID: damID,
      forecastSeries: forecastValues,
      waterSeries: waterValues,
    );
  }
}
