import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUser {
  String uid;
  String displayName;
  String photoUrl;
  String facebookUrl;
  String twitterUrl;
  String linkedinUrl;
  String instagramUrl;
  String city;
  Timestamp lastActivity;
  String coverPhotoUrl;
  String description;
  int numberOfFollowers;
  int numberOfFollowings;
  String get getDisplayName {
    return displayName;
  }

  ProfileUser(
      {this.uid,
      this.displayName,
      this.photoUrl,
      this.facebookUrl,
      this.twitterUrl,
      this.linkedinUrl,
      this.instagramUrl,
      this.city,
      this.lastActivity,
      this.coverPhotoUrl,
      this.description,
      this.numberOfFollowers,
      this.numberOfFollowings});

  factory ProfileUser.fromMap(Map data) {
    if (data == null) {
      return null;
    }
    ProfileUser profileUser = ProfileUser(
        uid: data['uid'],
        displayName: data['displayName'],
        photoUrl: data['photoUrl'],
        facebookUrl: data['facebookUrl'],
        twitterUrl: data['twitterUrl'],
        linkedinUrl: data['linkedinUrl'],
        instagramUrl: data['instagramUrl'],
        city: data['city'],
        lastActivity: data['lastActivity'],
        coverPhotoUrl: data['coverPhotoUrl'],
        description: data['description'],
        numberOfFollowers: data['numberOfFollowers'] ?? 0,
        numberOfFollowings: data['numberOfFollowings'] ?? 0);
    return profileUser;
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'displayName': this.displayName,
      'photoUrl': this.photoUrl,
      'facebookUrl': this.facebookUrl,
      'twitterUrl': this.twitterUrl,
      'linkedinUrl': this.linkedinUrl,
      'instagramUrl': this.instagramUrl,
      'city': this.city,
      'lastActivity': this.lastActivity,
      'coverPhotoUrl': this.coverPhotoUrl,
      'description': this.description,
      'numberOfFollowers': this.numberOfFollowers,
      'numberOfFollowings': this.numberOfFollowings
    };
  }

  ProfileUser.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
    facebookUrl = json['facebookUrl'];
    twitterUrl = json['twitterUrl'];
    linkedinUrl = json['linkedinUrl'];
    instagramUrl = json['instagramUrl'];
    city = json['city'];
    lastActivity = json['lastActivity'];
    coverPhotoUrl = json['coverPhotoUrl'];
    description = json['description'];
    numberOfFollowers = json['numberOfFollowers'] ?? 0;
    numberOfFollowings = json['numberOfFollowings'] ?? 0;
  }
}
