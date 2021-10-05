import 'package:equatable/equatable.dart';

 class Errors extends Equatable{
 List proparites=const <dynamic>[];
 Errors(this.proparites);
  @override
  // TODO: implement props
  List<Object?> get props => [Errors(proparites)];
}


 class ServerErrors extends Errors{
  ServerErrors(List proprties) : super(proprties);
}
class CacheErrors extends Errors{
  CacheErrors(List proprties) : super(proprties);
}