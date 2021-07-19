<template>
  <div id="app">
    <v-app>
      <contact/>
    </v-app>
  </div>
</template>

<script>
import contact from "./packs/components/contact.vue";
export default {
  data: function() {
    return {
      message: "Hello Vue!"
    };
  },
  components: {
    contact: contact
  }
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
