import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/instance_manager.dart';
import 'package:receipe/providers/allreceipe_providers.dart';
import 'package:receipe/providers/receipe_providers.dart';
import 'package:get/get.dart';
import 'package:receipe/screens/web_widget.dart';
import 'package:receipe/models/category_model.dart';
import 'package:lottie/lottie.dart';

class main_screen extends StatelessWidget {
  final receipeController = TextEditingController();
  late String value;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu),
                SizedBox(width: 10),
                Text('Food Recipes'),
              ],
            ),
          ),
          body: SafeArea(
            child: OfflineBuilder(
                builder: (context) => Text(''),
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  if (connectivity == ConnectivityResult.none) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/images/wifi.json'),
                          Text(
                            "WIFI ON Gar Bsdk",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Consumer(builder: ((context, ref, child) {
                    final cats = ref.watch(catergoryProvider);
                    final rec = ref.watch(allreceipeProvider);
                    return Container(
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 280,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: TextFormField(
                                      controller: receipeController,
                                      onFieldSubmitted: (val) {
                                        ref
                                            .read(catergoryProvider.notifier)
                                            .searchCategory(val);
                                        receipeController.clear();
                                      },
                                      style: TextStyle(),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Search Receipe',
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      value = receipeController.text;
                                      ref
                                          .watch(catergoryProvider.notifier)
                                          .searchCategory(value);
                                    },
                                    icon: Icon(
                                      Icons.search,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                          cats.isEmpty
                              ? Center(
                                  child: LinearProgressIndicator(
                                  color: Colors.amber,
                                ))
                              : Card(
                                  color: Colors.black87,
                                  child: Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cats.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: ((context, index) {
                                          final cat = cats[index];

                                          return receipeController.text.isEmpty
                                              ? Container(
                                                  child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ButtonTheme(
                                                      minWidth: 10,
                                                      height: 80,
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(Color
                                                                        .fromARGB(
                                                                            255,
                                                                            248,
                                                                            250,
                                                                            250)),
                                                          ),
                                                          onPressed: () {
                                                            ref
                                                                .watch(
                                                                    allreceipeProvider
                                                                        .notifier)
                                                                .selectedRecipe(
                                                                    cat.categories);
                                                          },
                                                          child: Text(
                                                            cat.categories,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black87),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    )
                                                  ],
                                                ))
                                              : receipeController.text
                                                          .toLowerCase() ==
                                                      cat.categories
                                                          .toLowerCase()
                                                  ? ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Color
                                                                    .fromARGB(
                                                                        255,
                                                                        248,
                                                                        250,
                                                                        250)),
                                                      ),
                                                      onPressed: () {
                                                        ref
                                                            .watch(
                                                                allreceipeProvider
                                                                    .notifier)
                                                            .selectedRecipe(
                                                                cat.categories);
                                                      },
                                                      child:
                                                          Text(cat.categories))
                                                  : Text('');
                                        }),
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                              child: rec.isEmpty
                                  ? Center(
                                      child: Lottie.network(
                                          'https://assets6.lottiefiles.com/packages/lf20_6yhhrbk6.json'))
                                  : ListView.builder(
                                      itemCount: rec.length,
                                      itemBuilder: (context, index) {
                                        final re = rec[index];
                                        // return InkWell(
                                        //   onTap: (() {
                                        //     Get.to(() => WebViewWidget(re.url),
                                        //         transition: Transition.fadeIn);
                                        //   }),
                                        //   child: Card(
                                        //     child: Container(
                                        //       child: Padding(
                                        //         padding: const EdgeInsets.all(10.0),
                                        //         child: Column(
                                        //           children: [
                                        //             Container(
                                        //                 width: 170,
                                        //                 height: 190,
                                        //                 child: ClipRRect(
                                        //                   borderRadius:
                                        //                       BorderRadius.circular(10),
                                        //                   child: CachedNetworkImage(
                                        //                     imageUrl: re.image_url!,
                                        //                     errorWidget:
                                        //                         (context, url, error) {
                                        //                       return Image.asset(
                                        //                           "assets/images/noimage.jpg");
                                        //                     },
                                        //                     fit: BoxFit.fill,
                                        //                   ),
                                        //                 )),
                                        //             SizedBox(
                                        //               height: 3,
                                        //             ),
                                        //             Text(
                                        //               '${re.title}',
                                        //               style: TextStyle(
                                        //                   fontWeight: FontWeight.bold),
                                        //             ),
                                        //             SizedBox(
                                        //               height: 3,
                                        //             ),
                                        //             Text(
                                        //               '${re.category}',
                                        //               style: TextStyle(
                                        //                 fontSize: 10,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // );
                                        return InkWell(
                                          onTap: (() {
                                            Get.to(() => WebViewWidget(re.url),
                                                transition: Transition.fadeIn);
                                          }),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 22, vertical: 10),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 180,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.6),
                                                  offset: Offset(
                                                    0.0,
                                                    10.0,
                                                  ),
                                                  blurRadius: 10.0,
                                                  spreadRadius: -6.0,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                  Colors.black
                                                      .withOpacity(0.35),
                                                  BlendMode.multiply,
                                                ),
                                                image:
                                                    NetworkImage(re.image_url),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Align(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5.0),
                                                    child: Text(
                                                      re.title,
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                ),
                                                Align(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Row(
                                                          children: [],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black
                                                              .withOpacity(0.4),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.category,
                                                              color:
                                                                  Colors.yellow,
                                                              size: 18,
                                                            ),
                                                            SizedBox(width: 7),
                                                            Text(re.category),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }))
                        ],
                      ),
                    );
                  }));
                }),
          )),
    );
  }
}
