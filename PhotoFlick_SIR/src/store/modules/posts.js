/* eslint-disable */
import axios from 'axios';
var promisses = [];

const state = {
    posts: []
}
const mutations = {
    SET_POSTS(state, posts) {
        state.posts = posts;
    }
}
const actions = {
    setPosts({ commit,rootState }, id) {
        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getAll/' + id )
                .then(function (response) {

                    for (var obj of response.data) {
                        obj.coment_show = false;
                        obj.dialog_likes = false;

                    }

                    commit('SET_POSTS', response.data)
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },
    
    setPostsUser({ commit,rootState }, id) {
        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getPostsUser/' + id )
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    setPostDetails({ commit,rootState }, data) {
        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getPostDetails/' + data.id_user + "/" +  data.id_publicacao)
                .then(function (response) {
                    resolve(response.data[0])
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },




    setComments({ commit }, id) {

        var obj = state.posts.find(o => o.id_publicacao == id);

        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getComments/' + id)
                .then(function (response) {
                    obj.comentarios = response.data
                    commit('SET_POSTS', state.posts)
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    getComments({ commit }, id) {

        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getComments/' + id)
                .then(function (response) {
                    resolve(response.data)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },



    setLikes({ commit }, id, user) {

        var obj = state.posts.find(o => o.id_publicacao == id);
        return new Promise((resolve, reject) => {
            axios.get('http://localhost:3000/posts/getLikes/' + id)
                .then(function (response) {
                    obj.likes = response.data
                    commit('SET_POSTS', state.posts)
                    resolve(state.posts)
                })
                .catch(function (error) {
                    console.log(error)
                    reject(error)
                });
        })
    },

    insertComment({ commit }, data) {


        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/posts/insertComment', {
                comentario: data.comentario,
                id_user: data.id_user,
                id_publicacao: data.id_publicacao
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

    insertLike({ commit }, data) {


        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/posts/insertLike', {
                data: data.data,
                id_user: data.id_user,
                id_publicacao: data.id_publicacao
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
    deleteLike({ commit }, data) {

        
        return new Promise((resolve, reject) => {
            axios.delete('http://localhost:3000/posts/deleteLike', {
                data:{
                    id_user: data.id_user,
                    id_publicacao: data.id_publicacao
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

    insertPost({ commit }, data) {
        return new Promise((resolve, reject) => {
            axios.post('http://localhost:3000/posts/insertPost', {
                descricao: data.descricao,
                data: data.data,
                foto: data.foto,
                localizacao: data.localizacao,
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
    }


}

const getters = {
    getPosts: (state) => {
        return state.posts
    }

}

export default {
    namespaced: true,
    state,
    getters,
    actions,
    mutations
}