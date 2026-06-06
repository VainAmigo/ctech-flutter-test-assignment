import 'package:ctech_flutter_test_app/core/core.dart';
import 'package:ctech_flutter_test_app/source/source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'repos_list_state.dart';

class ReposListCubit extends Cubit<ReposListState> {
  ReposListCubit(this._repository) : super(const ReposListState());

  final AppRepository _repository;

  Future<void> loadRepos(String reposUrl) async {
    emit(
      state.copyWith(
        status: ReposListStatus.loading,
        repos: const [],
        reposUrl: reposUrl,
        page: 1,
        hasMore: true,
        errorMessage: null,
      ),
    );
    await _loadPage(page: 1, append: false);
  }

  Future<void> refresh() async {
    if (state.reposUrl == null) return;
    await loadRepos(state.reposUrl!);
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore ||
        state.reposUrl == null ||
        state.repos.isEmpty ||
        state.status == ReposListStatus.loading ||
        state.status == ReposListStatus.loadingMore) {
      return;
    }

    emit(
      state.copyWith(status: ReposListStatus.loadingMore, errorMessage: null),
    );
    await _loadPage(page: state.page + 1, append: true);
  }

  Future<void> _loadPage({required int page, required bool append}) async {
    try {
      final repos = await _repository.getUserRepos(
        reposUrl: state.reposUrl!,
        page: page,
      );

      final newRepos = append
          ? repos
                .where((repo) => !state.repos.any((r) => r.id == repo.id))
                .toList()
          : repos;
      final updatedRepos = append ? [...state.repos, ...newRepos] : newRepos;

      emit(
        state.copyWith(
          status: ReposListStatus.success,
          repos: updatedRepos,
          page: page,
          hasMore: repos.length >= ApiConst.reposPerPage,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: append ? ReposListStatus.success : ReposListStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
