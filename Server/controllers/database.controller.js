const { MongoClient, ServerApiVersion } = require('mongodb');
require('dotenv').config();

console.log('process.env.MONGODB_URI', process.env.MONGODB_URI);
const client = new MongoClient(process.env.MONGODB_URI, {
  serverApi: {
    version: ServerApiVersion.v1,
    strict: true,
    deprecationErrors: true,
  },
});

client
  .connect()
  .then(() => {
    console.log('Successfully connected to the database');
  })
  .catch((err) => {
    console.log('Could not connect to the database. Exiting now...', err);
    process.exit();
  });

exports.addUser = async (owner, safeAddress) => {
  const accounts = client.db('benjamin').collection('accounts');
  await accounts.insertOne({
    owner: owner,
    safeAddress: safeAddress,
  });
};
