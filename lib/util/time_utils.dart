///时间格式化默认时间格式yyyy-mm-dd HH:mm
timeFormat(DateTime dateTime) {
  return "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

///时间格式化默认时间格式HH:mm
timeFormatHM(DateTime dateTime) {
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

/// 时间格式化显示昨天、今天、明天
timeFormatChineseHM(DateTime dateTime) {
  print(dateTime);
  var old = dateTime;
  var now = new DateTime.now().toLocal();
  var d = old.day - now.day;
  String str = '';
  if (d == 0) {
    str = '今天';
  } else if (d == -1) {
    str = '昨天';
  } else if (d == 1) {
    str = '明天';
  } else {
    if (old.year == now.year) {
      str =
          "${dateTime.month.toString().padLeft(2, '0')}月${dateTime.day.toString().padLeft(2, '0')}日";
    } else {
      str =
          "${dateTime.year.toString()}年${dateTime.month.toString().padLeft(2, '0')}月${dateTime.day.toString().padLeft(2, '0')}日";
    }
  }
  return "$str ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
}

///获取星期几
timeFormatWeekDay(DateTime dateTime) {
  if (dateTime.weekday == 1) {
    return '周一';
  }
  if (dateTime.weekday == 2) {
    return '周二';
  }
  if (dateTime.weekday == 3) {
    return '周三';
  }
  if (dateTime.weekday == 4) {
    return '周四';
  }
  if (dateTime.weekday == 5) {
    return '周五';
  }
  if (dateTime.weekday == 6) {
    return '周六';
  }
  if (dateTime.weekday == 7) {
    return '周日';
  }
}

///计算传入时间是否大于当前时间的指定的分钟数
bool timeMinGreaterAbs(DateTime dateTime, int num) {
  var now = new DateTime.now().toLocal();
  var difference = now.difference(dateTime);
  return difference.inMinutes.abs() > num;
}

bool timeMinGreater(DateTime dateTime, int num) {
  var now = new DateTime.now().toLocal();
  var difference = now.difference(dateTime);
  return difference.inMinutes > num;
}

///计算传入时间是否小于当前时间的指定的分钟数
bool timeLessAbs(DateTime dateTime, int num) {
  var now = new DateTime.now().toLocal();
  var difference = now.difference(dateTime);
  return difference.inMinutes.abs() <= num;
}

///计算传入时间是否小于当前时间的指定的分钟数
bool timeLess(DateTime dateTime, int num) {
  var now = new DateTime.now().toLocal();
  var difference = now.difference(dateTime);
  return difference.inMinutes <= num;
}

int timeLessNum(DateTime dateTime) {
  var now = new DateTime.now().toLocal();
  var difference = dateTime.difference(now);
  return difference.inMinutes;
}

///获取两个时间相差秒数
int timeLessNumAbs(DateTime start, DateTime end) {
  var difference = end.difference(start);
  return difference.inSeconds;
}

///dateTime 是否小于当前时间 true
bool timeIsAfter(DateTime dateTime) {
  var now = new DateTime.now().toLocal();
  return now.isAfter(dateTime);
}

///dateTime 是否大于当前时间 true
bool timeIsBefore(DateTime dateTime) {
  var now = new DateTime.now().toLocal();
  return now.isBefore(dateTime);
}

///计算时间差，返回格式 1天3小时20分
String timeDifference(DateTime start) {
  var endDate = new DateTime.now();
  var minutes = start.difference(endDate).inSeconds;
  var day = (minutes / (24 * 3600)).floor();
  if (day < 0) {
    return "";
  }
  if (day == 0) {
    return "( ${(minutes % (24 * 3600) / 3600).floor()}小时${(minutes % 3600 / 60).floor()}分 )";
  }
  return "( ${(minutes / (24 * 3600)).floor()}天${(minutes % (24 * 3600) / 3600).floor()}小时${(minutes % 3600 / 60).floor()}分 )";
}

void main() {
  var d1 = new DateTime(2021, 08, 03, 14, 05, 00);
  var d2 = new DateTime(2021, 08, 03, 14, 05, 10);
  print(timeLessNumAbs(d1, d2));
}
