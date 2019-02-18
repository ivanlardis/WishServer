import 'package:wish_server/WishController.dart';
import 'package:wish_server/WishInfoController.dart';

import 'wish_server.dart';

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
        .link(() => WishController(context));

    router
        .route("/wishinfo")
        .link(() => WishInfoController(context));

    router
      .route("/example")
      .linkFunction((request) async {
        return Response.ok({"key": "value"});
      });

    return router;
  }


}
class AppConfig extends Configuration {
  AppConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
}
