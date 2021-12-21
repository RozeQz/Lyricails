let last = {};
document.addEventListener('DOMContentLoaded',() =>{
  document.querySelectorAll('audio').forEach(function(el){
    el.addEventListener('playing', function(){
      if (last.pause && last !== this)
        last.pause()
      last = this
    }); 
  })
})