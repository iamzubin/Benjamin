require('dotenv').config();

const getTokenBalancesForWallet = async (userAddress) => {
  const url = `https://api.1inch.dev/balance/v1.2/8453/balances/${userAddress}`;

  const config = {
    headers: {
      Authorization: 'Bearer ' + process.env.ONEINCH_API_KEY,
    },
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
    console.log(tokenBalances);
    return tokenBalances;
  } catch (error) {
    console.error(error);
  }
};

exports.getTokenBalancesForWallet = (req, res) => {
  getTokenBalancesForWallet(req.query.userAddress)
    .then((walletBalances) => {
      res.send({
        walletBalances: walletBalances,
      });
    })
    .catch((err) => {
      console.log(err);
      res.send(() => {
        Error: 'something went wrong!';
      });
    });
};
