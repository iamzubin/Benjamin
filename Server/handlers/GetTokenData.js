require('dotenv').config();
const { CovalentClient } = require('@covalenthq/client-sdk');

BigInt.prototype.toJSON = function () {
  return this.toString();
};

const getTokenData = async (userAddress) => {
  try {
    const client = new CovalentClient(process.env.COVALENT_API_KEY);
    const tokenBalances =
      await client.BalanceService.getTokenBalancesForWalletAddress(
        'base-mainnet',
        userAddress
      );

    if (!tokenBalances) {
      throw new Error(`HTTP error! Status: ${response.status}`);
    }

    return tokenBalances;
  } catch (error) {
    console.error(error);
  }
};

exports.getTokenData = (req, res) => {
  getTokenData(req.query.userAddress)
    .then((tokenMetadata) => {
      res.send({
        tokenMetadata: tokenMetadata,
      });
    })
    .catch((err) => {
      console.log(err);
      res.status(400).send(() => {
        Error: 'something went wrong!';
      });
    });
};
