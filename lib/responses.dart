class Responses {
  Data data;
  String message;

  Responses({this.data, this.message});

  Responses.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int bloodPressure;
  double bodyTemperature;
  int cholesterol;
  int glucose;
  int heartRate;
  int oxygenSaturation;
  int respiration;
  int steps;

  Data(
      {this.bloodPressure,
      this.bodyTemperature,
      this.cholesterol,
      this.glucose,
      this.heartRate,
      this.oxygenSaturation,
      this.respiration,
      this.steps});

  Data.fromJson(Map<String, dynamic> json) {
    bloodPressure = json['bloodPressure'];
    bodyTemperature = json['bodyTemperature'];
    cholesterol = json['cholesterol'];
    glucose = json['glucose'];
    heartRate = json['heartRate'];
    oxygenSaturation = json['oxygenSaturation'];
    respiration = json['respiration'];
    steps = json['steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bloodPressure'] = this.bloodPressure;
    data['bodyTemperature'] = this.bodyTemperature;
    data['cholesterol'] = this.cholesterol;
    data['glucose'] = this.glucose;
    data['heartRate'] = this.heartRate;
    data['oxygenSaturation'] = this.oxygenSaturation;
    data['respiration'] = this.respiration;
    data['steps'] = this.steps;
    return data;
  }
}
