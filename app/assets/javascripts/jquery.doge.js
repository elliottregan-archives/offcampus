//  wow
(function($) {
    //  such plugin
    $.doge = function(tings) {
        //  very jquery
        var doge = $('body').css('font-family', 'Comic Sans MS, Comic Sans, Chalkboard, cursive');
        
        //  much array
        tings = $.extend(['doge', 'shibe', 'excite', 'impress', 'skill', 'warn'], tings);
        
        var r = function(arr) {
            if(!arr) arr = tings; return arr[Math.floor(Math.random() * arr.length)];
        };
        
        var dogefix = [
            'wow', 'such ' + r(), 'very ' + r(), 'much ' + r(),
            'wow', 'such ' + r(), 'very ' + r(), 'much ' + r(),
            'so ' + r(), 'many ' + r(), 'want ' + r(),
            'wow', 'wow'
        ];
        
        var very = doge.append('<div class="such overlay" />').children('.such.overlay').css({
            position: 'fixed',
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            pointerEvents: 'none'
        });
        
        $('img').each(function() {
            $(this).attr('src', 'https://images.encyclopediadramatica.es/3/3e/Doge_full_image.jpg');
        });
     
        setInterval(function() {
            
            $('.such.overlay').append(
                '<span style="position: absolute; left: ' + Math.random()  *100 + '%;top: ' + Math.random()  *100 + '%;font-size: ' + Math.max(24, (Math.random() * 50 + 50)) + 'px; color: rgb(' + Math.round(Math.random() * 255) + ', ' + Math.round(Math.random() * 255) + ', ' + Math.round(Math.random() * 255) + ');">'
                    + r(dogefix) +
                '</span>');        
        }, 700);
    };
})(jQuery);