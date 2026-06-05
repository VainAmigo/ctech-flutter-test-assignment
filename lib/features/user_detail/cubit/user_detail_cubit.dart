import 'package:ctech_flutter_test_app/features/user_detail/cubit/user_detail_state.dart';
import 'package:ctech_flutter_test_app/source/repositories/app_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit(this._repository) : super(const UserDetailState());

  final AppRepository _repository;

  Future<void> loadUser(String login) async {
    emit(state.copyWith(status: UserDetailStatus.loading, errorMessage: null));

    try {
      final user = await _repository.getUserDetail(login);
      emit(state.copyWith(status: UserDetailStatus.success, user: user));
    } catch (error) {
      emit(
        state.copyWith(
          status: UserDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
