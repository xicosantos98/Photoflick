import Vue from 'vue'
import './plugins/vuetify'
import './plugins/moment'
import App from './App.vue'
import router from './router'
import store from './store'
import VueSession from 'vue-session'
import jquery from 'vue-jquery'
import BootstrapVue from 'bootstrap-vue'
import fab from 'vue-fab'


Vue.use(BootstrapVue);
Vue.use(jquery)
Vue.use(fab)


Vue.config.productionTip = false

var options = {
  persist: true
}

Vue.use(VueSession, options)

new Vue({
  render: h => h(App),
  router,
  store,
  fab
}).$mount('#app')
