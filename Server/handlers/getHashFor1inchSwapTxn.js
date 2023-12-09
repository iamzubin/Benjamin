const ethers = require('ethers');
const { GNOSIS_ABI } = require('../constants/GNOSIS_ABI');
const { getUser } = require('../controllers/database.controller');
const { calculateNonce } = require('../utils/calculateNonce');
require('dotenv').config();

const RPC_URL = process.env.RPC_URL;
const provider = new ethers.JsonRpcProvider(RPC_URL);



// Initialize signers

const owner1Signer = new ethers.Wallet(
  process.env.OWNER_1_PRIVATE_KEY,
  provider
);

const getTrxnData = async (params) => {
  // Fetch Stuff
  const url = `https://api.1inch.dev/swap/v5.2/8453/swap`


  console.log(
    'params : ',
    params
  );

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




const getHashForTxn = async (txn) => {
  const contractAddress = (await getUser(txn.owner)).safeAddress;
  const _1inchData = await getTrxnData({ ...txn, contractAddress: contractAddress });

  try {
  const gnosisContract = new ethers.Contract(
    contractAddress,
    GNOSIS_ABI,
    owner1Signer
  );


  const nonce = calculateNonce(txn.owner);

  txnHash = await gnosisContract.encodeTransactionData(
    _1inchData.tx.to,
    _1inchData.tx.value,
    _1inchData.tx.data,
    0,
    _1inchData.tx.gas,
    105000,
    _1inchData.tx.gasPrice,
    "0x0000000000000000000000000000000000000000",
    "0x0000000000000000000000000000000000000000",
    nonce
  );

  console.log('txnHash : ', txnHash);

  return txnHash;
  } catch (error) {
    throw 'something went wrong! ' + error;
  }
};

exports.getHashForTxn = (req, res) => {
  getHashForTxn(req.body)
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
