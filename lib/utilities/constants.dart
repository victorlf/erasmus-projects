import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

const Color kYellowGold = Color(0xFFAB9331);

final Future<FirebaseApp> kInitialization = Firebase.initializeApp();
FirebaseFirestore kFirebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth kAuth = FirebaseAuth.instance;

const kProgressCircle = CircularProgressIndicator(
  backgroundColor: Color(0xFFFFE0E0E0),
  strokeWidth: 10.0,
);
