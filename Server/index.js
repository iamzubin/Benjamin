const express = require('express');
const { createAccount } = require('./handlers/CreateAccount');
const { getHashForTxn } = require('./handlers/GetHashForTxn');
const { getTokens } = require('./handlers/GetTokens');
const { getTokenData } = require('./handlers/GetTokenData');
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
app.get('/getTokens', getTokens);
app.get('/getTokenData', getTokenData);

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
