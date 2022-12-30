import 'package:flutter/material.dart';
import 'package:intro/utils/colors.dart';
import 'package:intro/utils/remote_services.dart';

import '../utils/post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData () async {
    posts = await RemoteService().getPost();
    if(posts != null){
      setState(() {
        isLoaded = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(title: Text('Discover'),backgroundColor: buttonColor,),
     body: Visibility(
       visible: isLoaded,
       replacement: const Center(child: CircularProgressIndicator(),),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: GridView.builder(
             itemCount: posts?.length,
           itemBuilder: (context, index) =>
               Stack(
                 children: [
                   SizedBox(
                     width: 200, height: 200,
                     child: Card(
                       color: Colors.white.withOpacity(0.5),
                       margin: EdgeInsets.zero,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: Column(
                         children: [
                           ClipRRect(
                             borderRadius: BorderRadius.circular(2),
                             child: Image.network(posts![index].image, fit: BoxFit.fill, width: 90, height: 90,),
                           ),
                          SizedBox(height: 10,),
                          Text(posts![index].title,
                             textAlign: TextAlign.center,
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(color: textColor, fontSize: 15),),
                           SizedBox(height: 8,),
                           Text(
                          'Price: \$${posts![index].price.toString()} ', style: TextStyle(color: buttonColor),)
                         ],
                       ),
                     ),
                   ),
                   Positioned(
                     right: -10,
                     top: -10,
                     child: IconButton(
                       onPressed: (){showDialog(context: context, builder: (context){
                         return AlertDialog(
                           backgroundColor: primaryColor.withOpacity(0.8),
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                           elevation: 16,
                           content: Wrap(
                             children: [
                               Column(
                                 children: [
                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(2),
                                     child: Image.network(posts![index].image, width: 200, height: 200, fit: BoxFit.fill,),
                                   ),
                                   SizedBox(height: 10,),
                                   Text(posts![index].title,
                                     textAlign: TextAlign.center,
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 15, fontWeight: FontWeight.bold),),
                                   SizedBox(height: 8,),
                                   Text(posts![index].description.toString() ,
                                     textAlign: TextAlign.center,
                                     maxLines: 5,
                                     overflow: TextOverflow.ellipsis,
                                     style: TextStyle(color: Colors.blueGrey, fontSize: 15),),
                                   SizedBox(height: 10,),
                                   Text('Price: \$${posts![index].price.toString()} ', style: TextStyle(color: buttonColor),),
                                 ],
                               ),
                             ],
                           ),
                         );
                       });
                       },
                       icon: Icon(Icons.info_rounded , color: buttonColor,),
                     ),
                   ),
                 ],
               ),
           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisSpacing: 20,
             mainAxisSpacing: 20,
             crossAxisCount: 2,
           ),
         ),
       ),
     ),
    );
  }
}