const { getUser } = require("../controllers/database.controller");

exports.calculateNonce = (userAddress) => {
    const user = getUser(userAddress);
    if (!user.nonce) {
        user.nonce = 100;
    }
    user.nonce += 10;
    return user.nonce;
};