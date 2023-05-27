import 'package:retrofit/retrofit.dart';

// part 'location_service.g.dart';

@RestApi()
abstract class LocationService {
  // factory LocationService(Dio dio, {String baseUrl}) = _LocationService;

  // static LocationService get repository => LocationService(
  //       getDioInstanceLogged(),
  //       baseUrl: Environment.baseUrl,
  //     );

  // static const String uriLocation = '/SaveUserLocation';

  // @POST(uriLocation)
  // Future<LocationModel> sendLocation(
  //   @Body() double lat,
  //   @Body() double lng,
  //   @Body() String fcmToken,
  //   @Body() String userId,
  // );
}
