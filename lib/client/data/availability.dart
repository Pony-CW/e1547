import 'package:e1547/client/client.dart';

abstract class AvailabilityClient implements Client {
  Future<void> availability();
}
