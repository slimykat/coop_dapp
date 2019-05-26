<template>
	<div id="mission">
		<div class="container">
			<ul></ul>
			<div >
				<p>
					<b-form-checkbox v-model="checked1" name="BackEnd" button
					button-variant="primary" size="sm" value=1 unchacked-value=0 >
					BackEnd <b> {{ checked1 }}</b>
				</b-form-checkbox>
			</p><p>
				<b-form-checkbox v-model="checked2" name="FrontEnd" button button-variant="primary" size="sm" value=1 unchacked-value=0>
					FrontEnd <b> {{ checked2 }}</b>
				</b-form-checkbox>
			</p><p>
				<b-form-checkbox v-model="checked3" name="Solidity" button button-variant="primary" size="sm" value=1 unchacked-value=0>
					Solidity <b> {{ checked3 }}</b>
				</b-form-checkbox>
			</p><p>
				<b-form-checkbox v-model="checked4" name="Consultant" button button-variant="primary" size="sm" value=1 unchacked-value=0>
					Consultant <b> {{ checked4 }}</b>
				</b-form-checkbox>
			</p><p>
				<b-form-checkbox v-model="checked5" name="UI/UX" button button-variant="primary" size="sm" value=1 unchacked-value=0>
					UI/UX <b> {{ checked5 }} </b>
				</b-form-checkbox>
			</p>
		</div>
		<b-button
		@click="mn2"
		:variant="'success'">
		{{ Num }}
		</b-button>
		{{key2}}

		<hr>
		
		<b-navbar-nav class="ml-auto">
        <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" v-model="text" placeholder="Search Mission"> </b-form-input>
          <b-button size="sm" class="my-2 my-sm-0" @click='Getinfo' >Search</b-button>
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
		{{this.listData}} 

		<div class="btn-group-toggle" data-toggle="buttons">
			<label class="btn btn-secondary active">
				<input type="checkbox" checked autocomplete="off" @click='Assign'> Checked
			</label>
		</div>

	</div>
</div>
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'mission',

  data(){
  	 return{

  	   Num: 'Gettinfo',
  	   checked1: 0,
  	   checked2: 0,
  	   checked3: 0,
  	   checked4: 0,
  	   checked5: 0,
  	   text : '',
	   listData: [],
	   price: '',
	   descrip:'',
	   whose_address: '',
	   dequeu: '',
	   key2:0,
	   mission_num2:0,
	   missionlist2:[],
	   }
	},
methods:{
		mn2(){

      if (this.checked1 == 1) {
        this.checked1 = 1
      } else {
        this.checked1 = 0        
      };

      if (this.checked2 == 1) {
        this.checked2 = 1
      } else {
        this.checked2 = 0
      };

      if (this.checked3 == 1) {
        this.checked3 = 1
      } else {
        this.checked3 = 0
      };

      if (this.checked4 == 1) {
        this.checked4 = 1
      } else {
        this.checked4 = 0
      };

      if (this.checked5 == 1) {
        this.checked5 = 1
      } else {
        this.checked5 = 0
      };
      
      this.key2 = this.checked1*2**15 + this.checked2*2**14 +this.checked3*2^13 + this.checked4*2^12 + this.checked5*2^11
      console.log(this.key2)
      this.mission_num2 = this.key2
      console.log(this.mission_num2)
      this.missionlist2.push(this.key2)
      console.log(this.missionlist2)
      return this.key2
    	},

    
	Getinfo(event){
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
