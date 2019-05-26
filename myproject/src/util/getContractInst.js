import web3 from 'web3';
import {address, ABI} from './constants/ContractInstance'

let getContract = new Promise(function (resolve, reject) {
  let web3 = new Web3(window.web3.currentProvider)
  let coopContract = web3.eth.contract(ABI)
  let coopContractInstance = coopContract.at(address)
  console.log(coopContract)
  console.log(coopContractInstance)
  resolve(coopContractInstance)
})

export default getContract
