<template>
	<div id="mission">
		<div class="container">
			<ul></ul>
			<div >
				<p>
				<b-form-checkbox v-model="checked1" name="BackEnd" switch>
					BackEnd <b> ({{ checked1 }})</b>
				</b-form-checkbox>	
			<!---</p><p>-->
				<b-form-checkbox v-model="checked2" name="FrontEnd" switch >
					FrontEnd <b> ({{ checked2 }})</b>
				</b-form-checkbox>

			<!--</p><p>-->
				<b-form-checkbox v-model="checked3" name="Solidity" switch>
					Solidity <b> ({{ checked3 }})</b>
				</b-form-checkbox>
			<!--</p><p>-->
				<b-form-checkbox v-model="checked4" name="Consultant" switch>
					Consultant <b> ({{ checked4 }})</b>
				</b-form-checkbox>
			<!--</p><p>-->
				<b-form-checkbox v-model="checked5" name="UI/UX" switch>
					UI/UX <b> ({{ checked5 }}) </b>
				</b-form-checkbox>
			</p>
		</div>
		
		<b-navbar-nav class="ml-auto">
        <b-nav-form>
        	<!--<b-form-input size="sm" class="mr-sm-2" v-model="text" placeholder="Search Mission"> </b-form-input>-->
          	<b-button size="sm" class="my-2 my-sm-0" @click='Getinfo' > Search </b-button>
        </b-nav-form>
		</b-navbar-nav>
		

		<hr>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Mission Number</th>
					<th scope="col">Coin</th>
					<th scope="col">Address</th>
					<th scope="col">Queue</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for='(item,i) in this.listData' >
					<th scope="row">{{item[0]}}</th>
					<td>{{item[1]}}</td>
					<td>>{{item.coin}}</td>
					<td>{{item.address}}</td>
				</tr>

			</tbody>
		</table>
		
		<hr>

		<div class="btn-group-toggle" data-toggle="buttons">
			<label class="btn btn-secondary active">
				<input type="checkbox" checked autocomplete="off" @click='Assign'> Assign this mission
			</label>
		</div>

	</div>
</div>
</template>

<script>
import Web3 from 'web3'

export default {
	name: 'mission',
	data(){return{

  	   	checked1: false,
  	   	checked2: false,
  	   	checked3: false,
  	   	checked4: false,
  	   	checked5: false,

	   	listData: [],
	   	price: '',
	   	descrip:'',
	   	whose_address: '',
	   	dequeu: '',
	   	key:0,
	   	mission_num2:0,
	   	missionlist2:[],
	   }
	},
	methods:{
		Getinfo(event){
		this.key = this.checked1*(2**15) + this.checked2*(2**14) + this.checked3*(2**13) + this.checked4*(2**12) + this.checked5*(2**11)
		var Info = [];
		console.log('getinfo',this.key2)
		Info=(this.$store.state.contractInstance().Getinfo(this.key2,{
			gas: 300000,
			value: this.$store.state.web3.web3Instance().toWei(this.coin, 'ether'),
			from: this.$store.state.web3.coinbase
		},(error, result) =>{
			if(!error){
				console.log(JSON.stringify(result))
				}
				else{
				console.error(error)}
			}))
		return this.listData.push(Info)
	
    	  },
    
    Assign(event){

		console.log('assign',this.key2)
		this.$store.state.contractInstance().Assign(this.key2,{
			gas: 300000,
			value: this.$store.state.web3.web3Instance().toWei(this.coin, 'ether'),
			from: this.$store.state.web3.coinbase
		},(error, result) =>{
			if(!error){
				console.log(JSON.stringify(result))
				}
				else{
				console.error(error)}
 			})
		}
	},

	mounted () {
    console.log('dispatching getContractInstance')
    this.$store.dispatch('getContractInstance')
  }
 }

</script>
