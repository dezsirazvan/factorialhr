<template>
  <div>
    <v-data-table :headers="headers" :items="metrics" class="elevation-1">
      <template v-slot:top>
        <v-toolbar flat color="white">
          <v-toolbar-title>Metrics</v-toolbar-title>
          <v-divider class="mx-4" inset vertical></v-divider>
          <v-spacer></v-spacer>
          <v-dialog v-model="dialog" max-width="500px">
            <template v-slot:activator="{ on }">
              <v-btn color="primary" dark class="mb-1 mr-2" v-on="on">New Metric</v-btn>
              <date-picker v-model="selectedTime" class="mr-5" valueType="format" range></date-picker>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">{{ formTitle }}</span>
              </v-card-title>

              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field v-model="editedItem.name" label="Name"></v-text-field>
                    </v-col>
                    <v-col cols="12" sm="6" md="4">
                      <v-text-field v-model="editedItem.value" label="Value"></v-text-field>
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
        </v-toolbar>
      </template>
      <template v-slot:[`item.action`]="{ item }">
        <v-icon small class="mr-2" @click="editItem(item)">edit</v-icon>
        <v-icon small @click="deleteItem(item)">delete</v-icon>
      </template>
      <template v-slot:no-data>
        <v-btn color="primary" @click="initialize">Reset</v-btn>
      </template>
    </v-data-table>
    <h1 class="mt-5 ml-12"> Timeline </h1>
    <v-select class="mt-5" :items="averageTypes" v-model="averageType" label="Day/Minute/Second Timeline"></v-select>
    <timeline class="mt-5" v-for="(item, i) in timelines" :key="i">
      <timeline-title> Average per {{averageType}} in {{ item.date }} is: {{ item.average }}</timeline-title>
      <v-list-item v-for="(item, i) in item.metrics" :key="i">
          <timeline-item bg-color="#9dd8e0">{{item}}</timeline-item>
      </v-list-item>
    </timeline>
  </div>
</template>

<script>
  import axios from "axios";
  import DatePicker from 'vue2-datepicker';
  import 'vue2-datepicker/index.css';
  import { Timeline, TimelineItem, TimelineTitle } from 'vue-cute-timeline'
  export default {
    components: { 
      DatePicker, 
      Timeline,
      TimelineItem,
      TimelineTitle 
    },
    data: () => ({
      timelines: [],
      averageTypes: ['day', 'minute', 'second'],
      averageType: 'day',
      selectedTime: null,
      dialog: false,
      baseUrl: "http://localhost:3000/api/v1",
      headers: [
        {
          text: "Name",
          align: "left",
          sortable: false,
          value: "name"
        },
        { text: "Value", value: "value" },
        { text: "Created_at", value: "created_at" },
        { text: "Actions", value: "action", sortable: false }
      ],
      metrics: [],
      editedIndex: -1,
      editedItem: {
        name: "",
        value: 0
      },
      defaultItem: {
        name: "",
        value: 0
      }
    }),

    computed: {
      formTitle() {
        return this.editedIndex === -1 ? "New Item" : "Edit Item";
      }
    },

    watch: {
      dialog(val) {
        val || this.close();
      },
      selectedTime(val) {
        this.initialize(val[0], val[1])
      },
      averageType(val) {
        this.getTimeline()
      }
    },

    created() {
      this.initialize(null, null);
    },

    methods: {
      initialize(fromDate, toDate) {
        return axios
          .get(`${this.baseUrl}/metrics`,
          { params: { from_date: fromDate, to_date: toDate } })
          .then(response => {
            console.log(response.data);
            this.metrics = response.data;
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
        const index = this.metrics.indexOf(item);
        if (confirm("Are you sure you want to delete this item?")) {
          axios
            .delete(`${this.baseUrl}/metrics/${item.id}`)
            .then(response => {
              alert(response.data.message);
              this.initialize(null, null);
            })
            .catch(error => {
              console.log(error);
            });
          this.metrics.splice(index, 1);
          } else {
            return
          }
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
            .put(`${this.baseUrl}/metrics/${item.id}`, {
              id: this.editedItem.id,
              name: this.editedItem.name,
              value: this.editedItem.value
            })
            .then(response => {
              console.log(response);
              this.initialize(null, null);
            })
            .catch(error => {
              alert(error.message);
            });
        } else {
          console.log(item);
          axios
            .post(`${this.baseUrl}/metrics/`, {
              metric: this.editedItem
            })
            .then(response => {
              this.initialize(null, null);
              this.metrics.push(this.editedItem);
            })
            .catch(error => {
              alert(error.message);
            });
        }
        this.close();
      },

      getMetric(item) {
        axios
          .get(`${this.baseUrl}/metrics/${item.id}`)
          .then(response => {
            this.metric = response.data;
          })
          .catch(error => {
            console.log(error);
          });
      },

      getTimeline() {
        var fromDate = null;
        var toDate = null;
        
        if (this.selectedTime !== null){
          fromDate = this.selectedTime[0],
          toDate = this.selectedTime[1]
        }

        axios
          .get(`${this.baseUrl}/metrics/timeline`, { params: { from_date: fromDate, to_date: toDate, average_type: this.averageType } })
          .then(response => {
            this.timelines = response.data;
          })
          .catch(error => {
            console.log(error);
          });
      }
    }
  };
</script>

<style scoped>
  .v-select{
      max-width: 200px;
      margin-left: 50px
  }
</style>
