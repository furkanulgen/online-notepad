import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

var pageColor = Color(0xff00ABB3);
var page2Color = Color(0xff3C4048);
var page3Color = Color(0xffB2B2B2);
var page4Color = Colors.grey[300]; //Color(0xffEAEAEA)

var dbHost = 'furkanulgen.dev';
var dbPort = 3306;
var dbName = '*';
var dbUser = "*";
var dbPassword = "*";

var dbConnection = ConnectionSettings(
    host: dbHost, port: dbPort, user: dbUser, password: dbPassword, db: dbName);
