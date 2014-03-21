// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .


// корзика
var cartState = false;
function cart() {
    if (!cartState) {
        $('#cart_items').show().css('margin-top', '-' + $('#cart_items').height() + 'px').animate({
            marginTop: 0
        }, {
            duration: 250,
            specialEasing: {
                marginTop: 'linear'
            },
            complete: function () {
                cartState = true;
                $('#cart_items').find('.cart_scroller').animate({
                    scrollTop: $('#cart_items').find('.cart_scroller table').height() + 'px'
                }, 'fast');
            }
        });
        //$('#cart_items').show('blind', function(){cartState = true});
        //			$('#cart_items').find('.cart_scroller').animate({scrollTop: $('#cart_items').find('.cart_scroller').height() +'px'}, 'fast');
        $('#cart_title').addClass('closed');
    } else {
        $('#cart_items').animate({
            marginTop: '-' + $('#cart_items').height() + 'px'
        }, {
            duration: 250,
            specialEasing: {
                marginTop: 'linear'
            },
            complete: function () {
                $(this).hide();
                cartState = false;
            }
        });
        //$('#cart_items').hide('blind', function(){cartState = false});
        $('#cart_title').removeClass('closed');
    }
}


