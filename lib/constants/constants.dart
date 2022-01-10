// Enums
enum TabScreens {
  Contacts,
  Home,
  Search,
  Profile,
}

enum AuthenticationStatus {
  Authenticated,
  Unauthenticated,
  Unknown,
  Success,
  Error
}

enum UserStatus { Initial, Loading, Success, Error, NoUser }

enum ChatStatus { Initial, Loading, Success, Error, Empty, OpenChat }

enum StorageStatus { Initial, Loading, UploadSuccess, DownloadSuccess, Error }

// Routes
const String splashRoute = '/';
const String tosRoute = '/tos';
const String homeRoute = '/home';
const String chatRoute = '/chat';
const String loginRoute = '/login';
const String profileRoute = '/profile';
const String settingsRoute = '/settings';
const String communityRoute = '/community';
const String profileEditRoute = '/profileEdit';
const String contactProfileRoute = '/contactProfile';

// Preferences
const String themePref = 'theme';
