part of 'version_bloc.dart';

@immutable
sealed class VersionState {}

final class VersionInitial extends VersionState {}


class VersionLoading extends VersionState {}

class VersionLoaded extends VersionState {
  final String version;

  VersionLoaded(this.version);
}

class VersionError extends VersionState {
  final String message;

  VersionError(this.message);
}