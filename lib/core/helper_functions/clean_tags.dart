String cleanHtmlTags(String input) {
  // إزالة جميع وسوم HTML باستخدام تعبير منتظم
  return input.replaceAll(RegExp(r'<[^>]*>'), '').trim();
}