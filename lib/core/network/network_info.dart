import 'package:data_connection_checker/data_connection_checker.dart';
 abstract class NetworkInfo
{
  Future <bool> get isConneected;
}
class NetworkInfoImpl implements NetworkInfo
{
  DataConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);
  @override
  // TODO: implement isConneected
  Future<bool> get isConneected  {
    connectionChecker.hasConnection;
    return Future.value(true);
  }


}