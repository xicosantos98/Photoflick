import Vue from 'vue'
import Vuex from 'vuex'
import session from './modules/session'
import users from './modules/users'
import posts from './modules/posts'

Vue.use(Vuex)


export default new Vuex.Store({
    modules: {
        session,
        users,
        posts
    }
})