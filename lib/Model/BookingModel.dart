class BookingModel {
  BookingModel({
    required this.data,
  });
  late final List<Data> data;

  BookingModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.distance,
    this.time,
    required this.rideType,
    required this.from,
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.totalAmount,
    this.pickupAddress,
    this.destinationAddress,
  });
  late final int id;
  late final double? distance;
  late final String? time;
  late final String rideType;
  late final String from;
  late final String destination;
  late final String startDate;
  late final String endDate;
  late final int totalAmount;
  late final String? pickupAddress;
  late final String? destinationAddress;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    distance = json['distance'];
    time = null;
    rideType = json['ride_type'];
    from = json['from'];
    destination = json['destination'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalAmount = json['total_amount'];
    pickupAddress = null;
    destinationAddress = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['distance'] = distance;
    _data['time'] = time;
    _data['ride_type'] = rideType;
    _data['from'] = from;
    _data['destination'] = destination;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['total_amount'] = totalAmount;
    _data['pickup_address'] = pickupAddress;
    _data['destination_address'] = destinationAddress;
    return _data;
  }
}