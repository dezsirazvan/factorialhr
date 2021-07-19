<template>
  <div id="app">
    <v-app>
      <navbar></navbar>
    <router-view></router-view>
    </v-app>
  </div>
</template>

<script>
import navbar from "./packs/components/navbar";
export default {
  data: function() {
    return {
      message: "Hello Vue!"
    };
  },
  components: {
    navbar: navbar
  }
};
</script>

<style scoped>
</style>
