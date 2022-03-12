/// Enum for the possible values in [HomePage] `bottomNavigationBar` tabs.
enum HomeTab {
  lists,
  dashboard,
  collaboration,
}

/// gets [HomeTab] ite by it's name, if name not found defaults to first value
HomeTab tabFromName(String name) {
  for (var element in HomeTab.values) {
    if (element.name == name) return element;
  }
  return HomeTab.values.first;
}
