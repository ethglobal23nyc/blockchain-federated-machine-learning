
import { Wallet } from "ethers";

const wallet = Wallet.createRandom();
console.log("Wallet address: " + wallet.address);
console.log("Private key: " + wallet.privateKey);
console.log('12-word mnemonic phrase:', wallet.mnemonic.phrase);
