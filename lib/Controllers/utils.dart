import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + '  hour ago';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + '  minute ago';
    } else if (diff.inSeconds > 0) {
      time = 'Now';
    } else if (diff.inMilliseconds > 0) {
      time = 'Now';
    } else if (diff.inMicroseconds > 0) {
      time = 'Now';
    } else {
      time = 'Now';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' day ago';
    }
  } else if (diff.inDays > 6) {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' week ago';
    }
  } else if (diff.inDays > 29) {
    if (diff.inDays == 30) {
      time = (diff.inDays / 30).floor().toString() + 'month ago ';
    }
  }
  return time;
}

String bubbleTime(int time){

  var date = DateTime.fromMillisecondsSinceEpoch(time);

  var formattedDate = DateFormat("dd-MM-yyyy  hh:mm a").format(date);

  return formattedDate;

}

String makeChatId(myID, selectedUserID) {
  String chatID;
  if (myID.hashCode > selectedUserID.hashCode) {
    chatID = '$selectedUserID-$myID';
  } else {
    chatID = '$myID-$selectedUserID';
  }
  return chatID;
}





String returnTimeStamp(int messageTimeStamp) {
  String resultString = '';
  var format = DateFormat('hh:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(messageTimeStamp);
  resultString = format.format(date);
  return resultString;
}
