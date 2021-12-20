// jQuery(function($) {
//   $('.destroy-post').on('click', function(){
//     if (confirm('Are you sure?')){
//       $.ajax({
//         url: '/posts/'+ $(this).attr('id'),
//         method: 'DELETE'
//       }).done(function(response){
//         console.log(response);
//       })
//     }
//   })
// });

// jQuery(function($) {
//   $(".post-like").on("click", function(){
//     $.ajax({
//       url: '/post/like/'+$(this).data("id"),
//       method: 'GET'
//     }).done(function(response){
//       console.log(response);
//     })
//   })
// });

//const track = document.querySelector('#track');

// import WaveSurfer from 'wavesurfer.js';


// var wavesurfer = WaveSurfer.create({
//   container: this.$refs.waveform,
//   waveColor: '#eee',
//   progressColor: 'orange',
//   barWidth: 2,
//   responsive: true,
//   hideScrollbar: true,
//   barRadius: 4
// });

// wavesurfer.on('ready', function() {
//   wavesurfer.play();
// });

// wavesurfer.load('../assets/audio/GunsNRoses-ThisILove.mp3');

// const playBtn = document.querySelector(".play-btn");
// const stopBtn = document.querySelector(".stop-btn");
// const muteBtn = document.querySelector(".mute-btn");
// const volumeSlider = document.querySelector(".volume-slider");

// playBtn.addEventListener("click", () => {
//   audioTrack.playPause();

//   if (audioTrack.isPlaying()) {
//     playBtn.classList.add("playing");
//   } else {
//     platBtn.classList.remove("playing");
//   }
// });

// stopBtn.addEventListener("click", () => {
//   audioTrack.stop();
//   playBtn.classList.remove("playing");
// });

// volumeSlider.addEventListener("mouseup", () => {
//   changeVolume(volumeSlider.value);
// });

// const changeVolume = (volume) => {
//   if (volume == 0) {
//     muteBtn.classList.add("muted");
//   } else {
//     muteBtn.classList.remove("muted");
//   }

//   audioTrack.setVolume(volume);
// };

// muteBtn.addEventListener("click", () => {
//   if (muteBtn.classList.contains("muted")) {
//     muteBtn.classList.remove("muted");
//     audioTrack.setVolume(0.5);
//     volumeSlider.value = 0.5;
//   } else {
//     audioTrack.setVolume(0);
//     muteBtn.classList.add("muted");
//     volumeSlider.value = 0;
//   }
// });
