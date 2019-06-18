<template>
<v-container grid-list-md text-xs-center>
    <v-layout row wrap>
        <v-flex xs12>
            <v-img :src="require('../assets/camera.svg')" class="my-3" contain height="100"></v-img>
        </v-flex>
    </v-layout>
    <v-layout row wrap>
        <v-flex mb-4 xs12>
            <h1 class="display-2 font-weight-bold mb-3">
                Bem-vindo!
            </h1>
        </v-flex>
    </v-layout>
    <v-layout row justify-center>
        <v-flex xs4 class="text-xs-center">
            <v-form ref="form" v-model="valid" lazy-validation>
                <v-text-field v-model="username" :rules="[rules.required]" label="Username" color="#f25a78" outline required></v-text-field>
                <v-text-field v-model="password" :rules="[rules.required]" :append-icon="show ? 'visibility_off' : 'visibility'" color="#f25a78" 
                outline :type="show ? 'text' : 'password'" name="input-10-1" label="Password" @click:append="show = !show" v-on:keyup.enter="validate"></v-text-field>

                <v-btn color="#f25a78" @click="validate">
                    Login
                </v-btn>
            </v-form>
        </v-flex>
    </v-layout>
    <v-snackbar v-model="snackbar" color="error" :multi-line="false" :timeout="6000" :top="true">
        {{ text }}
        <v-btn dark flat @click="snackbar = false">
            Close
        </v-btn>
    </v-snackbar>
</v-container>
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

export default {
    data: () => ({
        valid: false,
        show: false,
        error: false,
        text: '',
        snackbar: false,
        username: '',
        password: '',
        rules: {
            required: value => !!value || 'Campo obrigatório'
        }
    }),
    computed: {
        ...mapGetters({
            getUser : 'session/getUser'
        }),
    },
    beforeCreate: function () {
        if (this.$session.exists()) {
            this.$router.push('/Feed')
        }
    },
    methods: {

        validate() {

            if (this.$refs.form.validate()) {

                var data = {
                    'user': this.username,
                    'pass': this.password
                }

                this.$store.dispatch('session/checkUser', data).then(id => {
                    if (id) {
                        this.$session.start();
                        this.$session.set('id', id)
                        this.$router.push('/Feed')
                    } else {
                        this.text = "Credenciais incorretas!"
                        this.snackbar = true
                        this.$refs.form.reset()
                    }
                })

            }
        }

    },
    created(){
        this.getUser;
    }
}
</script>

<style scoped>
button {
    width: 200px;
    height: 50px;
    color: white !important;
}
</style>
