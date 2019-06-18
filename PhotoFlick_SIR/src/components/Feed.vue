<template>
<div>

    <fab :position="'bottom-right'" :bg-color="'#f25a78'" :actions="fabActions" @addPhoto="addPhoto"></fab>
    <div v-for="(post, index) in getPosts" v-bind:key="index" class="container">
        <div class="row justify-content-center">
            <div class="col-6 text-center">
                <v-hover>
                    <v-card slot-scope="{ hover }" :class="`elevation-${hover ? 12 : 2}`" :style="{ cursor: 'pointer'}">
                        <v-card-title>
                            <v-avatar slot="activator" size="36px">
                                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + post.fotouser" alt="Avatar" width="36" height="36" v-if="post.fotouser != null">
                        </v-avatar>
                                <span class="subheading font-weight-bold ml-3" @click="userPage(post.username)">{{post.username}}</span>
                                <v-spacer></v-spacer>
                                <v-icon>location_on</v-icon>
                                <span class="subheading font-weight-light">{{post.localizacao}}</span>
                        </v-card-title>
                        <v-img class="white--text" height="300px" :src="'http://localhost:3000/public/uploads/posts/' + post.fotopub" @click="changeImage(post.fotopub)">
                        </v-img>
                        <v-card-actions>
                            <v-btn class="btnActions" flat icon color="#f03434" @click="addLike(post.id_publicacao, post.hasGosto)">
                                <v-icon>{{checkLike(post.hasGosto)}}</v-icon>
                            </v-btn>
                            <span class="font-weight-bold" :style="{ cursor: 'pointer'}" v-if="post.nr_gostos > 0" @click="getLikes(post.id_publicacao,post)">{{post.nr_gostos}} gosto(s)</span>
                            <v-spacer></v-spacer>
                            <v-btn class="btnActions" flat icon color="#abb7b7" @click="getComments(post.id_publicacao,post)">
                                <v-icon>comment</v-icon>
                            </v-btn>
                        </v-card-actions>
                        <v-card-actions class="pl-4">
                            <span class="body-1 font-weight-bold mr-2">{{post.username}}</span>
                            <span class="body-1 font-weight-light">{{post.descricao}}</span>
                        </v-card-actions>
                        <v-slide-y-transition>
                            <v-card-text v-show="post.coment_show">
                                <div v-for="(coment, i) in post.comentarios" v-bind:key="i" style="max-height:100px!important" class="pl-3">
                                    <div class="container text-left" style="padding:0px!important">
                                        <div class="row justify-content-start">
                                            <div class="col-2">
                                                <span class="body-1 font-weight-bold">{{coment.username}}</span>
                                            </div>
                                            <div class="col-8">
                                                <span class="body-1 font-weight-light">{{coment.comentario}}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="container text-left mt-4" style="padding:0px!important">
                                    <div class="row justify-content-start">
                                        <div class="col-1 mt-3">
                                            <v-avatar slot="activator" size="36px">
                                                <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + getUser.foto" alt="Avatar" width="36" height="36" v-if="getUser.foto != null">
                                            </v-avatar>
                                        </div>
                                        <div class="col-11">
                                            <v-text-field v-model="comentario" :id="post.id_publicacao" :single-line="true" counter="200" color="#f25a78" placeholder="Adicionar um comentário ..." append-outer-icon="send" @click:append-outer="addComment(post.id_publicacao)" v-on:keyup.enter="addComment(post.id_publicacao)"></v-text-field>
                                        </div>
                                    </div>
                                    <div class="row justify-content-start">
                                        <div class="col-12 mt-3">
                                            <span class="body-1 font-weight-thin">{{getDate(post.data)}}</span>
                                        </div>
                                    </div>
                                </div>
                            </v-card-text>
                        </v-slide-y-transition>
                    </v-card>
                </v-hover>
            </div>
            <div class="text-xs-center">
                <v-dialog v-model="post.dialog_likes" scrollable width="450">
                    <v-card>
                        <v-card-title class="headline #f03434 font-weight-light">
                            <v-icon color="#f03434" class="mr-2">favorite</v-icon>Gostos na publicação
                            <v-spacer></v-spacer>
                            <v-icon color="#000" class="mr-2" @click="post.dialog_likes = false" :style="{ cursor: 'pointer'}">close</v-icon>
                        </v-card-title>

                        <v-card-text style="padding-top:0px;max-height: 200px!important;">
                            <div class="container" style="padding-top:10px;padding-bottom:5px" v-for="(like, i) in post.likes" v-bind:key="i">
                                <div class="row justify-content-start">
                                    <div class="col-10">
                                        <v-avatar slot="activator" size="30px">
                                            <img id="profile" :src="'http://localhost:3000/public/uploads/profile/' + like.foto" alt="Avatar" v-if="like.foto != null">
                                        </v-avatar>
                                            <span class="subheading font-weight-light ml-3" :style="{ cursor: 'pointer'}" @click="userPage(like.username)" >{{like.username}}</span>
                                    </div>
                                </div>
                            </div>
                        </v-card-text>
                    </v-card>
                </v-dialog>
            </div>
            <div class="text-xs-center">
                <v-dialog v-model="dialog_image" width="900">
                    <v-card>
                        <v-card-text style="padding:0px">
                            <v-img class="white--text" height="500px" :src="imageDialog"></v-img>
                        </v-card-text>
                    </v-card>
                </v-dialog>
            </div>
        </div>
    </div>
    <v-layout row justify-center>
        <v-dialog v-model="dialog_add" persistent max-width="700px">
            <v-card>
                <v-card-title>
                    <span class="headline">Adicionar publicação</span>
                </v-card-title>
                <v-card-text>
                    <v-container grid-list-md>
                        <v-layout wrap>
                            <v-flex xs12>
                                <v-text-field v-model="localizacao" color="#f25a78" prepend-icon="place" label="Localização" required></v-text-field>
                            </v-flex>
                            <v-flex xs12 sm6 md12>
                                <v-textarea v-model="descricao" color="#f25a78" auto-grow outline name="descricao" label="Descrição" placeholder="Máximo 300 carateres" :counter="300" :rules="descRules" required></v-textarea>
                            </v-flex>
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
                    <v-btn color="#22313f" flat @click="reset()">Cancelar</v-btn>
                    <v-btn color="#f25a78" flat @click="checkFiles">Publicar</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <v-snackbar v-model="snackbar" color="error" :multi-line="false" :timeout="6000" :top="true">
            Obrigatório fazer upload de imagem para publicação
            <v-btn dark flat @click="snackbar = false">
                Fechar
            </v-btn>
        </v-snackbar>
    </v-layout>
</div>
</template>

<script>
    

/* eslint-disable */
import {
    mapState,
    mapMutations,
    mapActions,
    mapGetters
} from 'vuex'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import moment from 'moment'
import fab from 'vue-fab'
moment.locale('pt')

export default {
    components: {
        fab
    },
    data: () => ({
        user: '',
        comentario: '',
        imageDialog: '',
        snackbar: false,
        valid: false,
        localizacao: '',
        descricao: '',
        like: 'favorite_border',
        color: '#abb7b7',
        dialog: false,
        dialog_add: false,
        dialog_image: false,
        comments: false,
        descRules: [
            v => !!v || 'Descrição é um campo obrigatório',
            v => v.length <= 300 || 'A descrição deve conter menos de 300 carateres'
        ],
        rules: [v => v.length <= 200 || 'Máximo 200 carateres'],
        fabActions: [{
            name: 'addPhoto',
            icon: 'photo_camera',
            tooltip: 'Adicionar publicação'
        }]
    }),
    beforeCreate: function () {
        if (!this.$session.exists()) {
            this.$router.push('/')
        } else {
            this.$store.dispatch('session/setUser', this.$session.get('id')).then(() => {
                this.$store.dispatch('posts/setPosts', this.getUser.id_user)
            })
        }
    },
    created() {
        this.$store.dispatch('posts/setPosts', this.getUser.id_user)
    },
    computed: {

        ...mapGetters({
            getUser: 'session/getUser',
            getPosts: 'posts/getPosts'
        })
    },
    methods: {
        addLike(id, hasLike) {

            if (hasLike != 1) {
                var data = {
                    'data': moment().format('DD-MM-YYYY HH:mm:ss'),
                    'id_publicacao': id,
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('posts/insertLike', data).then(response => {
                    this.$store.dispatch('posts/setPosts', this.getUser.id_user)
                })
            } else {
                var data = {
                    'id_publicacao': id,
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('posts/deleteLike', data).then(response => {
                    this.$store.dispatch('posts/setPosts', this.getUser.id_user)
                })
            }

        },
        getComments(id, obj) {
            this.$store.dispatch('posts/setComments', id).then(id => {
                obj.coment_show = !obj.coment_show
            })
        },
        getLikes(id, obj) {
            this.$store.dispatch('posts/setLikes', id, obj).then(response => {
                obj.dialog_likes = true
                return response.length;
            })
        },
        addComment(id) {
            var coment = $('#' + id);
            if (coment.val().length > 0) {
                var data = {
                    'comentario': coment.val(),
                    'id_publicacao': id,
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('posts/insertComment', data).then(response => {
                    this.$store.dispatch('posts/setComments', id).then(() => {
                        this.comentario = ''
                    })
                })

            } else {
                return;
            }
        },
        getDate(data) {
            return moment(data, "DD-MM-YYYY HH:mm:ss").fromNow();
        },
        checkLike(hasLike) {
            if (hasLike == 1) {
                return 'favorite';
            } else {
                return 'favorite_border';
            }
        },
        userPage(username) {
            this.$router.push('/UserPage/' + username)
        },
        addPhoto() {
            this.dialog_add = true;
        },

        // *** UPLOAD FOTOS *** ///
        checkFiles() {
            var input = $('#file');
            this.dialog_add = false;

            if (!input[0].files[0]) {
                this.snackbar = true
            } else {

                var foto = Math.random().toString(36).substring(2);

                var data = {
                    'descricao': this.descricao,
                    'data': moment().format('DD-MM-YYYY HH:mm:ss'),
                    'localizacao': this.localizacao,
                    'foto': foto + ".png",
                    'id_user': this.getUser.id_user
                }

                this.$store.dispatch('posts/insertPost', data).then(response => {

                    var input = $("<input>")
                        .attr("type", "hidden")
                        .attr("name", "foto").val(foto);
                    $('#uploadPic').append(input);
                    $('#uploadPic').attr('action', 'http://localhost:3000/posts/uploadPostPic');
                    $('#uploadPic').submit();
                })

            }
        },

        /*checkForm() {
            if (this.$refs.form.validate()) {
                this.dialog = true;
            }
        },*/

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
        },
        reset() {
            this.dialog_add = false;
            this.localizacao = this.descricao = '';
            this.removeUpload();
        },
        changeImage(src) {
            this.imageDialog = 'http://localhost:3000/public/uploads/posts/' + src
            this.dialog_image = true;
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
html,
body {
    margin: 0;
    height: 100%;
    overflow: hidden
}

#card-body {
    padding: 0px !important;
    margin-left: 15px;
}

#dialog-like {
    padding: 0px !important;
    margin-left: 15px;
}

.file-upload {
    background-color: #ffffff;
    width: 700px;
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
    max-height: 400px;
    max-width: 600px;
    margin: auto;
    padding: 10px;
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
