import 'dart:convert';

import 'package:http/http.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class z {
  Future<void> zz(String uid, Map<String, dynamic> data) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    await collectionReference.doc(uid).set(data, SetOptions(merge: true));
  }

  Future<Map<String, dynamic>> zzz(String uid) async {
    Map<String, dynamic> data = {};
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    await collectionReference
        .doc(uid)
        .get()
        .then((value) => data = value.data());
    return data;
  }

  Future<String> zzzz(Map<String, dynamic> userMap) async {
    String id;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Ads');
    await collectionReference.add(userMap).then((value) {
      id = value.id;
    });
    return id;
  }

  void zzzzz(String adId, String name) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Ads");

    collectionReference.doc(adId).update({
      'ImagesName': FieldValue.arrayUnion([name])
    });
  }

  Future zzzzzz(File image, String adID, String picLabel) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = storage.ref().child(adID).child(picLabel);
    try {
      ref.putFile(image);
    } on FirebaseException catch (e) {}
  }

  void zzzzzzz(String uid, String adId) {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['adID'] = adId;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(uid);
    collectionReference.doc(adId).set(data);
  }

  Future<List<String>> zzzzzzzz(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(uid);
    List<String> ads = new List<String>();

    await collectionReference.get().then((value) {
      value.docs.every((element) {
        ads.add(element.data()['adID']);
        return true;
      });
    });
    return ads;
  }

  Future<List<Map<String, dynamic>>> zzzzzzzzz(List<String> adsList) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Ads");
    List<Map<String, dynamic>> adsData = new List<Map<String, dynamic>>();

    for (int i = 0; i < adsList.length; i++) {
      await collectionReference.doc(adsList[i]).get().then((value) {
        adsData.add(value.data());
        adsData[adsData.length - 1]['Ad ID'] = adsList[i];
      });
    }
    return adsData;
  }

  void zzzzzzzzzzzzzz(String userID, String adID) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(userID);
    collectionReference.doc(adID).delete();
  }

  void zzzzzzzzzzzzz(String adID) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("Ads");
    collectionReference.doc(adID).delete();
  }

  void zzzzzzzzzzzz(String adID, int numberOfImages) {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref;
    for (int i = 0; i < numberOfImages; i++) {
      ref = storage.ref().child(adID).child("image" + i.toString());
      ref.delete();
    }
  }

  Future<List<String>> zzzzzzzzzzz() async {
    List<String> data = new List<String>();
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Owner');
    await collectionReference.doc("owner").get().then((value) {
      List.from(value.data()['token']).forEach((element) {
        data.add(element);
      });
    });
    print(data);
    return data;
  }

  void zzzzzzzzzz(String token) async {
    try {
      var url = 'https://fcm.googleapis.com/fcm/send';
      var header = {
        "Content-Type": "application/json",
        "Authorization":
            "key=AAAAL3Gpq6A:APA91bHd9G5OF-SdowgKz0geevWpovwPe3rxdU31hzFBX3JH6hNf27Vicfh4mZEBmT3Wq7jpqL9cnj1qIkveCqZEHb4hlaeXQZhVQbHzD8EK6kX1QpI1yt9ZXnaa8sKpacSCUOEKweHJ",
      };
      var request = {
        'notification': {
          'title': "neue Anzeige platziert",
          'body': "Tippen Sie hier, um neue Anzeigen anzuzeigen"
        },
        'data': {
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'type': 'COMMENT'
        },
        'to': token
      };

      var client = new Client();

      await client.post(url, headers: header, body: json.encode(request));
    } catch (e, s) {
      print(e);
    }
  }
}
