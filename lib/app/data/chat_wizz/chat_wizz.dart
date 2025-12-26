// ignore_for_file: camel_case_types, unnecessary_this

class Chat_Wizz {
  String? reply;

  Chat_Wizz({this.reply});

  Chat_Wizz.fromJson(Map<String, dynamic> json) {
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reply'] = this.reply;
    return data;
  }
}