const ethers = require('ethers');
const { EthersAdapter } = require('@safe-global/protocol-kit');
const { SafeFactory } = require('@safe-global/protocol-kit');
const { addUser } = require('../controllers/database.controller');
require('dotenv').config();

const RPC_URL = process.env.RPC_URL;
const provider = new ethers.JsonRpcProvider(RPC_URL);
// Initialize signers

const owner1Signer = new ethers.Wallet(
  process.env.OWNER_1_PRIVATE_KEY,
  provider
);

// dotenv.config()

const create = async (owner) => {
  try {

    const safeAccountConfig = {
      owners: [owner],
      threshold: 1,
    };
    const ethAdapterOwner1 = new EthersAdapter({
      ethers,
      signerOrProvider: owner1Signer,
    });
    const safeFactory = await SafeFactory.create({
      ethAdapter: ethAdapterOwner1,
    });
    const safeSdkOwner1 = await safeFactory.deploySafe({ safeAccountConfig });
    const safeAddress = await safeSdkOwner1.getAddress();
    await addUser(owner, safeAddress);
    return safeAddress;
  } catch (err) {
    console.log(err);
  };
}
exports.createAccount = (req, res) => {
  create(req.query.userAddress)
    .then((safeAddress) => {
      res.send({
        safeAddress: safeAddress,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(400).send({
        message: err.message || 'Some error occurred while creating the Safe.',
        wallet :req.query.userAddress
      });
    });
};
