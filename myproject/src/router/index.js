import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Issue from '@/components/Issue'
import metamask from '@/components/hello-metamask'
import Mission from '@/components/missionview'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    { path: '/Issue',
      name: 'Issue',
      component: Issue

    },
    {
      path: '/metamask',
      name: 'metamask',
      component: metamask
    },
    {
      path: '/Mission',
      name: 'Mission',
      component: Mission
    }


  ]
})
