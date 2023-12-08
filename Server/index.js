const express = require('express');
const { createAccount } = require('./handlers/CreateAccount');
const { home } = require('./handlers/home');
require('dotenv').config()


const app = express();

app.use((req, res, next) => {
  console.log('Time: ', Date.now());
  next();
});

app.get('/', home);
app.post('/createAccount', createAccount)



app.listen(3000, () => console.log('Example app is listening on port 3000.'));