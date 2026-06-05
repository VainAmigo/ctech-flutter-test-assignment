abstract final class FormatUtils {
  static String compactCount(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}m';
    }
    if (value >= 1000) {
      final formatted = (value / 1000).toStringAsFixed(1);
      return formatted.endsWith('.0')
          ? '${formatted.substring(0, formatted.length - 2)}k'
          : '${formatted}k';
    }
    return value.toString();
  }

  static String joinedDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return 'Joined ${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
