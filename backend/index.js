const express = require("express");
const { createClient } = require("@supabase/supabase-js");
require("dotenv").config();

const {
  getAssociatedTokenAddress,
  createAssociatedTokenAccount,
  TOKEN_2022_PROGRAM_ID,
  transferChecked,
  getOrCreateAssociatedTokenAccount,
  createTransferInstruction,
  createTransferCheckedInstruction,
} = require("@solana/spl-token");
const {
  Connection,
  clusterApiUrl,
  Keypair,
  PublicKey,
  LAMPORTS_PER_SOL,
  sendAndConfirmTransaction,
  Transaction,
} = require("@solana/web3.js");

const bs58 = require("bs58");

const fs = require("fs");

const app = express();
const port = process.env.PORT || 3000;

const mtd_transit_user_key = "3zLcuRvZzBmZMG7tXxBi9RQh7pJiiiGRLTyqLaP1NDrs";

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
);

app.use(express.json());

app.post("/login", async (req, res) => {
  console.log(req.body);

  const { data, error } = await supabase.auth.signInWithPassword({
    email: req.body.email,
    password: req.body.password,
  });

  console.log(data.user.id);

  let uData;
  let fError;

  if (data.user.id) {
    const { data: userData, error: filterError } = await supabase
      .from("user")
      .select("*")
      .eq("user_id", data.user.id);

    uData = userData;
    fError = filterError;

    console.log(userData);
  }

  console.log(uData);

  console.log(fError);

  return res.send(uData[0]).status(200);
});

app.post("/signin", async (req, res) => {
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");

  const userKeypair = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const tokenMintAddress = new PublicKey(
    "mntMNtZzNZDJvEZCJwBRxBKSurVGoWQK6gpr4qke4Ag"
  );

  const recepient = Keypair.generate();

  const associatedTokenAddress = await getOrCreateAssociatedTokenAccount(
    connection,
    userKeypair,
    tokenMintAddress,
    recepient.publicKey,
    true,
    "confirmed",
    undefined,
    TOKEN_2022_PROGRAM_ID
  );

  console.log("Secret key", bs58.encode(recepient.secretKey));

  console.log(associatedTokenAddress);

  console.log(associatedTokenAddress.address);

  return res.send({ msg: "hello" });
});

app.post("/transfer", async (req, res) => {
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");

  console.log("receiver");
  const info = await connection.getTokenAccountBalance(
    new PublicKey(mtd_transit_user_key)
  );

  console.log(info);

  const sourceKeypair = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const MTDKeyPair = Keypair.fromSecretKey(
    Uint8Array.from([
      42, 12, 247, 3, 53, 154, 3, 27, 138, 185, 184, 62, 58, 210, 217, 121, 98,
      124, 0, 160, 79, 64, 243, 110, 116, 106, 214, 204, 94, 133, 62, 251, 94,
      214, 82, 254, 158, 89, 222, 93, 97, 3, 168, 21, 26, 81, 132, 84, 213, 212,
      78, 41, 129, 207, 6, 47, 20, 27, 109, 71, 134, 41, 37, 89,
    ])
  );

  console.log("source");
  console.log(sourceKeypair.publicKey);
  const info2 = await connection.getTokenAccountBalance(
    sourceKeypair.publicKey
  );

  console.log(info2);

  const sourceTokenAccount = await getAssociatedTokenAddress(
    new PublicKey("mntMNtZzNZDJvEZCJwBRxBKSurVGoWQK6gpr4qke4Ag"),
    sourceKeypair.publicKey
  );

  const destinationTokenAccount = await getAssociatedTokenAddress(
    new PublicKey("mntMNtZzNZDJvEZCJwBRxBKSurVGoWQK6gpr4qke4Ag"),
    MTDKeyPair.publicKey
  );

  console.log("2");

  let txhash = await transferChecked(
    connection, // connection
    sourceKeypair, // payer
    sourceTokenAccount, // from (should be a token account)
    new PublicKey("mntMNtZzNZDJvEZCJwBRxBKSurVGoWQK6gpr4qke4Ag"), // mint
    destinationTokenAccount, // to (should be a token account)
    sourceKeypair, // from's owner
    1000000000, // amount, if your decimals is 8, send 10^8 for 1 token
    9, // decimals
    [],
    undefined,
    TOKEN_2022_PROGRAM_ID
  );

  console.log(`txhash: ${txhash}`);

  return res.send({ msg: "hello" });
});

app.get("/transfer2", async (req, res) => {
  console.log(req.query);
  const wallet_add = req.query.wallet;
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");

  const wallet = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const getATA = async (mintAddress) => {
    return await getOrCreateAssociatedTokenAccount(
      connection,
      wallet, // Payer
      new PublicKey(mintAddress), // Token Mint Address
      wallet.publicKey, // Owner (your wallet)
      true,
      "confirmed",
      undefined,
      TOKEN_2022_PROGRAM_ID
    );
  };

  const sendToken = async (mintAddress, recipientAddress, amount) => {
    const senderATA = await getATA(mintAddress);
    const recipientATA = await getOrCreateAssociatedTokenAccount(
      connection,
      wallet,
      new PublicKey(mintAddress),
      new PublicKey(recipientAddress),
      true,
      "confirmed",
      undefined,
      TOKEN_2022_PROGRAM_ID
    );

    console.log(senderATA);
    console.log(recipientATA.address);

    const transaction = new Transaction().add(
      createTransferInstruction(
        senderATA.address,
        recipientATA.address,
        wallet.publicKey,
        amount * 10 ** 9, // Adjust for token decimals
        [],
        TOKEN_2022_PROGRAM_ID
      )
    );

    const signature = await sendAndConfirmTransaction(connection, transaction, [
      wallet,
    ]);
    console.log("Token Transfer Signature:", signature);
  };

  sendToken(process.env.MINT_ADD, wallet_add, 1); // Send 10 tokens

  return res.send({ msg: "hello" });
});

app.post("/get-balance", async (req, res) => {
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");
  // const info = await connection.getTokenAccountBalance(
  //   new PublicKey("Aeena3J5oyTqsxoGDjknzujp7imZCMKU4e1kamK6gg8P")
  // );

  const wallet = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const ata = await getOrCreateAssociatedTokenAccount(
    connection,
    wallet, // Payer
    new PublicKey(process.env.MINT_ADD), // Token Mint Address
    new PublicKey("3TbiRfHR1HhvjPsg4dFck3QxjcRS2hvD6nYybZ8DbkAc"), // Owner (your wallet)
    true,
    "confirmed",
    undefined,
    TOKEN_2022_PROGRAM_ID
  );

  const info = await connection.getTokenAccountBalance(
    new PublicKey(ata.address)
    //new PublicKey("C2R3bXJ3cB34DBCU8QoJS7QBo1BqNpbmyZ6aTY8TEiC1")
  );

  console.log(info);

  return res.send({ balance: info.value.amount });
});

app.post("/home", async (req, res) => {
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");
  // const info = await connection.getTokenAccountBalance(
  //   new PublicKey("Aeena3J5oyTqsxoGDjknzujp7imZCMKU4e1kamK6gg8P")
  // );

  const wallet = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const ata = await getOrCreateAssociatedTokenAccount(
    connection,
    wallet, // Payer
    new PublicKey(process.env.MINT_ADD), // Token Mint Address
    new PublicKey(req.body.wallet), // Owner (your wallet)
    true,
    "confirmed",
    undefined,
    TOKEN_2022_PROGRAM_ID
  );

  const { data, error } = await supabase
    .from("user")
    .select("*")
    .eq("ata_acc_add", req.body.wallet);

  console.log(data);

  const info = await connection.getTokenAccountBalance(
    new PublicKey(ata.address)
    //new PublicKey("C2R3bXJ3cB34DBCU8QoJS7QBo1BqNpbmyZ6aTY8TEiC1")
  );

  console.log(info);

  return res.send({ balance: info.value.amount, user: data[0] });
});

app.get("/transit-pay", async (req, res) => {
  console.log(req.query);
  const wallet_add = req.query.wallet;
  const connection = new Connection(clusterApiUrl("devnet"), "confirmed");

  const wallet = Keypair.fromSecretKey(
    Uint8Array.from([
      68, 58, 163, 119, 27, 109, 120, 108, 155, 123, 116, 171, 217, 227, 216,
      213, 83, 26, 65, 247, 219, 112, 128, 247, 163, 23, 208, 194, 62, 83, 25,
      154, 8, 234, 191, 118, 83, 84, 255, 13, 66, 149, 167, 188, 248, 227, 54,
      204, 127, 128, 188, 9, 114, 30, 250, 1, 101, 105, 102, 248, 40, 252, 27,
      141,
    ])
  );

  const getATA = async (mintAddress) => {
    return await getOrCreateAssociatedTokenAccount(
      connection,
      wallet, // Payer
      new PublicKey(mintAddress), // Token Mint Address
      wallet.publicKey, // Owner (your wallet)
      true,
      "confirmed",
      undefined,
      TOKEN_2022_PROGRAM_ID
    );
  };

  const sendToken = async (mintAddress, recipientAddress, amount) => {
    const senderATA = await getATA(mintAddress);
    const recipientATA = await getOrCreateAssociatedTokenAccount(
      connection,
      wallet,
      new PublicKey(mintAddress),
      new PublicKey(recipientAddress),
      true,
      "confirmed",
      undefined,
      TOKEN_2022_PROGRAM_ID
    );

    console.log(senderATA);
    console.log(recipientATA.address);

    const transaction = new Transaction().add(
      createTransferInstruction(
        senderATA.address,
        recipientATA.address,
        wallet.publicKey,
        amount * 10 ** 9, // Adjust for token decimals
        [],
        TOKEN_2022_PROGRAM_ID
      )
    );

    const signature = await sendAndConfirmTransaction(connection, transaction, [
      wallet,
    ]);
    console.log("Token Transfer Signature:", signature);
  };

  sendToken(process.env.MINT_ADD, wallet_add, 8); // Send 10 tokens

  const query = await supabase
    .from("user")
    .update({ cash: parseInt(req.query.cash) - 8 })
    .eq("ata_acc_add", wallet_add);

  const insertQuery = await supabase
    .from("rides")
    .insert({ start: "Transit Plaza", stop: "Fox & State", coins: "8" });

  return res.send({ msg: "hello" });
});

app.get("/history", async (req, res) => {
  const wallet = req.query.wallet;
  const { data, error } = await supabase.from("rides").select();

  console.log(data);

  return res.send({ data });
});

app.listen(port);
