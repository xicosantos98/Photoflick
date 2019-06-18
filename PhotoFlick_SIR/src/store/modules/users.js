/* eslint-disable */
import axios from 'axios';

const state = {

}
const mutations = {

}
const actions = {
    insertUser({ commit }, data) {


        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/insertUser', {
                email: data.email,
                password: data.pass,
                datanascimento: data.datanascimento,
                nome: data.nome,
                username: data.username
            })
                .then(function (response) {
                    resolve(response)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    editUser({ commit }, data) {


        return new Promise((resolve, reject) => {
            axios.put('http://localhost:3000/user/editUser', {
                email: data.email,
                datanascimento: data.datanascimento,
                nome: data.nome,
                username: data.username,
                id_user: data.id_user
            })
                .then(function (response) {
                    resolve(response)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    getUser ({ commit }, user) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/getUserByName', {
                username: user
            })
                .then(function (response) {
                    resolve(response.data[0])
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    isFollower({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/follow', {
                id_seguidor: data.id_seguidor,
                id_seguido: data.id_seguido
            })
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    addFollower({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/createFollower', {
                id_seguidor: data.id_seguidor,
                id_seguido: data.id_seguido
            })
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    deleteLike({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios.delete('http://localhost:3000/user/unFollow', {
                data:{
                    id_seguidor: data.id_seguidor,
                    id_seguido: data.id_seguido
                }
                
            })
                .then(function (response) {
                    resolve(response)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    getFollowers({ commit }, id_seguidor) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/getFollowers', {
                id_user: id_seguidor
            })
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    getFollowing({ commit }, id_seguidor) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/getFollowing', {
                id_user: id_seguidor
            })
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    searchUser({ commit }, query) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/user/search', {
                texto: query
            })
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    }




}

const getters = {
}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
}