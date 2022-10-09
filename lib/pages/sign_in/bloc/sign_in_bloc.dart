import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/pages/sign_in/bloc/sign_in_event.dart';
import 'package:form_validation/pages/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (!emailRegex.hasMatch(event.email)) {
        emit(SignInErrorState('Invalid email'));
      } else if (event.password.length < 8) {
        emit(SignInErrorState('Invalid password'));
      } else {
        emit(SignInValidState());
      }
    });

    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
