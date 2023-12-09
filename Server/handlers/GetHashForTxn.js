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

// dotenv.config()

const getHashForTxn = async (txn) => {
  const contractAddress = getUser(txn.owner).safeAddress;
  try {
    const gnosisContract = new ethers.Contract(
      contractAddress,
      GNOSIS_ABI,
      owner1Signer
    );
    

    const nonce = calculateNonce(txn.owner);

    txnHash = await gnosisContract.encodeTransactionData(
      txn.to,
      txn.value,
      txn.data,
      0,
      txn.safeTxGas || null, // 1inch
      105000,
      txn.gasPrice || null,// ""
      0x0000000000000000000000000000000000000000,
      0x0000000000000000000000000000000000000000,
      nonce
    );
    return txnHash;
  } catch (error) {
    throw 'something went wrong! ' + error;
  }
};

exports.getHashForTxn = (req, res) => {
  getHashForTxn(req.query)
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
