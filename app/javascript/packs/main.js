import Vue from 'vue'
import Vuetify from 'vuetify'
import VueRouter from 'vue-router'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import App from '../app.vue'
import Contact from './components/contact'
import Metrics from './components/metrics'

Vue.use(Vuetify)
Vue.use(VueRouter)

const router = new VueRouter({
  routes: [
    { path: '/contacts', component: Contact },
    { path: '/metrics', component: Metrics }
  ]
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router: router,
    vuetify: new Vuetify(),
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
