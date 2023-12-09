const getTokens = async () => {
  const url = 'https://api.1inch.dev/token/v1.2/8453';

  const config = {
    headers: {
      Authorization: `Bearer ${process.env.ONEINCH_API_KEY}`,
    },
    params: {
      country: 'US',
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

    const tokens = await response.json();

    console.log(tokens);
    return tokens;
  } catch (error) {
    console.error(error);
  }
};

exports.getTokens = (req, res) => {
  getTokens()
    .then((tokens) => {
      res.send({
        tokens: tokens,
      });
    })
    .catch((err) => {
      console.log(err);
      res.send(() => {
        Error: 'something went wrong!';
      });
    });
};
