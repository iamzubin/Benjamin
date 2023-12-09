const ethers = require('ethers');
const { GNOSIS_ABI } = require('../constants/GNOSIS_ABI');
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
  try {
    const gnosisContract = new ethers.Contract(
      '0x3E5c63644E683549055b9Be8653de26E0B4CD36E',
      GNOSIS_ABI,
      owner1Signer
    );
    txnHash = await gnosisContract.encodeTransactionData(
      txn.to,
      txn.value,
      txn.data,
      txn.operation,
      txn.safeTxGas,
      txn.baseGas,
      txn.gasPrice,
      txn.gasToken,
      txn.refundReceiver,
      txn.nonce
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
