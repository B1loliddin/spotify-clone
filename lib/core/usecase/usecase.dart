import 'package:spotify_clone/core/resources/data_state.dart';

abstract class UseCase<SuccessType, Params> {
  const UseCase();

  Future<DataState> call(Params params);
}

class NoParams {
  const NoParams();
}
