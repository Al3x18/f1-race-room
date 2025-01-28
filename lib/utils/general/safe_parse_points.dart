double safeParsePoints(String points) {
  try {
    return double.parse(points);
  } catch (e) {
    return 0.0;
  }
}