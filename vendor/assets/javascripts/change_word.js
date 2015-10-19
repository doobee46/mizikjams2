(function(){
    var words = [
        'Kompa',
        'Zouk',
        'HipHop Kreyol',
        'Roots'
        ], i = 0;
    setInterval(function(){
        $('#change').fadeOut(function(){
            $(this).html(words[i=(i+1)%words.length]+" " + "musics").fadeIn();
        });
    }, 2000);
        
})();