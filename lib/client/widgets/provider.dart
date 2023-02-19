import 'package:e1547/client/client.dart';
import 'package:e1547/interface/interface.dart';

class ClientProvider extends SubProvider<ClientService, Client> {
  ClientProvider({super.child, super.builder})
      : super(
          create: (context, service) =>
              getApiTypeForHost(service.host)!.createClientFromService(service),
          keys: (context) {
            ClientService service = context.watch<ClientService>();
            return [
              service.host,
              service.credentials,
              service.userAgent,
              service.cache,
              service.memoryCache,
              service.cookies,
            ];
          },
          dispose: (context, client) => client.close(force: true),
        );
}
