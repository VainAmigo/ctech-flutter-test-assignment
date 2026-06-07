import 'package:ctech_flutter_test_app/features/settings/data/locale_repository.dart';
import 'package:ctech_flutter_test_app/features/settings/model/locale_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._repository) : super(const LocaleState());

  final LocaleRepository _repository;

  Future<void> load() async {
    final preference = await _repository.getPreference();
    emit(LocaleState(preference: preference));
  }

  Future<void> setPreference(LocalePreference preference) async {
    await _repository.savePreference(preference);
    emit(LocaleState(preference: preference));
  }
}
