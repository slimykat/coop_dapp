import web3 from './web3';

const address = '0xaff034962bd05b7b070de85793a99a35f47ea2ba' // contract address
const abi=[
	{
		"constant": false,
		"inputs": [
			{
				"name": "mission_num",
				"type": "uint256"
			}
		],
		"name": "Assign",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "mission_num",
				"type": "uint256"
			}
		],
		"name": "dequeue",
		"outputs": [
			{
				"name": "data",
				"type": "address"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "descript",
				"type": "uint256"
			},
			{
				"name": "coins",
				"type": "uint256"
			}
		],
		"name": "Issue",
		"outputs": [
			{
				"name": "",
				"type": "uint256"
			}
		],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "mission_num",
				"type": "uint256"
			}
		],
		"name": "mission_abort",
		"outputs": [],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"constant": false,
		"inputs": [
			{
				"name": "mission_num",
				"type": "uint256"
			},
			{
				"name": "accept_or_not",
				"type": "bool"
			}
		],
		"name": "pay_coop",
		"outputs": [],
		"payable": true,
		"stateMutability": "payable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"name": "_max_of_missions",
				"type": "uint256"
			},
			{
				"name": "_max_of_issues",
				"type": "uint256"
			},
			{
				"name": "_max_of_tasks",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_mission_num",
				"type": "uint256"
			},
			{
				"indexed": false,
				"name": "_who",
				"type": "address"
			}
		],
		"name": "coop_found",
		"type": "event"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"name": "_coop",
				"type": "address"
			},
			{
				"indexed": false,
				"name": "_accept_or_not",
				"type": "bool"
			}
		],
		"name": "coop_paid",
		"type": "event"
	},
	{
		"constant": true,
		"inputs": [
			{
				"name": "mission_num",
				"type": "uint256"
			}
		],
		"name": "Getinfo",
		"outputs": [
			{
				"name": "coin",
				"type": "uint256"
			},
			{
				"name": "stat",
				"type": "bool"
			},
			{
				"name": "descript",
				"type": "uint256"
			},
			{
				"name": "whose",
				"type": "address"
			},
			{
				"name": "queue_length",
				"type": "uint256"
			}
		],
		"payable": false,
		"stateMutability": "view",
		"type": "function"
	}
];

const instance = new web3.eth.Contract(abi, address);

export default instance;