import 'dart:convert';

import 'package:MomNom/etc/errorHandler.dart';
import 'package:MomNom/etc/urlEndpoint.dart';
import 'package:MomNom/etc/utils.dart';
import 'package:MomNom/model/base.dart';
import 'package:MomNom/model/checkUpdate.dart';
import 'package:MomNom/model/exceptions.dart';
import 'package:MomNom/model/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../etc/requestHandler.dart';
import '../etc/styles.dart';
import '../components/textfield.dart';
import '../components/button.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class InitialPage extends StatefulWidget implements PageRouteProperty {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();

  @override
  static final String routeName = "/initial";
}

class _InitialPageState extends State<InitialPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );
  late Future<BaseResponse<CheckUpdateResponse>> requestedData;
  Key _refreshKeyVersionCheck = UniqueKey();
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
    Navigator.pushReplacementNamed(
        context,
        "/dashboard"
    );
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<BaseResponse<CheckUpdateResponse>> requestData() async {
    try {
      var info = await _initPackageInfo();
      BaseResponse<CheckUpdateResponse> response = BaseResponse.fromJson(
        await RequestHandler.sendRequest(
          url: URLEndpoint.checkUpdate,
          useAuth: true,
          item: CheckUpdateRequest(version: info.version)
        ),
            (json) =>
        (CheckUpdateResponse.fromJson(json as Map<String, dynamic>)),
      );

      if(response.data!.isUpToDate == false){
        var resp = response.data;
        showDialog(context: context,builder: (context) {
          return AlertDialog(
            title:  Text('New Update! (${resp?.versionString})'),
            content: Text('Changelog:\n${resp?.changelogs}\nUpdates are required to make sure the app works properly, update the app now?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  setState(() {
                    _launched = _launchInBrowser(Uri.parse(
                      resp?.downloadLink ?? "https://github.com/Jasson9/MomNom-FrontEnd/releases"
                    ));
                  });
                  // Navigator.pushReplacementNamed(
                  //     context,
                  //     "/dashboard"
                  // );
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context,
                      "/dashboard"
                  );// Return true
                },
                child: const Text('No'),
              ),
            ],
          );
        },);
      }else{
        Navigator.pushReplacementNamed(
          context,
          "/dashboard"
        );
      }


      return response;
    } catch (ex) {
      throw customErrorHandler(ex, context);
    }
  }

  Future<PackageInfo> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
    return info;
  }

  @override
  void initState() {
    super.initState();
    requestedData = requestData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: CustomColor.primaryDark,
      body: Column(
        children: [
          FutureBuilder<BaseResponse<CheckUpdateResponse>>(
            future: requestedData,
            key: _refreshKeyVersionCheck,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorWidget(snapshot, () {
                  requestedData = requestData();
                  setState(() {});
                });
              }

              if (snapshot.hasData) {
                if(snapshot.data?.data == null){
                  return errorWidget(snapshot, () {
                    requestedData = requestData();
                    setState(() {});
                  });
                }
              }

              return Center(child: const CircularProgressIndicator());
            },
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus)
        ],
      )
    );
  }
}
