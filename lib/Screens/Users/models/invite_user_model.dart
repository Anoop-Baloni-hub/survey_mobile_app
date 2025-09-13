
class UserResponseModel {
  final int userId;
  final String userName;
  final String email;
  final String roleName;
  final String categories;
  final String locationName;

  UserResponseModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.roleName,
    required this.categories,
    required this.locationName,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      roleName: json['roleName'],
      categories: json['categories'],
      locationName: json['locationName'],
    );
  }
}

class InvitedUserListModel {
  final InvitedUserResult? result;

  InvitedUserListModel({this.result});

  factory InvitedUserListModel.fromJson(Map<String, dynamic> json) {
    return InvitedUserListModel(
      result: json['result'] != null ? InvitedUserResult.fromJson(json['result']) : null,
    );
  }
}

class InvitedUserResult {
  final List<UserResponseModel>? userResponseModel;

  InvitedUserResult({this.userResponseModel});

  factory InvitedUserResult.fromJson(Map<String, dynamic> json) {
    return InvitedUserResult(
      userResponseModel: (json['userResponseModel'] as List<dynamic>?)
          ?.map((e) => UserResponseModel.fromJson(e))
          .toList(),
    );
  }
}


class OnboardUserModel {
  final OnboardUserResult? result;

  OnboardUserModel({this.result});

  factory OnboardUserModel.fromJson(Map<String, dynamic> json) {
    return OnboardUserModel(
      result: json['result'] != null ? OnboardUserResult.fromJson(json['result']) : null,
    );
  }
}

class OnboardUserResult {
  final List<UserResponseModel>? userResponseModel;

  OnboardUserResult({this.userResponseModel});

  factory OnboardUserResult.fromJson(Map<String, dynamic> json) {
    return OnboardUserResult(
      userResponseModel: (json['userResponseModel'] as List<dynamic>?)
          ?.map((e) => UserResponseModel.fromJson(e))
          .toList(),
    );
  }
}
