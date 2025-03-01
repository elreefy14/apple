class Country {
  final String code;
  final String name;
  final List<StateModel> states;

  Country({required this.code, required this.name, required this.states});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      name: json['name'],
      states: (json['states'] as List)
          .map((state) => StateModel.fromJson(state))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'states': states.map((state) => state.toJson()).toList(),
    };
  }
}

class StateModel {
  final String code;
  final String name;

  StateModel({required this.code, required this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}
