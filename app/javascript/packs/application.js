// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// import "wavesurfer"
// import 'bootstrap/js/dist/dropdown'

//= require jquary
//= require jquary_ujs
//= require rails-ujs

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap"
import "../stylesheets/application.scss"
// import "../../assets/stylesheets/application.scss"

require("../custom/script")
