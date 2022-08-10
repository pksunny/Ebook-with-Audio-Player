// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:ebook_with_audio_player_app/screens/app_tabs.dart';
import 'package:ebook_with_audio_player_app/screens/audio_player_screens/detailed_audio_screen.dart';
import 'package:ebook_with_audio_player_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    ReadData();

  }

  List popularBooks = [];
  List books = [];

  late ScrollController scrollController;
  late TabController tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.background,
          child: Column(
            children: [
              
              // 1st line search and notification
              Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.view_compact_rounded, size: 24,),

                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(Icons.search, size: 24,),
                        SizedBox(width: 10,),
                        Icon(Icons.notifications_active, size: 24,),
                      ],
                    )
                  ],
                ),
              ),
              // 2nd line popular books
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text('Popular Books', style: TextStyle(fontSize: 30),),
                  )
                ],
              ),
              // 3rd line books slider
              SizedBox(height: 20,),
              Container(
                  height: 180,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: 0,
                        left: -40,
                        child: Container(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks == null ? 0 : popularBooks.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    left: 10,
                                  ),
                                  height: 180,
                                  // width: MediaQuery.of(context).size.width*0.50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage(popularBooks[index]['img']))),
                                );
                              }),
                        ),
                      )
                    ],
                  )),
              //4th line menu button (new, popular, trending)
              Expanded(
                child: NestedScrollView(
                  controller: scrollController,
                  headerSliverBuilder: (context, bool isScroll) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: AppColors.sliverBackground,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20, left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TabBar(
                              indicatorPadding: EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: EdgeInsets.only(right: 10),
                              controller: tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.background,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  )
                                ]
                              ),
                              tabs: [
                               AppTabs(color: AppColors.menu1Color, text: 'New'),
                               AppTabs(color: AppColors.menu2Color, text: 'Popular'),
                               AppTabs(color: AppColors.menu3Color, text: 'Trending'),
                              ]
                              ),
                          ), 

                          
                        ),
                      )
                    ];
                  },
                  // music name, photo and rating
                  body: TabBarView(
                    controller: tabController,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      ListView.builder(
                        itemCount: books == null ? 0 : books.length,
                        itemBuilder: (_, i) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, 
                                MaterialPageRoute(builder: 
                                  (content) => DeatiledAudioScreen(booksData: books, index: i)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey.withOpacity(0.1)
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(books[i]['img'])
                                            )
                                        ),
                                      ),
                          
                                      // 4th line Rating
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star, size: 24,color: AppColors.starColor,),
                                              SizedBox(width: 5,),
                                              Text(books[i]['rating'],
                                                style: TextStyle(color: AppColors.menu2Color),  
                                              )
                                            ],
                                          ),
                          
                                          // 4th line music name
                                          Text(books[i]['title'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                          
                                          Text(books[i]['text'],
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.subTitleText),
                                          ),
                          
                                          Container(
                                            width: 60,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('Love',
                                              style: TextStyle(fontSize: 12, color: Colors.white),
                                            ),
                                          )
                          
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),

                       Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Popular Content'),
                        ),
                      ),

                       Material(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                          ),
                          title: Text('Trending Content'),
                        ),
                      ),
                    ],
                  )
                  ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}