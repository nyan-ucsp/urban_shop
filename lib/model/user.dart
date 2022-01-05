class User {
  String? userId;
  String? userName;
  String? userRole;
  String? accountStatus;

  User({this.userId, this.userName, this.userRole, this.accountStatus});

  User.fromJson(Map<String, dynamic> json) {
    if (json["userId"] is String) userId = json["userId"];
    if (json["userName"] is String) userName = json["userName"];
    if (json["userRole"] is String) userRole = json["userRole"];
    if (json["accountStatus"] is String) accountStatus = json["accountStatus"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userId"] = userId;
    data["userName"] = userName;
    data["userRole"] = userRole;
    data["accountStatus"] = accountStatus;
    return data;
  }
}
