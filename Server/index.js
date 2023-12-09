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

app.listen(3000, () => console.log('Example app is listening on port 3000.'));
