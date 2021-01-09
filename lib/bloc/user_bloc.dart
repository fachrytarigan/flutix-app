import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix_fachry/models/models.dart';
import 'package:flutix_fachry/services/services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadUser) {
      UserModel user = await UserServices.getUser(event.id);

      yield UserLoaded(user);
    } else if (event is SignOut) {
      await AuthServices.signOut();
      yield UserInitial();
    } else if (event is UpdateData) {
      UserModel updatedUser = (state as UserLoaded)
          .user
          .copyWith(name: event.name, profilePicture: event.profileImage);

      await UserServices.updateUser(updatedUser);

      yield UserLoaded(updatedUser);
    } else if (event is TopUp) {
      if (state is UserLoaded) {
        try {
          UserModel updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance + event.amount);

          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    } else if (event is Purchase) {
      if (state is UserLoaded) {
        try {
          UserModel updatedUser = (state as UserLoaded).user.copyWith(
              balance: (state as UserLoaded).user.balance - event.amount);

          await UserServices.updateUser(updatedUser);
          yield UserLoaded(updatedUser);
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
