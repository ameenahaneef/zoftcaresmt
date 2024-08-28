import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoftcares_mt/data/apiservices/version_service.dart';

part 'version_event.dart';
part 'version_state.dart';

class VersionBloc extends Bloc<VersionEvent, VersionState> {
  VersionBloc() : super(VersionInitial()) {
    on<FetchVersion>((event, emit) async{
      emit(VersionLoading());
      try {
        final version=await VersionService().fetchVersion();
        print(version);
        emit(VersionLoaded(version));
      } catch (e) {
         emit(VersionError(e.toString()));
      }

    });
  }
}
