jQuery(document).ready(function() {
    var input = jQuery('textarea[name="micropost[content]"]');
    var notice = jQuery('span.character_left');
    if (input) {
        var count_input = function(input){
            var left = 140 - jQuery(input).val().length;
            if (left > 1)
                var string = left + ' characters left';
            else if (left < 0)
                var string = '<span style="color: red">' + left + ' character left </span>';
            else
                var string = left + ' character left';
            notice.html(string);
        };
        input.keydown(function(){count_input(this)});
        input.keyup(function(){count_input(this)});
        count_input(input);
    }
});