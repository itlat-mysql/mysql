const socket = io()
import { createApp, ref } from 'https://unpkg.com/vue@3/dist/vue.esm-browser.js'

createApp({
    created() {
        this.init()
        socket.on('reload-messages', () => {
            if (this.authenticated) {
                this.loadMessages()
            }
        })
    },
    data() {
        return {
            messages: ref([]),
            loading: true,
            authenticated: false,
            authMode: 'login',
            messageContent: '',
            username: '',
            credentials: {
                register: {username: '', password: ''},
                login: {username: '', password: ''}
            },
            notifications: {successes: [], errors:  []}
        }
    },
    methods: {
        init() {
            this.ajax('/check-login', null, (data) => {
                this.loading = false
                if (data.username) {
                    this.username = data.username
                    this.authenticated = true
                    this.loadMessages()
                }
            })
        },
        loadMessages() {
            this.ajax('/load-messages', null, (data) => {
                if (data.messages) {
                    this.messages = data.messages
                } else if (data.errors) {
                    this.showErrorNotification(data.errors)
                }
            })
        },
        submitMessage() {
            const body = new URLSearchParams({message: this.messageContent})
            this.ajax('/add-message', body, (data) => {
                if (data.success) {
                    this.messageContent = ''
                    this.showSuccessNotification('Message has been added successfully.')
                    socket.emit('new-message')
                } else if (data.errors) {
                    this.showErrorNotification(data.errors)
                }
            })
        },
        showRegistrationForm() {
            this.authMode = 'register'
        },
        showLoginForm() {
            this.authMode = 'login'
        },
        register() {
            const body = new URLSearchParams({
                username: this.credentials.register.username,
                password: this.credentials.register.password
            })

            this.ajax('/register', body, (data) => {
                if (data.username) {
                    this.authenticated = true
                    this.username = data.username
                    this.showSuccessNotification('You have been successfully registered')
                    this.loadMessages()
                } else if (data.errors) {
                    this.showErrorNotification(data.errors)
                }
            })
        },
        login() {
            const body = new URLSearchParams({
                username: this.credentials.login.username,
                password: this.credentials.login.password
            })

            this.ajax('/login', body, (data) => {
                if (data.username) {
                    this.authenticated = true
                    this.username = data.username
                    this.showSuccessNotification('You have been successfully logged in')
                    this.loadMessages()
                } else if (data.errors) {
                    this.showErrorNotification(data.errors)
                }
            })
        },
        showErrorNotification(errors) {
            this.notifications.errors = Array.isArray(errors) ? errors : [errors]
            this.showNotification('error-notification')
        },
        showSuccessNotification(success) {
            this.notifications.successes = Array.isArray(success) ? success : [success]
            this.showNotification('success-notification')
        },
        showNotification(id) {
            const toast = document.getElementById(id)
            const toastBootstrap = bootstrap.Toast.getOrCreateInstance(toast)
            toastBootstrap.show()
        },
        ajax(path, body, success = () => {}, error = (e) => { console.log(e) }, always = () => {}) {
            fetch(path, {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: body
            }).then((response) => {
                return response.json()
            }).then(success).catch(error).finally(always)
        }
    }
}).mount('#app')