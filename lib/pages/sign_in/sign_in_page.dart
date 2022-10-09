import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validation/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:form_validation/pages/sign_in/bloc/sign_in_event.dart';
import 'package:form_validation/pages/sign_in/bloc/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(50),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            children: [
              BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              }),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(
                        emailController.text, passwordController.text),
                  );
                },
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email address',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  BlocProvider.of<SignInBloc>(context).add(
                    SignInTextChangedEvent(
                        emailController.text, passwordController.text),
                  );
                },
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  if (state is SignInLoadingState) {
                    return const Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return CupertinoButton(
                    color: Colors.blue,
                    disabledColor: Colors.grey,
                    onPressed: state is SignInValidState
                        ? () {
                            BlocProvider.of<SignInBloc>(context).add(
                              SignInSubmittedEvent(emailController.text,
                                  passwordController.text),
                            );
                          }
                        : null,
                    child: const Text('Login'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
