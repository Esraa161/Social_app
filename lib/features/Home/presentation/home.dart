import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8,horizontal: 4),
      child: Column(
        children: [
         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
             alignment: Alignment.bottomCenter,
              children: [
                Card(
                  elevation: 5,
                  color: Colors.white,
                  surfaceTintColor: Colors.white,
                  shadowColor: Colors.grey,
                  child: Lottie.asset('assets/images/animation_lm7sa99z.json',
                      height: MediaQuery.of(context).size.height/4,
                  width: double.infinity),

                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Communicate with friendes",
                  style: TextStyle(color: Theme.of(context).primaryColor
                 // Color.fromARGB(202, 36, 30, 98)
                    ,),),
                ),
              ],
            ),
          ),*/
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: 20,
                itemBuilder: (context,index)
            {
             return Padding(
               padding: const EdgeInsets.symmetric(vertical: 8.0),
               child: Card(
                    color: Colors.white,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    surfaceTintColor: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    shadowColor: Colors.grey,
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:Color.fromRGBO(
                                    243, 159, 90, 1.0),
                                radius: 25,
                                backgroundImage: AssetImage("assets/images/User-Avatar-Profile3.png"),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Ahmed Mohamed",
                                          style: TextStyle(color: Theme.of(context).primaryColor),),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.blue,
                                          size:16,
                                        ),
                                      ],
                                    ),
                                    Text("January 21, 20203 at 10:00 pm",
                                      style: TextStyle(color: Colors.grey,
                                          fontSize: 11),)
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              IconButton(onPressed:(){

                              },
                                  icon: Icon(Icons.more_horiz,
                                    size: 16,
                                    color:Color.fromRGBO(
                                        243, 159, 90, 1.0),)),

                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Divider(
                              height: 1,
                              thickness: 0.5,
                            ),
                          ),
                          Text(";jjoo jojh bbbbbbbbbbbbbo'ho'hgohdo'ho'h;jn ln nlnlb vvvvjjjjp sofkmp;nmp;npppppppppppppppppsjuufjjojo.",
                            style: TextStyle(height:1.5,
                                fontSize: 12),),
                          InkWell(
                              onTap: (){
                                launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                              },
                              child: Text("https://docs.flutter.io/flutter/services/UrlLauncher-class.html",
                                style: TextStyle(color: Colors.blue,fontSize: 12),)),
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.network(
                              'https://img.freepik.com/premium-photo/beautiful-young-women-summer-fashion-concept_564719-215.jpg',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height/5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.favorite_border_outlined,color: Colors.redAccent,size: 15,),
                              ),
                              Text("1200",style: TextStyle(color: Colors.grey,fontSize: 11),),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(Icons.mode_comment_outlined,color: Colors.yellow,size: 15,),
                              ),
                              Text("200 comment",style: TextStyle(color: Colors.grey,fontSize: 11),),

                            ],
                          ),
                          Divider(height: 1,
                            thickness: 0.5,),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor:Colors.grey,
                                  radius: 15,
                                  backgroundImage: AssetImage("assets/images/User-Avatar-Profile2.png"),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text("Write a comment......",
                                    style: TextStyle(color: Colors.grey,
                                        fontSize: 11),),
                                ),

                                FavoriteButton(
                                  isFavorite: false,
                                  iconDisabledColor: Colors.grey,
                                  iconSize: 25,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                  },
                                ),
                                Text("Like",style: TextStyle(color: Colors.grey,
                                    fontSize: 11),),
                                SizedBox(
                                  width:8,
                                ),
                                Icon(Icons.share,color: Colors.green,size: 20,),
                                Text("Share",style: TextStyle(color: Colors.grey,
                                    fontSize: 11),)

                              ],
                            ),
                          )

                        ],
                      ),
                    )

                ),
             );
            }),
          )

        ],
      ),
    );
  }
}
