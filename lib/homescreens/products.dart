


import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import '../supporting.dart';



class Products extends StatefulWidget{
  var companydetails;
  Products({required this.companydetails});
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
 TextEditingController search_controller=new TextEditingController();
 var search='';

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
   return Scaffold(
     backgroundColor: Colors.white,
     appBar:   PreferredSize(
       preferredSize: Size(30,30),
       child:   MyAppBar(),),
     body: Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             Container(
                 decoration: BoxDecoration(
                     color: Colors.lightGreen,
                     shape: BoxShape.circle
                 ),
                 child: IconButton(onPressed: (){
                   Navigator.of(context).pop();
                 }, icon: Icon(Icons.arrow_back,color: Colors.white,))),
             SizedBox(width: 350,),
           SizedBox(width: 40,),

             Container(
                 width: size.width*0.27,
                 child: TextField(
                   onChanged: (a){
                     setState(() {
                       search_controller.text==null ? search='':search=search_controller.text;
                     });
                   },
                   controller: search_controller,
                   decoration: InputDecoration(
                       contentPadding: EdgeInsets.zero,
                       hintText: ' Search',
                       border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                       enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                       suffixIcon: Container(
                         height: 45,
                         child: ElevatedButton(onPressed: (){},child: Text('Search',style: TextStyle(color: Colors.white),),),
                       )
                   ),
                 )),
             SizedBox(width: 450,) ,



         ],),



         Padding(
           padding: EdgeInsets.only(top: 30),
           child: StreamBuilder(
             stream: Firestore.instance.collection('products').where('companylicense',isEqualTo: widget.companydetails['license']).get().asStream(),
             builder: (context, snap) {
               if (!snap.hasData) {
                 return show_progress_indicator(border_color: Colors.lightGreen,);
               }

               var data = snap.data!.where((doc) {
                 return doc['productname'].toLowerCase().contains(search.toLowerCase());
               }).toList();


               return data.length == 0
                   ? Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text('\n \n \n \n \n \n \n \n \n \n \n \n \n'),
                   Icon(Icons.no_drinks,color: Colors.lightGreen,size: 45,),
                   Text('No Products ',style: TextStyle(fontWeight: FontWeight.w500),),
                 ],
               )
                   : Container(
                 height:size.height<810 ? size.height*0.83:size.height*0.88,
                 width: size.width*0.95,
                 child: GridView.builder(
                   itemCount: data.length,

                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: size.width>1300 ? 5:4,
                     childAspectRatio: size.width /size.width* 0.83,
                   ),
                   itemBuilder: (context, index)

                   {
                     var name,description;
                     '${data[index]!['productdescription']}'.length<40 ?
                     description ='${data[index]!['productdescription']}':
                     description='${data[index]!['productdescription']}'.substring(0,40)+'..';

                     '${data[index]!['productname']}'.length<20 ? name='${data[index]!['productname']}' : name='${data[index]!['productname']}'.substring(0,18)+'..';
                     return Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 9),
                       child: InkWell(
                         onTap: (){
                           Navigator.push(context, Myroute(View_Product(product: data[index],)));
                         },
                         child: Container(
                           decoration: BoxDecoration(
                               border: Border.all(color: Colors.black12)
                           ),
                           child: Wrap(
                             children: [
                               Padding(
                                 padding: EdgeInsets.all(8.0),
                                 child: Container(
                                   height: 230,
                                   width:300,
                                   child: Image.network('${data[index]!['image']}',fit: BoxFit.fill,),
                                 ),
                               ),
                               Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       '$name',
                                       style: TextStyle(fontWeight: FontWeight.bold),
                                     ),
                                     Text('$description'),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Text('${data[index]!['productprice']} R.s',style: TextStyle(color: Colors.lightGreen,fontSize: 17,fontWeight: FontWeight.w500),),
                                         SizedBox(width: 8.0),
                                         Text('( ${data[index]!['productquantity']} )',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500)),
                                       ],
                                     ),
                                     SizedBox(height: 8.0),
                                   Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                                           children: [
                                           Expanded(
                                             flex:1,
                                             child: Container(
                                               height:40,
                                               child: ElevatedButton(
                                                 child: Text('View',style: TextStyle(color: Colors.white),),
                                                 onPressed: () {
                                                   Navigator.push(context, Myroute(View_Product(product: data[index],)));
                                                 },
                                               ),
                                             ),
                                           ),
                                           Expanded(
                                             flex:1,
                                             child: Container(
                                               height:40,
                                               child: ElevatedButton(

                                                 style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                                                 child: Text('Delete',style: TextStyle(color: Colors.lightGreen),),
                                                 onPressed: () {
                                                   // Navigate to product details screen
                                                 },

                                               ),
                                             ),
                                           ),
                                         ],),


                                   ],
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                     );
                   },
                 ),
               );
             },
           ),
         )

       ],
     ),
   );
  }
}











class View_Product extends StatelessWidget{
  var product;

  View_Product({required this.product});

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(30, 30),
        child: MyAppBar(),
      ),
      body: ListView(
        children: [

               Stack(children: [
                 Container(
                   width: size.width,
                   height: size.height*0.6,
                   decoration: BoxDecoration(
                     image: DecorationImage(
                       image: NetworkImage(product['image']),
                       fit: BoxFit.cover,
                     ),
                     borderRadius: BorderRadius.circular(5),
                   ),
                 ),

                 Positioned(
                   top: 4,
                   child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle
                       ),
                       child: IconButton(onPressed: (){
                         Navigator.of(context).pop();
                       }, icon: Icon(Icons.arrow_back,))),
                 )
               ],),
                SizedBox(width: 20),
                // Product Details

                      Text(
                       '  ${ product['productname']}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '  ${ product['productdescription']}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Price: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\R.s ${product['productprice']}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Quantity: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${product['quantity']}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'Total Orders: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ],


      ),
    );
  }
}
