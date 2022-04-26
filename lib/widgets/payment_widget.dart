import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../bloc/bucket/bucket_bloc.dart';
import '../bloc/orders/order_bloc.dart';
import '../styles/text_styles.dart';
import '../views/order_failed.dart';
import '../views/order_success.dart';
import 'buttons/primary_buttons.dart';

enum CardType { master, visa, others, invalid }

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({Key? key, this.orderiD, this.sum, this.showSnackBar = false}) : super(key: key);

  final int? orderiD;

  final double? sum;

  final bool showSnackBar;

  CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (input.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  bool isValid = false;
  CardType type = CardType.others;
  final _formKey = GlobalKey<FormState>();
  var cardNumberMaskFormatter = MaskTextInputFormatter(
      mask: '  ####  ####  ####  ####', filter: {"#": RegExp(r'[0-9]')});
  var dateMaskFormatter =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  var cvvMaskFormatter =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});



  @override
  Widget build(BuildContext context) {
    
    return Material(
      color: Colors.transparent,
      child: BlocBuilder<BucketBloc, BucketState>(builder: (context, state) {
        if (state is BucketStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BucketStateSuccess) {
          double summary = state.bucket.isNotEmpty
              ? state.bucket
                  .map((e) => e.sailPrice ?? e.price)
                  .toList()
                  .reduce((a, b) => a + b)
              : 0.0;
          return Column(
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 31, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 65),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Номер карти',
                                        style: TextStyles.subTitleMobile1,
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        String v = cardNumberMaskFormatter
                                            .getUnmaskedText();
                                        return v.isNotEmpty && v.length == 16
                                            ? null
                                            : 'Введіть валідний номер картки';
                                      },
                                      inputFormatters: [cardNumberMaskFormatter],
                                      onChanged: (value) {
                                        setState(() {
                                          type = widget.getCardTypeFrmNumber(
                                              cardNumberMaskFormatter
                                                  .getUnmaskedText());
                                        });
                                      },
                                      cursorColor: Color(0xff030303),
                                      style: const TextStyle(
                                        color: Color(0xff181B19),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 40, left: 50, right: 20),
                                        hintText: 'Введіть номер карти',
                                        filled: true,
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        hintStyle: const TextStyle(
                                          color: Color(0xFFA5A5A5),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        fillColor: const Color(0xffF2F3F2),
                                        prefixIcon: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 5,
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            onTap: () {},
                                            child: Builder(builder: (context) {
                                              switch (type) {
                                                case CardType.invalid:
                                                  return Icon(
                                                    Icons.priority_high_outlined,
                                                    color: Colors.red,
                                                  );
                                                case CardType.visa:
                                                  return Image.asset(
                                                    'assets/images/visa.png',
                                                    width: 10,
                                                  );
                                                case CardType.master:
                                                  return Image.asset(
                                                    'assets/images/mastercard.png',
                                                    width: 10,
                                                  );
                                                default:
                                                  return Icon(
                                                    Icons.credit_card_outlined,
                                                    color: Color(0xff7C7C7C),
                                                  );
                                              }
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                ),
                                                child: Text(
                                                  'Expiration',
                                                  style:
                                                      TextStyles.subTitleMobile1,
                                                ),
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  String v = dateMaskFormatter
                                                      .getUnmaskedText();
                                                  return v.isNotEmpty &&
                                                          v.length == 4
                                                      ? null
                                                      : 'Введіть валідну дату';
                                                },
                                                inputFormatters: [
                                                  dateMaskFormatter
                                                ],
                                                cursorColor: Color(0xff030303),
                                                style: const TextStyle(
                                                  color: Color(0xff181B19),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      top: 40,
                                                      left: 20,
                                                      right: 20),
                                                  hintText: 'MM/YY',
                                                  filled: true,
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xFFA5A5A5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  fillColor:
                                                      const Color(0xffF2F3F2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 8.0,
                                                ),
                                                child: Text(
                                                  'CVV',
                                                  style:
                                                      TextStyles.subTitleMobile1,
                                                ),
                                              ),
                                              TextFormField(
                                                validator: (value) {
                                                  String v = cvvMaskFormatter
                                                      .getUnmaskedText();
                                                  return v.isNotEmpty &&
                                                          v.length == 3
                                                      ? null
                                                      : 'Введіть валідний CVV код';
                                                },
                                                inputFormatters: [
                                                  cvvMaskFormatter
                                                ],
                                                cursorColor: Color(0xff030303),
                                                style: const TextStyle(
                                                  color: Color(0xff181B19),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(
                                                      top: 40,
                                                      left: 20,
                                                      right: 20),
                                                  hintText: '111',
                                                  filled: true,
                                                  isDense: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide: const BorderSide(
                                                      width: 0,
                                                      style: BorderStyle.none,
                                                    ),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    color: Color(0xFFA5A5A5),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  fillColor:
                                                      const Color(0xffF2F3F2),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Інформація про замовлення",
                              maxLines: 2,
                              style: TextStyles.bucketPageInfoHeaderMobile,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Проміжна сума:",
                                  style: TextStyles.subTitleMobile1,
                                ),
                                Text(
                                  widget.orderiD == null 
                                  ? summary.toStringAsFixed(1) + "грн"
                                  : "${(widget.sum ?? 0.0).toStringAsFixed(2)} грн",
                                  style: TextStyles.orderCheckPrice,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Заощаджено за кодом:",
                                  style: TextStyles.subTitleMobile1,
                                ),
                                Text(
                                  "1 грн",
                                  style: TextStyles.orderCheckPrice,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ЗАГАЛЬНА СУМА",
                                style: TextStyles.bucketBoxPriceMobile,
                              ),
                              Text(
                                widget.orderiD == null 
                                  ? summary.toStringAsFixed(1) + "ГРН"
                                  : "${(widget.sum ?? 0.0).toStringAsFixed(2)} ГРН",
                                style: TextStyles.orderCheckPriceViolet,
                              )
                            ],
                          ),
                        ],
                      )
    
                    ],
                  )),
              BlocConsumer<OrderBloc, OrderState>(
                listener: (context, mainState) {
    
                if (mainState is OrderInitial) {
                } else if (mainState is OrderSuccess) {
                  if(isValid){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderSuccessPage()));
                  }
                 
                  
                } else {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OrderFailedPage()));
                }
              }, builder: (context, orderState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: SizedBox(
                      width: 340,
                      child: widget.orderiD == null ? PrimaryButtonWithPrice(
                        price: summary.toStringAsFixed(1),
                        title: 'Сплатити',
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isValid = true;
                            }); 
                            BlocProvider.of<BucketBloc>(context).add(BucketOnLogout());
                          
                            if(orderState is OrderSuccess){
                              BlocProvider.of<OrderBloc>(context).add(PayForOrder(
                                orderId: orderState.orderId,
                                cardNumber: cardNumberMaskFormatter.getUnmaskedText(),
                                cvv: cvvMaskFormatter.getUnmaskedText(),
                                date: dateMaskFormatter.getMaskedText(),
                              ));
                            }
                            
                            
                          }
                          else{
                            setState(() {
                              isValid = false;
                            }); 
                          }
                          
                        },
                      )
                      : PrimaryButton(onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isValid = true;
                            }); 
                            BlocProvider.of<BucketBloc>(context).add(BucketOnLogout());
                            BlocProvider.of<OrderBloc>(context).add(PayForOrder(
                              orderId: widget.orderiD ?? 0, 
                              cardNumber: cardNumberMaskFormatter.getUnmaskedText(),
                              cvv: cvvMaskFormatter.getUnmaskedText(),
                              date: dateMaskFormatter.getMaskedText(),
                            ));
                          
                           
                            
                          }
                          else{
                            setState(() {
                              isValid = false;
                            }); 
                          }
                          
                        },
                        title: 'Сплатити', 
                        buttonHeight: 56),
                    ),
                  ),
                );
              }),
            ],
          );
        } else {
          return Center(
            child: Text("Chechout problem"),
          );
        }
      }),
    );
  }
}
