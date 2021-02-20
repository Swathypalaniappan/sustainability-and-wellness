import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';


class Chatbot extends StatefulWidget {
  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {

  final messageController = TextEditingController();
  List<Map> messages = new List();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void response(query) async{
    AuthGoogle authGoogle = await AuthGoogle(
      fileJson: 'assets/chatbotservice.json'
    ).build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle,language:Language.english);
    AIResponse aiResponse = await dialogflow.detectIntent(query);
    setState((){
      messages.insert(0,{
          'data':0,
          'message':aiResponse.getListMessage()[0]['text']['text'][0].toString()
      });
    });
    print(aiResponse.getListMessage()[0]['text']['text'][0].toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        appBar:AppBar(
          title: Text('Chatbot'),
          centerTitle: true,
          leading:IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return HomePage(user:_auth.currentUser);
    }));
            },
          ),
        ),
        body:Container(
          decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purple, Colors.lightBlue, Colors.purple],
                    ),
                  ),
          child:Column(
            children:[
                Center(
                  child:Container(
                    padding: EdgeInsets.only(top:15,bottom:10),
                    child: Text('Today,${DateFormat('Hm').format(DateTime.now())}',style: TextStyle(color:Colors.white),),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context,index)=>chat(
                      messages[index]['message'].toString(),
                      messages[index]['data']
                    )
                  )
                ),
                Divider(
                  height: 5,
                  color:Colors.white,
                ),
                Container(
                  child:ListTile(
                    trailing:IconButton(
                      icon: Icon(Icons.send),
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: (){
                        if(messageController.text.isEmpty){
                          print('empty message');
                        }else{
                          setState((){
                            messages.insert(0, {'data':1,'message':messageController.text});
                          });
                          response(messageController.text);
                          messageController.clear();
                        }
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if(!currentFocus.hasPrimaryFocus){
                          currentFocus.unfocus();
                        }
                      },
                    ),
                    title:Container(
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(Radius.circular(15)),
                        color:Colors.white,
                      ),
                      padding: EdgeInsets.only(left:15),
                      child:TextFormField(
                        controller:messageController,
                        decoration:InputDecoration(
                          hintText:'Enter a message',
                          hintStyle: TextStyle(
                            color:Colors.black,
                          ),
                          border:InputBorder.none,

                        ),
                        style:TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),

                  ),
                ),
            ],
          ),
        ),
      ),
    );
 }
    Widget chat(String message,int data){
      return Container(
        padding:EdgeInsets.only(left:20,right:20),
        width:MediaQuery.of(context).size.width,
        child:Row(
          mainAxisAlignment: data == 1? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            // data == 0?Container(
            //   height: 60,
            //   width: 60,
            // ):Container(),

            Padding(
              padding: EdgeInsets.all(10),
              child: Bubble(
                radius: Radius.circular(15),
                color: data == 0? Colors.white:Colors.blueGrey,
                elevation: 5,
                child: Padding(padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width:10,),
                    Flexible(child: Container(
                      constraints:BoxConstraints(maxWidth:200),
                      child: Text(
                        message,
                        style: TextStyle(
                          color:Colors.black,fontWeight: FontWeight.bold
                        ),
                      ),
                    ))
                  ],
                ),
                ),
              ),
            ),

            // data == 1? Container(
            //   height: 60,
            //   width: 60,
            // ):Container(),
          ],
        ),
      );

  }
}