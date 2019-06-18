<template>
<v-form v-model="valid">
    <v-layout row mb-4 mt-5>
        <v-flex xs12>
            <v-img :src="require('../assets/add-user.svg')" class="my-3" contain height="100"></v-img>
        </v-flex>
    </v-layout>
    <v-container>
        <v-form ref="form" v-model="valid" lazy-validation>
            <v-layout row align-center justify-center>
                <v-flex xs6 md4 mr-5 class="justify-center">
                    <v-text-field v-model="email" :rules="emailRules" label="E-mail" required color="#f25a78" outline></v-text-field>
                    <v-text-field v-model="username" :rules="usernameRules" :counter="10" label="Username" required color="#f25a78" outline></v-text-field>
                    <v-text-field v-model="password" label="Password" :rules="passwordRules" required color="#f25a78" outline type="password"></v-text-field>
                </v-flex>
                <v-flex xs6 md4 mr-5>
                    <v-text-field v-model="name" :rules="nameRules" label="Nome" :counter="30" required color="#f25a78" outline></v-text-field>
                    <v-menu :close-on-content-click="false" v-model="menu2" :nudge-right="40" lazy transition="scale-transition" offset-y full-width min-width="290px">
                        <v-text-field slot="activator" v-model="computedDateFormatted" label="Data de nascimento" prepend-icon="event" readonly></v-text-field>
                        <v-date-picker v-model="date" @input="menu2 = false" color="#f25a78" locale="pt-pt"></v-date-picker>
                    </v-menu>
                </v-flex>
            </v-layout>

            <v-layout row justify-center>
                <v-flex xs6 md3>
                    <v-btn id="registar" block color="#f25a78" @click="checkForm">
                        Registar
                    </v-btn>
                </v-flex>
            </v-layout>
        </v-form>

    </v-container>
    <v-layout row justify-center>
        <v-dialog v-model="dialog" persistent max-width="600px">

            <v-card>
                <v-card-title>
                    <v-icon large color="#22313f" class="mr-2">cloud_upload</v-icon><span class="headline">Carregar foto de perfil</span>
                </v-card-title>
                <v-card-text>
                    <v-container grid-list-md>
                        <v-layout wrap>
                            <div class="file-upload">
                                <div class="image-upload-wrap">
                                    <form id="uploadPic" method="post" enctype="multipart/form-data" action="">
                                        <input id="file" name="file" class="file-upload-input" type='file' @change="readURL" accept="image/*" />
                                    </form>
                                        <div class="drag-text">
                                            <h3>Arraste uma imagem para aqui</h3>
                                        </div>
                                </div>
                                <div class="file-upload-content">
                                    <img class="file-upload-image" src="#" alt="your image" />
                                    <div class="image-title-wrap">
                                        <v-btn color="blue-grey" class="white--text" @click="removeUpload">
                                            <v-icon left dark>delete</v-icon>Remover
                                        </v-btn>
                                    </div>
                                </div>
                            </div>
                        </v-layout>
                    </v-container>
                </v-card-text>
                <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn id="cancelar" color="#f25a78" @click="resetForm">Cancelar</v-btn>
                    <v-btn color="success" @click="checkFiles">Gravar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-layout>
    <v-snackbar v-model="snackbar" color="error" :multi-line="false" :timeout="6000" :top="true">
        Obrigatório fazer upload de imagem de perfil
        <v-btn dark flat @click="snackbar = false">
            Fechar
        </v-btn>
    </v-snackbar>
</v-form>
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
        dialog: false,
        snackbar: false,
        selectedFile: null,
        email: '',
        username: '',
        password: '',
        name: '',
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
        menu2: false,
    }),
    computed: {
        computedDateFormatted() {
            return this.formatDate(this.date)
        }
    },
    methods: {
        formatDate(date) {
            if (!date) return null

            const [year, month, day] = date.split('-')
            return `${year}-${month}-${day}`
        },

        checkFiles() {
            var input = $('#file');

            if (!input[0].files[0]) {
                this.snackbar = true
            } else {

                var data = {
                    'email': this.email,
                    'pass': this.password,
                    'datanascimento': this.computedDateFormatted,
                    'nome': this.name,
                    'username': this.username
                }

                this.$store.dispatch('users/insertUser', data).then(response => {
                    
                    var input = $("<input>")
                        .attr("type", "hidden")
                        .attr("name", "user").val(this.username);
                    $('#uploadPic').append(input);
                    $('#uploadPic').attr('action', 'http://localhost:3000/user/uploadProfilePic');
                    $('#uploadPic').submit();
                })

            }
        },

        checkForm() {
            if (this.$refs.form.validate()) {
                this.dialog = true;
            }
        },

        resetForm() {
            //this.$refs.form.reset()
            this.dialog = false;
        },

        removeUpload() {
            var input = $('#file');
            input.val("")
            console.log(input)
            $('.file-upload-content').hide();
            $('.image-upload-wrap').show();
        },

        readURL(event) {
            var input = $('#file');

            if (input[0].files[0]) {

                this.selectedFile = event.target.files[0];

                var reader = new FileReader();

                reader.onload = function () {

                    $('.image-upload-wrap').hide();
                    $('.file-upload-image').attr('src', reader.result);
                    $('.file-upload-content').show();
                    $('.image-title').html(input[0].files[0].name);
                };

                reader.readAsDataURL(input[0].files[0]);

            } else {
                $('.file-upload-input').replaceWith($('.file-upload-input').clone());
                $('.file-upload-content').hide();
                $('.image-upload-wrap').show();
            }
        }

    },

}

$('.image-upload-wrap').bind('dragover', function () {
    $('.image-upload-wrap').addClass('image-dropping');
});

$('.image-upload-wrap').bind('dragleave', function () {
    $('.image-upload-wrap').removeClass('image-dropping');
});
</script>

<style scoped>
#registar {
    height: 50px;
    color: white !important;
}

#cancelar{
    color: white !important;
}

.file-upload {
    background-color: #ffffff;
    width: 600px;
    margin: 0 auto;
    padding: 20px;
}

.file-upload-btn {
    width: 100%;
    margin: 0;
    color: #fff;
    background: #f25a78;
    border: none;
    padding: 10px;
    border-radius: 4px;
    border-bottom: 4px solid #f25a78;
    transition: all .2s ease;
    outline: none;
    text-transform: uppercase;
    font-weight: 700;
}

.file-upload-btn:hover {
    background: #1AA059;
    color: #ffffff;
    transition: all .2s ease;
    cursor: pointer;
}

.file-upload-btn:active {
    border: 0;
    transition: all .2s ease;
}

.file-upload-content {
    display: none;
    text-align: center;
}

.file-upload-input {
    position: absolute;
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    outline: none;
    opacity: 0;
    cursor: pointer;
}

.image-upload-wrap {
    margin-top: 20px;
    border: 4px dashed #22313f;
    position: relative;
}

.image-dropping,
.image-upload-wrap:hover {
    background-color: #f2f1ef;
    border: 4px dashed #22313f;
}

.image-title-wrap {
    padding: 0 15px 15px 15px;
    color: #222;
}

.drag-text {
    text-align: center;
}

.drag-text h3 {
    font-weight: bold;
    text-transform: uppercase;
    color: #22313f;
    padding: 60px 0;

}

.file-upload-image {
    max-height: 200px;
    max-width: 200px;
    margin: auto;
    padding: 20px;
}

.remove-image {
    width: 200px;
    margin: 0;
    color: #fff;
    background: #cd4535;
    border: none;
    padding: 10px;
    border-radius: 4px;
    border-bottom: 4px solid #b02818;
    transition: all .2s ease;
    outline: none;
    text-transform: uppercase;
    font-weight: 700;
}

.remove-image:hover {
    background: #c13b2a;
    color: #ffffff;
    transition: all .2s ease;
    cursor: pointer;
}

.remove-image:active {
    border: 0;
    transition: all .2s ease;
}
</style>
