const { ethers } = require('ethers');
const { GelatoRelayPack } = require('@safe-global/relay-kit');
const Safe = require('@safe-global/protocol-kit');
const EthersAdapter = require('@safe-global/protocol-kit').EthersAdapter;

const provider = new ethers.JsonRpcProvider(process.env.RPC_URL)
const signer = new ethers.Wallet(process.env.OWNER_1_PRIVATE_KEY, provider)
// Any address can be used for destination. In this example, we use vitalik.eth
// const destinationAddress = '0x3a574461fd1279FCF96043bcF416C53B7e8dcEC0'
// const withdrawAmount = ethers.parseUnits('0.0005', 'ether').toString()

signTransaction = async ({
    tx,
    signedMsg
}) => {

    const safeAddress = tx.from;
    const transactions = [{
        to: tx.to,
        data: tx.data,
        value: tx.value
    }]
    const options = {
        isSponsored: true
    }
    const ethAdapter = new EthersAdapter({
        ethers,
        signerOrProvider: signer
    })

    const protocolKit = await Safe.default.create({
        ethAdapter,
        safeAddress
    })

    const relayKit = new GelatoRelayPack({ apiKey: process.env.GELATO_RELAY_API_KEY, protocolKit })

    const safeTransaction = await relayKit.createRelayedTransaction({
        transactions,
        options
    })

    const signedSafeTransaction = await protocolKit.signTransaction(safeTransaction)

    const response = await relayKit.executeRelayTransaction(signedSafeTransaction, options)

    return response
}
exports.signTransaction = (req, res) => {
    const { tx, signedMsg } = req.body
    signTransaction({
        tx,
        signedMsg
    })
        .then(response => {
            res.status(200).json({
                response: response
            })
        })
        .catch(error => {
            console.log("error : ", error)
            res.status(400).json(error)
        })
}