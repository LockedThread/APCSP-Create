import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

const HEADERS = {
  'Accept': 'application/json',
};
const CARDINAL_DIRECTIONS = [
  'N',
  'NNE',
  'NE',
  'ENE',
  'E',
  'ESE',
  'SE',
  'SSE',
  'S',
  'SSW',
  'SW',
  'WSW',
  'W',
  'WNW',
  'NW',
  'NNW',
  'N'
];

Future<Address> makeGeocodePost(String query) async {
  var url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=${query}&key=AIzaSyAdoEbfUYGkQrHMtUsk1Fqb96UBSoW6fBk';

  var results = await get(url);
  if (results == null) return null;

  return results['results']
      .map(_convertAddress)
      .map<Address>((map) => Address.fromMap(map))
      .first;
}

Future<dynamic> get(String url) async {
  var response = await http.get(url, headers: HEADERS);
  return jsonDecode(response.body);
}

Map<String, double> _convertCoordinates(dynamic geometry) {
  if (geometry == null) {
    return null;
  }

  var location = geometry['location'];
  if (location == null) {
    return null;
  }

  return {
    'latitude': location['lat'],
    'longitude': location['lng'],
  };
}

Map<String, Object> _convertAddress(dynamic data) {
  var result = <String, Object>{};

  result['coordinates'] = _convertCoordinates(data['geometry']);
  result['addressLine'] = data['formatted_address'];

  var addressComponents = data['address_components'];

  addressComponents.forEach((item) {
    var types = item['types'];

    if (types.contains('route')) {
      result['thoroughfare'] = item['long_name'];
    } else if (types.contains('street_number')) {
      result['subThoroughfare'] = item['long_name'];
    } else if (types.contains('country')) {
      result['countryName'] = item['long_name'];
      result['countryCode'] = item['short_name'];
    } else if (types.contains('locality')) {
      result['locality'] = item['long_name'];
    } else if (types.contains('postal_code')) {
      result['postalCode'] = item['long_name'];
    } else if (types.contains('administrative_area_level_1')) {
      result['adminArea'] = item['long_name'];
    } else if (types.contains('administrative_area_level_2')) {
      result['subAdminArea'] = item['long_name'];
    } else if (types.contains('sublocality') ||
        types.contains('sublocality_level_1')) {
      result['subLocality'] = item['long_name'];
    } else if (types.contains('premise')) {
      result['featureName'] = item['long_name'];
    }
    result['featureName'] = result['featureName'] ?? result['addressLine'];
  });

  return result;
}

String getCardinalDirectionFromBearing(double bearing) {
  return CARDINAL_DIRECTIONS[((bearing + 11.25) % 360.0) ~/ 22.5];
}
