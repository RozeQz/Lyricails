let last = {};
let audios = document.getElementsByTagName('audio')

document.addEventListener('DOMContentLoaded',() =>{
  document.querySelectorAll('audio').forEach(function(el){
    el.addEventListener('playing', function(){
      if (last.pause && last !== this)
        last.pause()
      last = this
    }); 
  })
  if (navigator.userAgent.indexOf("Firefox") != -1) {
  }
  else {
    for (let item of audios) {
      item.classList += ' not-a-mozilla'
    }
  }
})