/// Returns chat ID between 2 users
String getChatId(String userId, String otherId) {
  if (userId.compareTo(otherId) == -1) {
    return '$userId+$otherId';
  }
  return '$otherId+$userId';
}
