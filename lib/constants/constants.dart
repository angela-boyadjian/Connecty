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

enum ChatStatus { Initial, Loading, Success, Error }

enum StorageStatus { Initial, Loading, UploadSuccess, DownloadSuccess, Error }

// Routes
const String splashRoute = '/';
const String homeRoute = '/home';
const String loginRoute = '/login';
const String profileRoute = '/profile';
const String registerRoute = '/register';
const String settingsRoute = '/settings';

// Preferences
const String themePref = 'theme';
