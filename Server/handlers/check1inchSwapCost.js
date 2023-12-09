const ethers = require('ethers');
const { GNOSIS_ABI } = require('../constants/GNOSIS_ABI');
const { getUser } = require('../controllers/database.controller');
const { calculateNonce } = require('../utils/calculateNonce');
require('dotenv').config();

const check1inchSwapCost = async (params) => {
    // Fetch Stuff
    const url = `https://api.1inch.dev/swap/v5.2/8453/quote`
  
  
  
    const config = {
      headers: {
        "Authorization": "Bearer wKc3SQDi1GNsHE8dWW6IfreI5DKe0dhK"
      },
      params: {
        src: params.src,
        dst: params.dst,
        amount: params.amount,
        from: params.contractAddress,
        slippage: "3"
      }
    };
  
    const queryParams = new URLSearchParams(config.params).toString();
    const fullUrl = queryParams ? `${url}?${queryParams}` : url;
  
    try {
      const response = await fetch(fullUrl, {
        method: 'GET',
        headers: {
          ...config.headers,
        },
      });
  
      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
  
      const tokenBalances = await response.json();
      for (let key in tokenBalances) {
        if (tokenBalances[key] === '0') {
          delete tokenBalances[key];
        }
      }
      return tokenBalances;
    } catch (error) {
      console.error(error);
    }
  };
  




exports.check1inchSwapCost = (req, res) => {
    check1inchSwapCost(req.body)
    .then((txnHash) => {
      res.send({
        txnHash: txnHash,
      });
    })
    .catch((err) => {
      console.log(err);
      res.send({
        Error: 'something went wrong!',
      });
    });
};
