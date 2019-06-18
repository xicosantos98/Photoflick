import Vue from 'vue'
import Router from 'vue-router'

import Login from '@/components/Login'
import Register from '@/components/Register'
import Feed from '@/components/Feed'
import UserPage from '@/components/UserPage'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/Register',
      name: 'Register',
      component: Register
    },
    {
      path: '/Feed',
      name: 'Feed',
      component: Feed,
      meta : {title: 'Feed'}
    },
    {
      path: '/UserPage/:username',
      name: 'UserPage',
      component: UserPage
    }
  ]
})
