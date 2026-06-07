import 'dart:async';

import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_list_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit(this._repository) : super(const UsersListState());

  final AppRepository _repository;
  Timer? _searchDebounce;

  Future<void> loadFirstPage() async {
    _searchDebounce?.cancel();

    emit(
      state.copyWith(
        status: UsersListStatus.loading,
        users: const [],
        hasMore: true,
        searchQuery: '',
        isSearchMode: false,
        searchPage: 1,
        errorMessage: null,
        clearSince: true,
      ),
    );
    await _loadUsers(since: null, append: false);
  }

  Future<void> refresh() async {
    if (state.isSearchMode && state.searchQuery.isNotEmpty) {
      await _performSearch(state.searchQuery);
      return;
    }
    await loadFirstPage();
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore ||
        state.users.isEmpty ||
        state.status == UsersListStatus.loading ||
        state.status == UsersListStatus.loadingMore) {
      return;
    }

    emit(
      state.copyWith(status: UsersListStatus.loadingMore, errorMessage: null),
    );

    if (state.isSearchMode) {
      await _loadSearch(page: state.searchPage + 1, append: true);
    } else {
      await _loadUsers(since: state.users.last.id, append: true);
    }
  }

  void search(String query) {
    _searchDebounce?.cancel();

    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      loadFirstPage();
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(trimmed);
    });
  }

  Future<void> _performSearch(String query) async {
    emit(
      state.copyWith(
        status: UsersListStatus.loading,
        users: const [],
        searchQuery: query,
        isSearchMode: true,
        searchPage: 1,
        hasMore: true,
        errorMessage: null,
        clearSince: true,
      ),
    );
    await _loadSearch(page: 1, append: false);
  }

  Future<void> _loadUsers({required int? since, required bool append}) async {
    try {
      final users = await _repository.getUsers(since: since);
      final newUsers = append
          ? users
                .where((user) => !state.users.any((u) => u.id == user.id))
                .toList()
          : users;
      final updatedUsers = append ? [...state.users, ...newUsers] : newUsers;

      emit(
        state.copyWith(
          status: UsersListStatus.success,
          users: updatedUsers,
          since: updatedUsers.isEmpty ? since : updatedUsers.last.id,
          hasMore: users.length >= ApiConst.usersPerPage,
        ),
      );
    } catch (error) {
      NetworkErrorMapper.notifyIfNoInternet(error);
      emit(
        state.copyWith(
          status: append ? UsersListStatus.success : UsersListStatus.failure,
          errorMessage: NetworkErrorMapper.message(error),
        ),
      );
    }
  }

  Future<void> _loadSearch({required int page, required bool append}) async {
    try {
      final response = await _repository.searchUsers(
        query: state.searchQuery,
        page: page,
      );

      final newUsers = append
          ? response.items
                .where((user) => !state.users.any((u) => u.id == user.id))
                .toList()
          : response.items;
      final updatedUsers = append ? [...state.users, ...newUsers] : newUsers;

      emit(
        state.copyWith(
          status: UsersListStatus.success,
          users: updatedUsers,
          searchPage: page,
          hasMore: response.items.length >= ApiConst.usersPerPage,
        ),
      );
    } catch (error) {
      NetworkErrorMapper.notifyIfNoInternet(error);
      emit(
        state.copyWith(
          status: append ? UsersListStatus.success : UsersListStatus.failure,
          errorMessage: NetworkErrorMapper.message(error),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
