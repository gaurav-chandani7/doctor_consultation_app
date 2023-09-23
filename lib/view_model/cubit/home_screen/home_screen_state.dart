part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {
  final int activeTab;
  const HomeScreenState({required this.activeTab});
}

final class HomeScreenInitial extends HomeScreenState {
  const HomeScreenInitial({required super.activeTab});
}
