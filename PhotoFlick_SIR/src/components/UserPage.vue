<template>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-2 text-center" style="display: inline-flex">
            <v-avatar slot="activator" size="150px" v-if="this.user.foto != null">
                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + this.user.foto" alt="Avatar">
            </v-avatar>
                <div class="col-2" v-if="getUser.username == this.user.username">
                    <v-tooltip top>
                        <v-btn slot="activator" color="#f25a78" fab small dark @click="dialog_edit = true">
                            <v-icon>edit</v-icon>
                        </v-btn>
                        <span>Editar perfil</span>
                    </v-tooltip>
                </div>
                <div class="col-2" v-if="getUser.username != this.user.username && !isFollowed(this.user.id_user)">
                    <v-tooltip top>
                        <v-btn slot="activator" color="#f25a78" fab dark @click="follow()">
                            <v-icon>person_add</v-icon>
                        </v-btn>
                        <span>Seguir</span>
                    </v-tooltip>
                </div>
                <div class="col-2" v-if="getUser.username != this.user.username && isFollowed(this.user.id_user)">
                    <v-tooltip top>
                        <v-btn slot="activator" color="#f25a78" fab dark @click="unfollow()">
                            <v-icon>done</v-icon>
                        </v-btn>
                        <span>Deixar de seguir</span>
                    </v-tooltip>
                </div>
        </div>

    </div>
    <div class="row justify-content-center mt-4">
        <div class="col-3 text-center">
            <span class="display-2 font-weight-light">@{{this.user.username}}</span>
        </div>
    </div>
    <div class="row justify-content-center mt-4">
        <div class="col-3 text-center">
            <span class="title font-weight-thin">{{this.user.nome}}</span>
        </div>
    </div>
    <div class="row justify-content-center mt-4">
        <div class="col-2 text-center" style="display: contents;">
            <v-btn flat color="#22313f" style="text-decoration:none;" @click="openModal('Seguidores')">
                <v-icon dark left>supervisor_account</v-icon>Seguidores
            </v-btn>
            <v-btn flat color="#22313f" style="text-decoration:none;" @click="openModal('A seguir')">
                <v-icon dark left>supervised_user_circle</v-icon>A seguir
            </v-btn>
        </div>
    </div>
    <v-divider></v-divider>
    <div class="row justify-content-center mt-4">
        <div class="col-3 text-center">
            <v-icon>dashboard</v-icon>
            <span class="headline font-weight-light">  Publicações</span>
        </div>
    </div>
    <div class="container">
        <div class="row justify-content-arround mt-5">
            <div v-for="(pub, i) in postsUser" v-bind:key="i">

                <div class="col-4 text-center mt-4" v-if="pub.fotopub != null" @click="openModalPub(pub)" :style="{ cursor: 'pointer'}">
                    <v-hover>
                        <v-card slot-scope="{ hover }" class="mx-auto" color="grey lighten-4" width="340">
                            <v-img height="340px" :src="'http://localhost:3000/public/uploads/posts/' + pub.fotopub">
                                <v-expand-transition>
                                    <div v-if="hover" class="d-flex transition-fast-in-fast-out black darken-2 v-card--reveal display-3 white--text" style="height: 100%;">
                                        <div class="container">
                                            <div class="row justify-content-center">
                                                <div class="col-2">
                                                    <v-icon color="#fff" large>message</v-icon>
                                                </div>
                                                <div class="col-2" style="padding-left:0px">
                                                    <span class="mr-4" style="font-size:30px">{{pub.coments}}</span>
                                                </div>
                                                <div class="col-2">
                                                    <v-icon color="#fff" large="">favorite</v-icon>
                                                </div>
                                                <div class="col-2" style="padding-left:0px">
                                                    <span class="mr-4" style="font-size:30px">{{pub.gostos}}</span>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </v-expand-transition>
                            </v-img>
                        </v-card>
                    </v-hover>
                </div>

            </div>
        </div>
    </div>

    <v-dialog v-model="dialog" scrollable max-width="400px">
        <v-card>
            <v-card-title class="headline #f03434 font-weight-medium">
                {{dialogTitle}}
                <v-spacer></v-spacer>
                <v-icon color="#000" class="mr-2" @click="dialog = false" :style="{ cursor: 'pointer'}">close</v-icon>
            </v-card-title>
            <v-card-text style="max-height: 200px;">
                <div v-for="(follow, i) in arrayFollow" v-bind:key="i">
                    <div class="row justify-content-start">
                        <div class="col-8">
                            <v-avatar slot="activator" size="30px" v-if="follow.foto != null" :style="{ cursor: 'pointer'}" @click="changePage(follow.username)">
                                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + follow.foto" alt="Avatar">
                                        </v-avatar>
                                <a class="subheading font-weight-light ml-3" :style="{ cursor: 'pointer'}" @click="changePage(follow.username)">{{follow.username}}</a>
                        </div>
                        <div class="row align-items-start">
                            <div class="col-3" v-if="!isFollowed(follow.id_user) && follow.id_user != getUser.id_user">
                                <v-btn id="follow" small color="#f25a78" @click="followFollower(follow.id_user)">Seguir</v-btn>
                            </div>
                            <div class="col-3" v-if="follow.id_user == getUser.id_user || isFollowed(follow.id_user)">
                                <v-tooltip top>
                                    <v-btn slot="activator" small disabled color="primary">Seguir</v-btn>
                                    <span>Já segue este utilizador</span>
                                </v-tooltip>
                            </div>
                        </div>
                    </div>
                </div>
            </v-card-text>
            <v-spacer></v-spacer>
        </v-card>
    </v-dialog>
    <v-dialog v-model="dialog_edit" persistent max-width="600px">
        <v-card>
            <v-card-title>
                <span class="headline">Editar perfil</span>
            </v-card-title>
            <v-card-text>
                <v-container grid-list-md>
                    <v-layout wrap>
                        <v-form ref="form" v-model="valid" lazy-validation>
                            <div class="container">
                                <div class="row justify-content-center">
                                    <div class="col-12 text-center mb-2">
                                        <v-text-field v-model="email" :rules="emailRules" label="E-mail" required color="#f25a78" outline></v-text-field>
                                    </div>
                                    <div class="col-12 text-center mb-2">
                                        <v-text-field v-model="username" :rules="usernameRules" :counter="10" label="Username" required color="#f25a78" outline></v-text-field>
                                    </div>
                                    <div class="col-12 text-center mb-2">
                                        <v-text-field v-model="name" :rules="nameRules" label="Nome" :counter="30" required color="#f25a78" outline></v-text-field>
                                    </div>
                                    <div class="col-12 text-center mb-2">
                                        <v-menu :close-on-content-click="false" v-model="menu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                                            <v-text-field slot="activator" v-model="computedDateFormatted" label="Data de nascimento" prepend-icon="event" readonly></v-text-field>
                                            <v-date-picker v-model="date" @input="menu2 = false" color="#f25a78" locale="pt-pt"></v-date-picker>
                                        </v-menu>
                                    </div>
                                </div>
                            </div>
                        </v-form>
                    </v-layout>
                </v-container>
            </v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue darken-1" flat @click="dialog_edit = false">Cancelar</v-btn>
                <v-btn color="blue darken-1" flat @click="checkForm()">Gravar</v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
    <v-dialog v-model="dialog_pub" width="900" v-if="this.postDetails.fotopub != null">

        <v-card style="overflow: hidden;">
            <v-card-text style="padding:0!important">
                <div class="container" style="padding:0!important">
                    <div class="row justify-content-start">
                        <div class="col-8">
                            <v-img aspect-ratio="1" :src="'http://localhost:3000/public/uploads/posts/' + this.postDetails.fotopub"></v-img>
                        </div>
                        <div class="col-4 mt-4">
                            <v-avatar slot="activator" size="40px" v-if="this.user.foto != null">
                                <img :src="'http://localhost:3000/public/uploads/profile/' + this.user.foto" alt="Avatar">
                            </v-avatar>
                                <span class="subheading font-weight-bold ml-2">{{this.user.nome}} </span>
                                <v-divider></v-divider>
                                <p class="body-2 font-weight-bold ml-2 text-left">{{this.user.nome}} <a class="body-2 font-weight-light ml-2">{{this.postDetails.descricao}}</a></p>

                                <div style="overflow-y: scroll; height:380px;">
                                    <div v-for="(comment, i) in this.postDetails.comentarios" v-bind:key="i">
                                        <p class="body-2 font-weight-bold ml-2 text-left">{{comment.username}} <a class="body-2 font-weight-light ml-2">{{comment.comentario}}</a></p>
                                    </div>
                                </div>
                                <div class="col-11">

                                    <v-text-field v-model="comentario" :id="this.postDetails.id_publicacao" :single-line="true" counter="200" color="#f25a78" placeholder="Adicionar um comentário ..." v-on:keyup.enter="addComment(postDetails.id_publicacao)">
                                    </v-text-field>
                                </div>

                        </div>
                    </div>
                </div>

            </v-card-text>

        </v-card>
    </v-dialog>
    <v-snackbar v-model="snackbar" color="success" :multi-line="false" :timeout="6000" :top="true">
        Utilizador editado com sucesso
        <v-btn dark flat @click="snackbar = false">
            Fechar
        </v-btn>
    </v-snackbar>
</div>
</template>

<script>
/* eslint-disable */

import axios from 'axios';

import {
    mapState,
    mapMutations,
    mapActions,
    mapGetters
} from 'vuex'

import moment from 'moment'

moment.locale('pt')

export default {
    data: () => ({
        comentario: '',
        postDetails: {},
        user: {},
        segue: false,
        snackbar: false,
        dialogTitle: '',
        valid: false,
        dialog: false,
        dialog_edit: false,
        dialog_pub: false,
        arrayFollow: [{}],
        loginUserSeguidores: [{}],
        postsUser: [{}],
        email: '',
        username: '',
        password: '',
        name: '',
        menu2: false,
        emailRules: [
            v => !!v || 'E-mail é um campo obrigatório',
            v => /.+@.+/.test(v) || 'Registe um e-mail válido'
        ],
        nameRules: [
            v => !!v || 'Nome é um campo obrigatório',
            v => v.length <= 30 || 'O nome deve conter menos de 30 carateres'
        ],
        usernameRules: [
            v => !!v || 'Username é um campo obrigatório',
            v => v.length <= 10 || 'O username deve conter menos de 10 carateres'
        ],
        passwordRules: [
            v => !!v || 'Password é um campo obrigatório',
        ],
        date: new Date().toISOString().substr(0, 10),
    }),
    watch: {
        '$route'(to, from) {
            this.$store.dispatch('users/getUser', this.$route.params.username).then(response => {
                this.user = response
                this.$store.dispatch('posts/setPostsUser', this.user.id_user).then(response => {
                    this.postsUser = response
                    console.log(this.postsUser)
                })
            })

            this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                this.loginUserSeguidores = response
            })

        }
    },
    computed: {
        computedDateFormatted() {
            return this.formatDate(this.date)
        },
        ...mapGetters({
            getUser: 'session/getUser'
        }),
    },
    methods: {
        formatDate(date) {
            if (!date) return null

            const [year, month, day] = date.split('-')
            return `${year}-${month}-${day}`
        },
        checkForm() {

        },
        getUserPage() {
            return this.$route.params.username
        },
        follow() {

            var data = {
                'id_seguidor': this.getUser.id_user,
                'id_seguido': this.user.id_user
            }

            this.$store.dispatch('users/addFollower', data).then(response => {
                this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                    this.loginUserSeguidores = response
                })
            })
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
        },

        unfollow() {
            var data = {
                'id_seguidor': this.getUser.id_user,
                'id_seguido': this.user.id_user
            }

            this.$store.dispatch('users/deleteLike', data).then(response => {
                this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                    this.loginUserSeguidores = response
                })
            })
        },
        openModal(text) {
            this.dialogTitle = text;
            this.dialog = true;

            if (text == 'Seguidores') {
                this.$store.dispatch('users/getFollowers', this.user.id_user).then(response => {
                    this.dialogTitle = "Seguidores (" + response.length + ")"
                    this.arrayFollow = response
                })
            } else {
                this.$store.dispatch('users/getFollowing', this.user.id_user).then(response => {
                    this.dialogTitle = "A seguir (" + response.length + ")"
                    this.arrayFollow = response
                })
            }
        },

        openModalPub(pub) {

            var data = {
                id_user: this.user.id_user,
                id_publicacao: pub.id_publicacao
            }

            this.$store.dispatch('posts/setPostDetails', data).then(response => {
                this.postDetails = response
                this.$store.dispatch('posts/getComments', pub.id_publicacao).then(response => {
                    this.postDetails.comentarios = response;
                    this.comentario = ''
                    this.dialog_pub = true
                })
            })
        },

        addComment(id) {

            console.log(this.comentario, id)

            if (this.comentario != '') {
                var data = {
                    'comentario': this.comentario,
                    'id_publicacao': id,
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('posts/insertComment', data).then(response => {
                    this.$store.dispatch('posts/getComments', id).then(response => {
                        this.postDetails.comentarios = response;
                        this.comentario = ''
                    })
                })

            } else {
                return;
            }
        },

        isFollowed(id_user) {
            var obj = this.loginUserSeguidores.find(o => o.id_user == id_user);
            if (obj) {
                return true;
            } else {
                return false;
            }
        },
        changePage(user) {
            this.dialog = false;
            this.$router.push('/UserPage/' + user)
        },
        checkForm() {

            if (this.$refs.form.validate()) {
                var data = {
                    'email': this.email,
                    'datanascimento': this.computedDateFormatted,
                    'nome': this.name,
                    'username': this.username,
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('users/editUser', data).then(response => {
                    this.$store.dispatch('session/setUser', this.$session.get('id'))
                    this.$store.dispatch('users/getUser', this.$route.params.username).then(response => {
                        this.user = response
                    })
                })

                this.dialog_edit = false;
                this.snackbar = true;
            }
        }
    },
    created() {
        this.$store.dispatch('users/getUser', this.$route.params.username).then(response => {

            this.email = this.getUser["e-mail"];
            this.username = this.getUser.username;
            this.name = this.getUser.nome;
            this.date = new Date(this.getUser.data_nascimento).toISOString().substr(0, 10);

            this.user = response

            var data = {
                'id_seguidor': this.getUser.id_user,
                'id_seguido': this.user.id_user
            }

            this.$store.dispatch('users/isFollower', data).then(response => {
                if (response.length > 0) {
                    this.segue = true;
                }
            })

            this.$store.dispatch('users/getFollowing', this.getUser.id_user).then(response => {
                this.loginUserSeguidores = response
            })

            this.$store.dispatch('posts/setPostsUser', this.user.id_user).then(response => {
                this.postsUser = response
            })

        })

    }
}
</script>

<style scoped>
#follow {
    color: white !important;
}

.v-card--reveal {
    align-items: center;
    bottom: 0;
    opacity: .5;
    width: 100%;
    font-size: 10px;
}

.crop {
    width: 200px;
    height: 150px;
    overflow: hidden;
}

.crop img {
    width: 400px;
    height: 300px;
    margin: -75px 0 0 -100px;
}
</style>
