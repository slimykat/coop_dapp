<template>

  <div id="app">
  <div>
  <b-navbar toggleable="lg" type="dark" variant="dark">
    <b-navbar-brand href="#">Raiding Chain</b-navbar-brand>

    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav>
        <b-nav-item :to="{path: '/'} " exact>Home</b-nav-item>
        <b-nav-item :to="{path: 'Issue'}" exact>Issue</b-nav-item>
        <b-nav-item :to="{path: 'Mission'}" exact>Mission</b-nav-item>
        <b-nav-item :to="{path: 'metamask'}" exact>Account</b-nav-item>
      </b-navbar-nav>

      

      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
        <b-nav-form>
          <b-form-input size="sm" class="mr-sm-2" placeholder="Search"></b-form-input>
          <b-button size="sm" class="my-2 my-sm-0" type="submit">Search</b-button>
        </b-nav-form>

   

        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template slot="button-content"><em>User</em></template>
          <b-dropdown-item href="#">Profile</b-dropdown-item>
          <b-dropdown-item href="#">Sign Out</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
</div>
  
    <router-view/>

  </div>
</template>

<script>
import HelloMetamask from '@/components/hello-metamask'
export default {
  name: 'App',
  beforeCreate () {
    console.log('registerWeb3 Action dispatched from coop-dapp.vue')
    this.$store.dispatch('registerWeb3')
  },
  components: {
    'hello-metamask': HelloMetamask
  }
}

  
</script>

<style lang='scss'>
@import 'node_modules/bootstrap/scss/bootstrap';

</style>
