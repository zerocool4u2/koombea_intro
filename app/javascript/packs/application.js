// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import 'bootstrap';
// import 'moment';
// import 'tempusdominus-bootstrap-4';
import 'cocoon-js'
// import './forms';

import '../stylesheets/application'

Rails.start();
Turbolinks.start();
ActiveStorage.start();

$(document).on('turbolinks:load', function() {
    function() {
       console.log("Hello World!");
   }
};
