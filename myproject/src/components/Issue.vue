<template>
  <div class="container">
    <div class="b-row">
      <div>

        <ul></ul>
        <div>
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
      <hr>

      <div>
        <label for="coin">
          Coins 
        </label>
        <b-form-input
        id="coin"
        v-model="coin"
        type="text"
        placeholder="100 token / ETH"
        />
      </div>

    </div>
  </div>

<hr>

  <b-button
  @click="mn"
  :variant="'success'">
  {{ Issue }}
</b-button>

<hr>

<b-button
  @click="createissue"
  :variant="'success'">
  {{ createStatus }}
</b-button>



<hr>
<img v-if="pending" id="loader" src="https://loading.io/spinners/double-ring/lg.double-ring-spinner.gif">


</div>
    
</template>

<script>
import Web3 from 'web3'

export default {
  name: 'APP',
  data() {
    return {
      Issue : 'Generator',
      checked1: 0,
      checked2: 0,
      checked3: 0,
      checked4: 0,
      checked5: 0,
      coin: "",
      mission_num : 0,
      createStatus: 'CREATE Issue',
      missionlist:[],
      pending: false,
      key : 0,
    }
  },

  methods:{

    mn(){

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
      
      this.key = this.checked1*2**15 + this.checked2*2**14 +this.checked3*2^13 + this.checked4*2^12 + this.checked5*2^11
      console.log(this.key)
      this.mission_num = this.key
      console.log(this.mission_num)
      this.missionlist.push(this.key)
      console.log(this.missionlist)
      return this.key
    },

    createissue(){
      console.log('createissue',this.key,this.coin)
        this.pending = true
        /*this.$store.state.contractInstance().Issue(this.key, 2*this.coin,{
        gas: 300000,
        value: this.$store.state.web3.web3Instance().toWei(2*this.coin, 'ether'),
        from: this.$store.state.web3.coinbase
      },(error, result) =>{
        if(!error){
       console.log(JSON.stringify(result));
        this.pending = false}
        else{
       console.error(error)
        this.pending = false
        }
      });
        
        this.$store.state.contractInstance().methods.Issue(this.key, 2*this.coin).call(
          {from: '0x1414cf7491c71304739f2ec98d05ae7e9257511b'}, (error, result) => {
          if(!error){
            console.log(this.$store.state.contractInstance().methods.Issue(this.key, 2*this.coin).call);
          }
          else{console.error(error);}
        });*/
        this.$store.state.contractInstance().Issue(this.key, 2*this.coin).call(
          {from : '0x1414cf7491c71304739f2ec98d05ae7e9257511b'}).then(()=> {console.log(result)}); 
        
      }
    },

  
  mounted () {
    console.log('dispatching getContractInstance')
    this.$store.dispatch('getContractInstance')
  }
}


</script>

<style>

</style>
