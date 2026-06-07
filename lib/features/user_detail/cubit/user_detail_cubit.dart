import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._repository) : super(const UserDetailState());

  final AppRepository _repository;

  Future<void> loadUser(String login) async {
    emit(
      state.copyWith(
        status: UserDetailStatus.loading,
        errorMessage: null,
        clearUser: true,
      ),
    );

    try {
      final user = await _repository.getUserDetail(login);
      emit(state.copyWith(status: UserDetailStatus.success, user: user));
    } catch (error) {
      NetworkErrorMapper.notifyIfNoInternet(error);
      emit(
        state.copyWith(
          status: UserDetailStatus.failure,
          errorMessage: NetworkErrorMapper.message(error),
        ),
      );
    }
  }
}
