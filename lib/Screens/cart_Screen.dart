import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Models/cart_Model.dart';
import '../constants.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(
          Icons.arrow_back,
          color: kPrimaryColor,
          size: 28,
        )),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListView.builder(
          itemCount: cart.cartItems.length,
          itemBuilder: (ctx, index) {
            final cartItem = cart.cartItems[index];
            return ListTile(
               leading: Image.asset(cartItem.book.image, fit: BoxFit.fitWidth),
              title: Text(cartItem.book.title,
                style: GoogleFonts.catamaran(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.book.author.fullname,
                    style: GoogleFonts.catamaran(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text('Quantity: ${cartItem.quantity}',
                    style: GoogleFonts.catamaran(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),),

                ],
              ),
              trailing: Text('\$ ${(cartItem.book.price * cartItem.quantity).toStringAsFixed(2)}',
                style: GoogleFonts.catamaran(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
              onTap: () {
                cart.removeFromCart(cartItem);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 8,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
        ),
          child: Center(
            child: Text(
              'Total:     \$${cart.getTotalPrice().toStringAsFixed(2)}  ',
              style: GoogleFonts.catamaran(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
    );
  }
}