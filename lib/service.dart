import 'dummy/dummy_service.dart' if (dart.library.html) 'web/web_service.dart' if (dart.library.io) 'mobile/service.dart';

abstract class PlatformService {
  Future getValue();
  Stream getStream();
}

PlatformServiceImpl getService() {
  return PlatformServiceImpl();
}
