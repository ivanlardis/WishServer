import 'package:wish_server/controller/CrashController.dart';
import 'package:wish_server/controller/PulseMetricController.dart';
import 'package:wish_server/controller/UserDeviceController.dart';
import 'package:wish_server/controller/WishController.dart';
import 'package:wish_server/controller/WishInfoController.dart';
import 'package:wish_server/controller/WishOpenInfoController.dart';
import 'package:wish_server/controller/RegisterController.dart';
import 'package:wish_server/model/User.dart';

import 'wish_server.dart';
import 'package:aqueduct/managed_auth.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class WishServerChannel extends ApplicationChannel {
  /// Initialize services in this method.
  ///
  /// Implement this method to initialize services, read values from [options]
  /// and any other initialization required before constructing [entryPoint].
  ///
  /// This method is invoked prior to [entryPoint] being accessed.
  AuthServer authServer;

  ManagedContext context;
  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final config = AppConfig(options.configurationFilePath);
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(

        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    context = ManagedContext(dataModel, persistentStore);

    final authStorage = ManagedAuthDelegate<User>(context);
    authServer = AuthServer(authStorage);
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    router
        .route("/wish")
        .link(() => Authorizer.bearer(authServer))
        .link(() => WishController(context));

    router
        .route("/wishinfo")
        .link(() => Authorizer.bearer(authServer))
        .link(() => WishInfoController(context));

    router
        .route('/register')
        .link(() => RegisterController(context, authServer));

    router
        .route('/auth/token')
        .link(() => AuthController(authServer));

    router
        .route('/wishopeninfo')
        .link(() => WishOpenInfoController(context));

    router
        .route('/crash')
        .link(() => CrashController(context));

    router
        .route('/devices')
        .link(() => UserDeviceController(context));
  router
        .route('/metric')
        .link(() => PulseMetricController(context));

    return router;
  }

}
class AppConfig extends Configuration {
  AppConfig(String path): super.fromFile(File(path));
  DatabaseConfiguration database;
}
