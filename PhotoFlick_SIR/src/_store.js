import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

/* eslint-disable */
import axios from 'axios';

export default new Vuex.Store({

    state: {
        userLogin: {}
    },
    mutations: {
        SET_USER_LOGIN(state, user) {
            state.userLogin = user;
        }
    },
    actions: {
        checkUser(context, data) {

            return new Promise((resolve, reject) => {
                axios.post('http://localhost:3000/user/login', {
                    username: data.user,
                    password: data.pass
                })
                .then(function (response) {
                    if (response.data.length > 0) {
                        context.commit('SET_USER_LOGIN',response.data[0])
                        resolve(response)
                    } else {
                        resolve(null)
                    }
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
            })

        }
    }


})