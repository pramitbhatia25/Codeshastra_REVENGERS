import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Client? httpsClient;
  Web3Client? ethClient;
  bool data = false;
  TextEditingController val = TextEditingController();
  int myamount = 1;
  final myaddress = "0x21Fb5976b2d5c21F3C15389Ec110283D42d58Cf2";
  var mydata;
  @override
  void initState() {
    super.initState();
    httpsClient = Client();
    ethClient = Web3Client(
        "https://kovan.infura.io/v3/9ce28d61467b44458cdd70c00ee54ae3",
        httpsClient!);
    getBalance(myaddress);
  }

  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xF4dc48141B5Abe74aD0986dbfD8C424da32575C4";
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Bank"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    print(ethFunction.outputs);
    final result = await ethClient!
        .call(contract: contract, function: ethFunction, params: []);
    print(result);
    return result;
  }

  Future<void> getBalance(String targetaddress) async {
    EthereumAddress address = EthereumAddress.fromHex(targetaddress);
    List<dynamic> result = await query("getBalance", []);
    mydata = result[0];
    data = true;
    setState(() {});
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "3ee7532b8f3acbbbd9b2ccf437ec76ed985360712c03d97ce1fa1e72378112c9");

    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);

    final result = await ethClient!.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: ethFunction, parameters: args),
        chainId: 42);

    return result;
  }

  Future<String> sendCoin() async {
    var Bigamount = BigInt.from(myamount);
    var response = await submit("deposit", [Bigamount]);
    print("Deposited");
    return response;
  }

  Future<String> withdrawCoin() async {
    var Bigamount = BigInt.from(myamount);
    var response = await submit("withdraw", [Bigamount]);
    print("withdrawn");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray300,
      body: SingleChildScrollView(
        child: ZStack([
          VxBox()
              .orange400
              .size(context.screenWidth, context.percentHeight * 30)
              .make(),
          VStack([
            (context.percentHeight * 10).heightBox,
            "\$ETHCOIN".text.xl4.white.bold.center.makeCentered().py16(),
            (context.percentHeight * 5).heightBox,
            VxBox(
                    child: VStack([
              "Balance".text.gray400.xl2.semiBold.makeCentered(),
              10.heightBox,
              data
                  ? "\$${mydata}".text.xl5.bold.makeCentered().shimmer()
                  : CircularProgressIndicator().centered()
            ]))
                .white
                .size(context.screenWidth, context.percentHeight * 20)
                .rounded
                .shadow3xl
                .make()
                .py16(),
            30.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                  keyboardType: TextInputType.number,
                  controller: val,
                  onChanged: (value) {
                    setState(() {
                      var a = val.text, myamount = int.parse(a) * 100;
                    });
                  },
                  decoration: InputDecoration(border: OutlineInputBorder())),
            ),
            HStack([
              FlatButton.icon(
                  onPressed: () => getBalance(myaddress),
                  color: Color.fromARGB(255, 27, 101, 161),
                  shape: Vx.roundedSm,
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.black,
                  ),
                  label: "Refresh".text.black.make()),
              FlatButton.icon(
                  onPressed: () => sendCoin(),
                  color: Colors.green,
                  shape: Vx.roundedSm,
                  icon: Icon(
                    Icons.call_made_outlined,
                    color: Colors.black,
                  ),
                  label: "Deposit".text.black.make()),
              FlatButton.icon(
                  onPressed: () => withdrawCoin,
                  color: Color.fromARGB(255, 27, 101, 161),
                  shape: Vx.roundedSm,
                  icon: Icon(
                    Icons.call_received_outlined,
                    color: Colors.black,
                  ),
                  label: "Withdraw".text.black.make())
            ])
          ])
        ]),
      ),
    );
  }
}
