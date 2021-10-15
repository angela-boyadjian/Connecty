part of 'contacts_cubit.dart';

abstract class ContactsState extends Equatable {
  final bool isInList;
  final List<User> contacts;

  const ContactsState({this.contacts, this.isInList});

  @override
  List<Object> get props => [this.contacts];
}

class ContactsInitial extends ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsSuccess extends ContactsState {
  final List<User> contacts;

  const ContactsSuccess({this.contacts});

  @override
  List<Object> get props => [this.contacts];
}

class ContactsError extends ContactsState {}
