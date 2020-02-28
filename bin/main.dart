import 'package:APCSP_Create/model.dart';
import 'package:APCSP_Create/utils.dart';
import 'package:args/args.dart';

void main(List<String> arguments) {
  var parser = ArgParser()..addOption('query', abbr: 'q');
  var argResults = parser.parse(arguments);

  var location = makeGeocodePost(argResults['query']);

  location.then((location) {
    var coordinates = location.coordinates;
    var response = get(
        'https://api.darksky.net/forecast/136bc35fd405f21ccb53f219af72db74/${coordinates.latitude},${coordinates.longitude}');
    response.then((value) {
      var weather = Weather.fromMap(value['currently']);
      print('Weather for ${location.locality}, ${location.adminArea}:'
          '\nSummary: ${weather.summary}'
          '\nTemperature: ${weather.temperature}F'
          '\nCloud Coverage: ${(weather.cloudCover * 100.0).ceilToDouble()}%'
          '${weather.nearestStormDistance != null ? '\nNearest Storm: ${weather.nearestStormDistance} miles ${weather.nearestStormBearing != null ? 'degrees ${getCardinalDirectionFromBearing(weather.nearestStormBearing)}' : ''}' : ''}'
          '\nPrecipitation Probability: ${weather.precipProbability * 100.0}%'
          '\nWind Speed: ${weather.windSpeed}mph'
          '\nWind Gusts: ${weather.windGust}mph'
          '\nHumidity: ${weather.humidity * 100.0}%'
          '\nDew Point: ${weather.dewPoint}F\n');

      if (value['alerts'] != null) {
        var alerts = value['alerts'].map((e) => Alert.fromMap(e));

        if (alerts.isNotEmpty) {
          for (Alert v in alerts) {
            print('Title: ${v.title}'
                '\nDescription: ${v.description}'
                'Regions Effected: ${v.regionsEffected.join(", ")}');
          }
        } else {
          print(
              'There is no weather.gov sanctioned weather warnings currently.');
        }
      }
    });
  });
}
