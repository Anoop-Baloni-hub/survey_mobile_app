class LoginModel {
  Result? result;
  String? message;

  LoginModel({this.result, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Result {
  String? id;
  String? email;
  List<String>? roles;
  String? accessToken;
  String? refreshToken;
  int? accessTokenExpirationInSeconds;
  int? refreshTokenExpirationInSeconds;

  Result(
      {this.id,
        this.email,
        this.roles,
        this.accessToken,
        this.refreshToken,
        this.accessTokenExpirationInSeconds,
        this.refreshTokenExpirationInSeconds});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    roles = json['roles'].cast<String>();
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accessTokenExpirationInSeconds = json['accessTokenExpirationInSeconds'];
    refreshTokenExpirationInSeconds = json['refreshTokenExpirationInSeconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['roles'] = this.roles;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['accessTokenExpirationInSeconds'] =
        this.accessTokenExpirationInSeconds;
    data['refreshTokenExpirationInSeconds'] =
        this.refreshTokenExpirationInSeconds;
    return data;
  }
}
