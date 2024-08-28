part of 'version_bloc.dart';

@immutable
sealed class VersionEvent {}

class FetchVersion extends VersionEvent {}
