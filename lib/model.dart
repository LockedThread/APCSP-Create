import 'package:meta/meta.dart';

@immutable
class Weather {
  final double temperature,
      humidity,
      precipProbability,
      nearestStormBearing,
      dewPoint,
      windSpeed,
      windGust,
      cloudCover;
  final nearestStormDistance;
  final String summary;

  Weather(
      this.nearestStormDistance,
      this.precipProbability,
      this.temperature,
      this.humidity,
      this.dewPoint,
      this.windSpeed,
      this.windGust,
      this.cloudCover,
      this.summary,
      this.nearestStormBearing);

  Weather.fromMap(Map map)
      : nearestStormDistance = map['nearestStormDistance'],
        nearestStormBearing = map['nearestStormBearing'] != null
            ? map['nearestStormBearing'].toDouble()
            : null,
        precipProbability = map['precipProbability'].toDouble(),
        temperature = map['temperature'].toDouble(),
        humidity = map['humidity'].toDouble(),
        dewPoint = map['dewPoint'].toDouble(),
        windSpeed = map['windSpeed'].toDouble(),
        windGust = map['windGust'].toDouble(),
        cloudCover = map['cloudCover'].toDouble(),
        summary = map['summary'];

  @override
  String toString() {
    return 'Weather{temperature: $temperature, humidity: $humidity, precipProbability: $precipProbability, nearestStormBearing: $nearestStormBearing, dewPoint: $dewPoint, windSpeed: $windSpeed, windGust: $windGust, cloudCover: $cloudCover, nearestStormDistance: $nearestStormDistance, summary: $summary}';
  }
}

@immutable
class Coordinates {
  /// The geographic coordinate that specifies the north–south position of a point on the Earth's surface.
  final double latitude;

  /// The geographic coordinate that specifies the east-west position of a point on the Earth's surface.
  final double longitude;

  Coordinates(this.latitude, this.longitude);

  /// Creates coordinates from a map containing its properties.
  Coordinates.fromMap(Map map)
      : latitude = map['latitude'],
        longitude = map['longitude'];

  /// Creates a map from the coordinates properties.
  Map toMap() => {
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  String toString() => '{$latitude,$longitude}';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Coordinates &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

@immutable
class Address {
  final Coordinates coordinates;
  final String addressLine,
      countryName,
      countryCode,
      featureName,
      postalCode,
      adminArea,
      subAdminArea,
      locality,
      subLocality,
      thoroughfare,
      subThoroughfare;

  Address(
      {this.coordinates,
      this.addressLine,
      this.countryName,
      this.countryCode,
      this.featureName,
      this.postalCode,
      this.adminArea,
      this.subAdminArea,
      this.locality,
      this.subLocality,
      this.thoroughfare,
      this.subThoroughfare});

  /// Creates an address from a map containing its properties.
  Address.fromMap(Map map)
      : coordinates = Coordinates.fromMap(map['coordinates']),
        addressLine = map['addressLine'],
        countryName = map['countryName'],
        countryCode = map['countryCode'],
        featureName = map['featureName'],
        postalCode = map['postalCode'],
        locality = map['locality'],
        subLocality = map['subLocality'],
        adminArea = map['adminArea'],
        subAdminArea = map['subAdminArea'],
        thoroughfare = map['thoroughfare'],
        subThoroughfare = map['subThoroughfare'];

  /// Creates a map from the address properties.
  Map toMap() => {
        'coordinates': coordinates.toMap(),
        'addressLine': addressLine,
        'countryName': countryName,
        'countryCode': countryCode,
        'featureName': featureName,
        'postalCode': postalCode,
        'locality': locality,
        'subLocality': subLocality,
        'adminArea': adminArea,
        'subAdminArea': subAdminArea,
        'thoroughfare': thoroughfare,
        'subThoroughfare': subThoroughfare,
      };

  @override
  String toString() {
    return 'Address{coordinates: $coordinates, addressLine: $addressLine, countryName: $countryName, countryCode: $countryCode, featureName: $featureName, postalCode: $postalCode, adminArea: $adminArea, subAdminArea: $subAdminArea, locality: $locality, subLocality: $subLocality, thoroughfare: $thoroughfare, subThoroughfare: $subThoroughfare}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          coordinates == other.coordinates &&
          addressLine == other.addressLine &&
          countryName == other.countryName &&
          countryCode == other.countryCode &&
          featureName == other.featureName &&
          postalCode == other.postalCode &&
          adminArea == other.adminArea &&
          subAdminArea == other.subAdminArea &&
          locality == other.locality &&
          subLocality == other.subLocality &&
          thoroughfare == other.thoroughfare &&
          subThoroughfare == other.subThoroughfare;

  @override
  int get hashCode =>
      coordinates.hashCode ^
      addressLine.hashCode ^
      countryName.hashCode ^
      countryCode.hashCode ^
      featureName.hashCode ^
      postalCode.hashCode ^
      adminArea.hashCode ^
      subAdminArea.hashCode ^
      locality.hashCode ^
      subLocality.hashCode ^
      thoroughfare.hashCode ^
      subThoroughfare.hashCode;
}

@immutable
class Alert {
  final String title, severity, description;
  final List<String> regionsEffected;

  Alert(this.title, this.severity, this.description, this.regionsEffected);

  Alert.fromMap(Map map)
      : title = map['title'],
        severity = map['severity'],
        description = map['description'],
        regionsEffected = map['regions'].cast<String>();
}
