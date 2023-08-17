import 'package:busapp/main.dart';
import 'package:flutter/material.dart';
import 'package:busapp/apis/api.dart';
import 'package:busapp/result/arival_popup.dart';
import 'package:busapp/result/error_report.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Result_view extends StatefulWidget {
  Result_view({super.key, this.displayId, this.station_name, this.station_id,this.station_info});
  final displayId;
  final station_name;
  final station_id;
  final station_info;

  @override
  State<Result_view> createState() => _Result_viewState();
}

class _Result_viewState extends State<Result_view> {

  var colors;
  var storage;
  var result;
  var lineName;
  var datas;
  Map<String,String> data = {};

  flutterToast(String a) {
    Fluttertoast.showToast(
        msg: "이 버스는 ${a} 입니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15.0
    );
  }

  getColor(String color){
    if(color == "직행좌석형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "좌석형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139893877604618260/green_bus.png?width=460&height=460");
    }else if(color == "일반형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "광역급행형시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "마을버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884388683886623/green_bus.png?width=460&height=460");
    }else if(color == "따복형 시내버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "직행좌석형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139884238708146236/green_bus.png?width=460&height=460");
    }else if(color == "좌석형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "일반형농어촌버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "일반형시외버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1116366006969962626/green_bus.png?width=432&height=432");
    }else if(color == "리무진형 공항버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }else if(color == "좌석형 공항버스"){
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }else{
      colors = Image.network("https://media.discordapp.net/attachments/905797523363483659/1139894619291799562/green_bus.png?width=460&height=460");
    }
    return colors;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.blueAccent,
            title: Text("정류장 검색 결과"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                margin: EdgeInsets.only(bottom: 5),
                height: 100,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text("${widget.station_name}", style: TextStyle(
                        fontSize: 20, color: Colors.white)),
                    Text("", style: TextStyle(
                        fontSize: 5, color: Colors.white)),
                    Text("${widget.station_id}", style: TextStyle(
                        fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height - 205,
                child: FutureBuilder(
                  future: _fetch1(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }else{
                      return ListView.builder(
                          itemCount: widget.station_info.length,
                          itemBuilder: (c, i) {
                            return TextButton(
                              onPressed: () => setState(() => FlutterDialog(context,widget.station_info[i]['routeName'],widget.displayId,widget.station_info[i]['routeId'],widget.station_info[i]['staOrder'],widget.station_info[i]['routeTypeName'],widget.station_info[i]['regionName'])),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  margin: EdgeInsets.fromLTRB(
                                      10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(15),
                                          top: Radius.circular(15)),
                                      color: Colors.white,
                                      boxShadow:[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.7),
                                          blurRadius: 1.0,
                                          spreadRadius: 0.0,
                                          offset: const Offset(0,5),
                                        )
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 30),
                                          child: InkWell(
                                            child: getColor(widget.station_info[i]['routeTypeName'].toString()),
                                            onTap: (){
                                              flutterToast(widget.station_info[i]['routeTypeName'].toString());
                                            },
                                          ),
                                      ),
                                      Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.only(top:8, right: 10),
                                                width: 200,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "",
                                                      style: TextStyle(color: Colors.black, fontSize: 2),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "${widget.station_info[i]['routeName']}번",
                                                      style: TextStyle(color: Colors.black, fontSize: 20),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      "${data['${widget.station_info[i]['routeId']}${widget.station_info[i]['staOrder']}']}방면",
                                                      style: TextStyle(color: Colors.black, fontSize: 15),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              )
                                            ],
                                          )
                                      ),
                                    ],
                                  )
                              ),
                            );
                          }
                      );
                    }
                  },
                )
              ),
            ]
        ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          error_reports(context);
        },
        icon: Icon(Icons.message),
        backgroundColor: Colors.red,
        label: Text('오류신고'),
      ),
    );
  }
  Future<String> _fetch1() async {
    widget.station_info.forEach((i) async{
      var a = await busRouteName(i['routeId']);
      var b = await turnBus(i['routeId']);
      if(int.parse(i['staOrder'])<=b){
        data.addAll(
            {"${i['routeId']}${i['staOrder']}": "${a['endStationName']}"});
      }else{
        data.addAll(
            {"${i['routeId']}${i['staOrder']}": "${a['startStationName']}"});
      }
    });
    await Future.delayed(Duration(seconds: 1));
    return 'Call Data';
  }
}