import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void setValue(final int value) => emit(state.copyWith(page: value));

  void goToHomePage() => emit(state.copyWith(page: 1));
}