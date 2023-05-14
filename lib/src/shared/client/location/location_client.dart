import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:share_app/config/environment/environment.dart';
import 'package:share_app/config/helpers/http_helper.dart';
import 'package:share_app/src/shared/model/location_model.dart';

part 'location_client.g.dart';

@RestApi()
abstract class LocationClient {
  factory LocationClient(Dio dio, {String baseUrl}) = _LocationClient;

  static LocationClient get repository => LocationClient(
        getDioInstanceLogged(),
        baseUrl: Environment.baseUrl,
      );

  static const String uriLocation = '/SaveUserLocation';

  @POST(uriLocation)
  Future<LocationModel> sendLocation(
    @Body() double lat,
    @Body() double lng,
    @Body() String fcmToken,
    @Body() String userId,
  );
}
