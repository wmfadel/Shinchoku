enum HomeTab {
  lists,
  dashboard,
  collaboration,
}

HomeTab tabFromName(String name) {
  for (var element in HomeTab.values) {
    if (element.name == name) return element;
  }
  return HomeTab.values.first;
}
