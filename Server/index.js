const express = require('express');
const { createAccount } = require('./handlers/CreateAccount');
const { getHashFor1inchSwapTxn } = require('./handlers/getHashFor1inchSwapTxn');
const { home } = require('./handlers/Home');
const {
  getTokenBalancesForWallet,
} = require('./handlers/GetTokenBalancesForWallet');
const { check1inchSwapCost } = require('./handlers/check1inchSwapCost');



require('dotenv').config();

const app = express();

app.use((req, res, next) => {
  console.log('Time: ', Date.now());
  next();
});

app.get('/', home);

app.use(express.json())

app.post('/createAccount', createAccount);
app.post('/check1inchSwapCost', check1inchSwapCost);
app.post('/getHashFor1inchSwapTxn', getHashFor1inchSwapTxn);
app.post('/getTokenBalancesForWallet', getTokenBalancesForWallet);


// total balance, daily gain/loss,
  // https://portal.1inch.dev/documentation/portfolio/quick-start
// coin we own, price history [30], current price, daily gain/loss, max supply, fully diluted market cap, ATH, ATL

// transactions of user and coin, 
  // https://portal.1inch.dev/documentation/history/swagger?method=get&path=%2Fv2.0%2Fhistory%2F%7Baddress%7D%2Fevents - for user trxn history
// list of 12 coins

// buy sell api calls
// send push notification
// YEILD (???)



// total balance, daily gain/loss,
  // https://portal.1inch.dev/documentation/portfolio/quick-start
// coin we own, price history [30], current price, daily gain/loss, max supply, fully diluted market cap, ATH, ATL

// transactions of user and coin, 
  // https://portal.1inch.dev/documentation/history/swagger?method=get&path=%2Fv2.0%2Fhistory%2F%7Baddress%7D%2Fevents - for user trxn history
// list of 12 coins

// buy sell api calls
// send push notification
// YEILD (???)


app.listen(3000, () => console.log('Example app is listening on port 3000.'));
