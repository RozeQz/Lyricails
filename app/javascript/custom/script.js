let last = {};
document.addEventListener('DOMContentLoaded',() =>{
  document.querySelectorAll('audio').forEach(function(el){
    console.log('forEach')
    el.addEventListener('playing', function(){
      if (last.pause && last !== this)
        last.pause()
      last = this
    }); 
  })
})