import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:users/users_repository.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final UsersRepository _usersRepository;
  List<User> _contacts = [];

  ContactsCubit(this._usersRepository) : super(ContactsInitial());

  Future<void> addContact(String id, User contact) async {
    emit(ContactsLoading());
    try {
      await _usersRepository.addContact(id, contact);
      _contacts.add(contact);
      emit(ContactsSuccess(contacts: _contacts));
    } on Exception {
      throw ContactsError();
    }
  }

  Future<void> removeContact(String id, User contact) async {
    emit(ContactsLoading());
    try {
      await _usersRepository.removeContact(id, contact);
      _contacts.removeWhere((item) => item.id == contact.id);
      emit(ContactsSuccess(contacts: _contacts));
    } on Exception {
      throw ContactsError();
    }
  }

  Future<void> fetchList(User user) async {
    emit(ContactsLoading());
    try {
      List<User> results = user.contacts;
      _contacts = results;
      emit(ContactsSuccess(contacts: _contacts));
    } on Exception {
      emit(ContactsError());
    }
  }

  bool isInList(User user, String contactId) {
    var r = false;
    state.contacts?.forEach((element) {
      if (element.id == contactId) r = true;
    });
    return r;
  }
}
