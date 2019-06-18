/* eslint-disable */
import axios from 'axios';

const state = {
    userLogin: {}
}
const mutations = {
    SET_USER_LOGIN(state, user) {
        state.userLogin = user;
    }
}
const actions = {
    checkUser({ commit }, data) {

        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/login', {
                username: data.user,
                password: data.pass
            })
                .then(function (response) {
                    if (response.data) {
                        commit('SET_USER_LOGIN', response.data)
                        resolve(response.data.id_user)
                    } else {
                        resolve(null)
                    }
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    setUser({ commit }, id) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/getUser', {
                id: id
            })
                .then(function (response) {
                    if (response.data.length > 0) {
                        commit('SET_USER_LOGIN', response.data[0])
                        resolve(response.data[0])
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

const getters = {
    getUser: (state) => {
       return state.userLogin
    }
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
}