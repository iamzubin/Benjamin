const express = require('express');
const { createAccount } = require('./handlers/CreateAccount');
const { getHashForTxn } = require('./handlers/GetHashForTxn');
const { home } = require('./handlers/Home');
const {
  getTokenBalancesForWallet,
} = require('./handlers/GetTokenBalancesForWallet');
require('dotenv').config();

const app = express();

app.use((req, res, next) => {
  console.log('Time: ', Date.now());
  next();
});

app.get('/', home);
app.post('/createAccount', createAccount);
app.post('/getHashForTxn', getHashForTxn);
app.post('/getTokenBalancesForWallet', getTokenBalancesForWallet);

// total balance, daily gain/loss,
// coin we own, price history [30], current price, daily gain/loss, max supply, fully diluted market cap, ATH, ATL
// transactions of user and coin, 
// list of 12 coins

// buy sell api calls
// send push notification
// YEILD (???)


app.listen(3000, () => console.log('Example app is listening on port 3000.'));
