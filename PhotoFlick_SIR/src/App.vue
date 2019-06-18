<template>
<v-app>
    <v-toolbar color="#f25a78" dark app fixed>
        <v-btn icon large to="/Feed" style="text-decoration:none;">
            <v-icon large color="#fff">camera</v-icon>
        </v-btn>
        <v-toolbar-title class="headline text">
            <span style="font-size:25px;">PHOTOFLICK</span>
        </v-toolbar-title>
        <v-spacer></v-spacer>
        <v-text-field v-model="searchText" v-if='this.$session.exists()' flat solo-inverted hide-details append-icon="search" @click:append="search()" v-on:keyup.enter="search()" label="Pesquise por utilizadores" style="margin-right: 17em!important;"></v-text-field>
        <v-btn flat color="#fff" to="/" v-if="!this.$session.exists()" style="text-decoration:none;">
            <v-icon dark left>person</v-icon>Login
        </v-btn>
        <v-btn flat color="#22313f" to="/Register" v-if='!this.$session.exists()' style="text-decoration:none;">
            <v-icon dark left>person_add</v-icon>Registar
        </v-btn>
        <div v-if='this.$session.exists() && getUser.username != null'>
            <v-avatar slot="activator" size="36px">
                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + getUser.foto" alt="Avatar" width="36" height="36">
            </v-avatar>
                <strong v-html="getUser.nome" style="margin-left:15px;"></strong>
        </div>

        <div>

        </div>

        <v-menu bottom left v-if='this.$session.exists()'>
            <v-btn slot="activator" dark icon>
                <v-icon color="#22313f">more_vert</v-icon>
            </v-btn>

            <v-list>
                <v-list-tile :style="{ cursor: 'pointer'}">
                    <v-list-tile-title @click="account">
                        <v-icon left color="#22313f">account_circle</v-icon>Perfil
                    </v-list-tile-title>
                </v-list-tile>
                <v-list-tile :style="{ cursor: 'pointer'}">
                    <v-list-tile-title @click="logout">
                        <v-icon left color="#22313f">exit_to_app</v-icon>Logout
                    </v-list-tile-title>
                </v-list-tile>
            </v-list>
        </v-menu>

    </v-toolbar>
    <div class="hidden-md-and-up">
        <v-expansion-panel>
            <v-expansion-panel-content>
                <div slot="header">
                    <v-btn icon>
                        <v-icon large color="#f25a78">camera</v-icon>
                    </v-btn>
                </div>
                <v-list v-if="!this.$session.exists()">
                    <v-list-tile @click="loginPage()">
                        <v-list-tile-title>
                            <v-icon left color="#22313f">person</v-icon>Login
                        </v-list-tile-title>
                    </v-list-tile>
                    <v-list-tile :style="{ cursor: 'pointer'}" @click="registerPage()">
                        <v-list-tile-title @click="logout">
                            <v-icon left color="#22313f">person_add</v-icon>Registar
                        </v-list-tile-title>
                    </v-list-tile>
                </v-list>
                <v-list v-if="this.$session.exists()">
                    <v-list-tile>
                        <v-list-tile-title v-if='getUser.username != null'>
                            <v-avatar slot="activator" size="36px">
                                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + getUser.foto" alt="Avatar" width="36" height="36">
                            </v-avatar>
                                <strong v-html="getUser.nome" style="margin-left:15px;"></strong>
                        </v-list-tile-title>
                    </v-list-tile>
                    <v-list-tile>
                        <v-list-tile-title>
                            <v-icon left color="#22313f">settings</v-icon>Definições
                        </v-list-tile-title>
                    </v-list-tile>
                    <v-list-tile :style="{ cursor: 'pointer'}">
                        <v-list-tile-title @click="logout">
                            <v-icon left color="#22313f">exit_to_app</v-icon>Logout
                        </v-list-tile-title>
                    </v-list-tile>
                </v-list>
            </v-expansion-panel-content>
        </v-expansion-panel>
    </div>
    <v-dialog v-model="dialog_search" scrollable width="450">
        <v-card>
            <v-card-title class="headline #f03434 font-weight-light mb-3">
                <v-icon color="#000" class="mr-2">search</v-icon>Resultados da pesquisa ...
                <v-spacer></v-spacer>
                <v-icon color="#000" class="mr-2" @click="dialog_search = false" :style="{ cursor: 'pointer'}">close</v-icon>
            </v-card-title>

            <v-card-text style="padding-top:0px;max-height: 200px!important;">
                <div class="container" style="padding-top:0px;padding-bottom:20px" v-for="(user, i) in searchResults" v-bind:key="i">
                    <div class="row justify-content-center">
                        <div class="col-12">
                            <v-avatar slot="activator" size="30px">
                                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + user.foto" alt="Avatar" v-if="user.foto != null">
                                        </v-avatar>
                                <span class="subheading font-weight-light ml-3" :style="{ cursor: 'pointer'}" @click="changePage(user.username)" >{{user.nome}}</span>
                        </div>
                    </div>
                </div>
                <span v-if="searchResults.length == 0" class="subheading font-weight-light ml-3">Sem resultados!!!</span>
            </v-card-text>
        </v-card>
    </v-dialog>

    <v-content>
        <router-view></router-view>
    </v-content>
</v-app>
</template>

<script>
/* eslint-disable */

import {
    mapState,
    mapMutations,
    mapActions,
    mapGetters
} from 'vuex'

import axios from 'axios';

var socket = io('http://localhost:3000/');

export default {
    data: () => ({
        items: [{
                title: 'Definições',
                function: 'Logout'
            },
            {
                title: 'Logout',
                function: 'Logout'
            }
        ],
        searchResults: [{}],
        url: '',
        searchText: '',
        dialog_search: false,
        loginUserSeguidores: [{}]
    }),
    methods: {
        logout: function () {
            this.$session.destroy()
            this.$router.push('/')
        },
        loginPage() {
            this.$router.push('/')
        },
        registerPage() {
            this.$router.push('/Register')
        },
        account() {
            this.$forceUpdate();
            this.$router.push('/UserPage/' + this.getUser.username)
        },
        search() {
            this.$store.dispatch('users/searchUser', this.searchText).then(result => {
                this.searchResults = result
                this.dialog_search = true;
                this.searchText = '';
            })

        },
        changePage(user) {
            this.dialog_search = false;
            this.$router.push('/UserPage/' + user)
        },
        isFollowed(id_user) {
            var obj = this.loginUserSeguidores.find(o => o.id_user == id_user);
            if (obj) {
                return true;
            } else {
                return false;
            }
        },
        followFollower(id_user) {
            var data = {
                'id_seguidor': this.getUser.id_user,
                'id_seguido': id_user
            }

            this.$store.dispatch('users/addFollower', data).then(response => {
                this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                    this.loginUserSeguidores = response
                })
            })
        }
    },
    computed: {
        ...mapGetters({
            getUser: 'session/getUser'
        })

    },
    beforeCreate() {
        if (this.$session.exists()) {
            this.$store.dispatch('session/setUser', this.$session.get('id')).then(response => {
                var self = this;
                socket.on('like', function (data) {

                    axios.get('http://localhost:3000/posts/getPostByUser/' + data.id_publicacao + "/" + self.getUser.id_user)
                        .then(function (response) {

                            if (response.data.length > 0) {
                                axios.post('http://localhost:3000/user/getUser', {
                                        id: data.id_user
                                    })
                                    .then(function (response) {
                                        console.log(response)
                                        iziToast.show({
                                            title: '',
                                            messageColor: '#fff',
                                            iconColor: '#fff',
                                            icon: 'fas fa-bell',
                                            message: response.data[0].username + ' gostou da sua foto',
                                            image: 'http://localhost:3000/public/uploads/profile/' + response.data[0].foto,
                                            imageWidth: 100,
                                            color: '#f25a78',
                                            titleLineHeight: 60,
                                            maxWidth: 400,
                                            messageLineHeight: 60,
                                            progressBarColor: '#fff',
                                        });
                                    })
                                    .catch(function (error) {
                                        console.log(error)
                                    });
                            }
                        })
                        .catch(function (error) {
                            console.log(error)
                        });

                });
                socket.on('comment', function (data) {

                    axios.get('http://localhost:3000/posts/getPostByUser/' + data.id_publicacao + "/" + self.getUser.id_user)
                        .then(function (response) {

                            if (response.data.length > 0) {
                                axios.post('http://localhost:3000/user/getUser', {
                                        id: data.id_user
                                    })
                                    .then(function (response) {
                                        console.log(response)
                                        iziToast.show({
                                            title: '',
                                            messageColor: '#fff',
                                            iconColor: '#fff',
                                            icon: 'fas fa-comments',
                                            message: response.data[0].username + ' comentou "' + data.comentario + '"',
                                            image: 'http://localhost:3000/public/uploads/profile/' + response.data[0].foto,
                                            imageWidth: 100,
                                            color: '#f25a78',
                                            titleLineHeight: 60,
                                            maxWidth: 800,
                                            messageLineHeight: 60,
                                            progressBarColor: '#fff',
                                        });
                                    })
                                    .catch(function (error) {
                                        console.log(error)
                                    });
                            }
                        })
                        .catch(function (error) {
                            console.log(error)
                        });

                });
            })
        }
    },
    created() {

        if (this.$session.exists()) {
            this.$store.dispatch('session/setUser', this.$session.get('id')).then(response => {

                this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                    this.loginUserSeguidores = response
                    console.log(this.loginUserSeguidores)
                })

            })
        }

    }

}
</script>

<style scoped>

</style>
