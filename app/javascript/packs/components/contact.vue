<template>
  <v-data-table :headers="headers" :items="contacts" sort-by="calories" class="elevation-1">
    <template v-slot:top>
      <v-toolbar flat color="white">
        <v-toolbar-title>Contacts CRUD</v-toolbar-title>
        <v-divider class="mx-4" inset vertical></v-divider>
        <v-spacer></v-spacer>
        <v-dialog v-model="dialog" max-width="500px">
          <template v-slot:activator="{ on }">
            <v-btn color="primary" dark class="mb-2" v-on="on">New Contact</v-btn>
          </template>
          <v-card>
            <v-card-title>
              <span class="headline">{{ formTitle }}</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.first_name" label="First Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.last_name" label="Last Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.email" label="Email"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field v-model="editedItem.phone_number" label="Phone"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
              <v-btn color="blue darken-1" text @click="save(editedItem)">Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <v-dialog v-model="showDialog" max-width="500px">
          <v-card>
            <v-card-title>
              <span class="headline">Show Contact</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                <v-row>
                  <v-col cols="12" sm="6" md="12">
                    <v-text-field :readonly="true" v-model="editedItem.first_name" label="First Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="12">
                    <v-text-field :readonly="true" v-model="editedItem.last_name" label="Last Name"></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="12">
                    <v-text-field :readonly="true" v-model="editedItem.email" label="Email"></v-text-field>
                  </v-col>
                  <v-col cols="12" :readonly="true" sm="6" md="12">
                    <v-text-field v-model="editedItem.phone_number" label="Phone"></v-text-field>
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeShowDialog">Cancel</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <v-dialog v-model="showChangesDialog" max-width="1000px">
          <v-card>
            <v-card-title>
              <span class="headline">Changes History</span>
            </v-card-title>
            <v-card-text>
              <v-container>
                 <v-list-item
                    v-for="(item, i) in changesHistory"
                    :key="i">
                    {{i+1}}: {{ item }}
                 </v-list-item>
              </v-container>
            </v-card-text>

            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="blue darken-1" text @click="closeChangesDialog">Cancel</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
      </v-toolbar>
    </template>
    <template v-slot:[`item.action`]="{ item }">
      <v-icon small class="mr-2" @click="getContact(item)">show</v-icon>
      <v-icon small class="mr-2" @click="editItem(item)">edit</v-icon>
      <v-icon small @click="deleteItem(item)">delete</v-icon>
      <v-icon small class="mr-2" @click="showChanges(item)">changes</v-icon>
    </template>
    <template v-slot:no-data>
      <v-btn color="primary" @click="initialize">Reset</v-btn>
    </template>
  </v-data-table>
</template>

<script>
import axios from "axios";

export default {
  data: () => ({
    baseUrl: "http://localhost:3000/api/v1",
    showDialog: false,
    showChangesDialog: false,
    changesHistory: [],
    dialog: false,
    headers: [
      {
        text: "First Name",
        align: "left",
        sortable: false,
        value: "first_name"
      },
      { text: "Last Name", value: "last_name" },
      { text: "Email", value: "email" },
      { text: "Phone Number", value: "phone_number" },
      { text: "Actions", value: "action", sortable: false }
    ],
    contacts: [],
    editedIndex: -1,
    editedItem: {
      first_name: "",
      last_name: "",
      email: "",
      phone_number: ""
    },
    defaultItem: {
      first_name: "",
      last_name: "",
      email: "",
      phone_number: ""
    }
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Contact" : "Edit Contact";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  created() {
    this.initialize();
  },

  methods: {
    initialize() {
      return axios
        .get(`${this.baseUrl}/contacts`)
        .then(response => {
          console.log(response.data);
          this.contacts = response.data;
        })
        .catch(e => {
          console.log(e);
        });
    },

    editItem(item) {
      this.editedIndex = item.id;
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },
    deleteItem(item) {
      const index = this.contacts.indexOf(item);
      if(confirm("Are you sure you want to delete this item?")) {
        axios
        .delete(`${this.baseUrl}/contacts/${item.id}`)
        .then(response => {
          alert(response.data.message);
          this.initialize();
        })
        .catch(error => {
          console.log(error);
        });
        this.contacts.splice(index, 1);
      }else{
        return
      }
    },
    closeShowDialog() {
      this.showDialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },
    closeChangesDialog() {
      this.showChangesDialog = false;
    },
    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },

    save(item) {
      if (this.editedIndex > -1) {
        axios
          .put(`${this.baseUrl}/contacts/${item.id}`, {
            id: this.editedItem.id,
            first_name: this.editedItem.first_name,
            last_name: this.editedItem.last_name,
            email: this.editedItem.email,
            phone_number: this.editedItem.phone_number
          })
          .then(response => {
            console.log(response);
            this.initialize();
          })
          .catch(error => {
            console.log(error);
          });
      } else {
        console.log(item);
        axios
          .post(`${this.baseUrl}/contacts/`, {
            contact: this.editedItem
          })
          .then(response => {
            this.initialize();
            this.contacts.push(this.editedItem);
          })
          .catch(error => {
            console.log(error);
          });
      }
      this.close();
    },

    getContact(item) {
      axios
        .get(`${this.baseUrl}/contacts/${item.id}`)
        .then(response => {
            this.editedIndex = response.data.id;
            this.editedItem = Object.assign({}, response.data);
            this.showDialog = true;
        })
        .catch(error => {
          console.log(error);
        });
    },
    showChanges(item) {
      axios
        .get(`${this.baseUrl}/contacts/${item.id}/versions`)
        .then(response => {
          this.showChangesDialog = true;
           this.changesHistory = response.data.data;
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>
