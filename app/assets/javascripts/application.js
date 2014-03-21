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


// Положить в корзину
function addToCart(obj, id, card) {
    card = card == 'undefined' ? false : true;
    adding = true;
    $(obj).append('<img class="progress" src="/images/buy_progress.gif" alt="" />');
    if (card)
        var _data = 'cartState=' + (cartState ? '1' : '0') + '&qua=1&catalog_id=' + id + '&card=true';
    else
        var _data = 'cartState=' + (cartState ? '1' : '0') + '&qua=1&catalog_id=' + id;
    $.ajax({
        url: '/api/addCart.api.php',
        //data: 'cartState='+(cartState?'1':'0')+'&qua=1&catalog_id='+id,
        data: _data,
        success: function(data) {
            var cartDom = $(data);

            $('#top_cart').html(cartDom);

            //				if (!cartState) cart();

            $(obj).find('img.progress').remove();
            adding = false;

            var added = $('#cartObj' + id);

            $('#cart_items').find('.cart_scroller').animate({
                scrollTop: added.position().top + 'px'
            }, 'fast', function() {
                added.css('background', '#fff5f5') 
            });

            if (card)
                $('#inCart, #inCart2').show().html(cartDom.find('#cartObj' + id + ' input').val());

            if (!cartState) {
                $('#cart_items').hide();
                //					$('#cart_title').trigger('click');
                //					setTimeout(function () {
                //						$('#cart_title').trigger('click');
                //					}, 3000);
            }
        }
    });
}

// Обновить корзину
function updateCart(qua, id) {
    var type = (/cart\/profile$/.exec(location.href) || /cart\/profile\/delivery$/.exec(location.href) || /cart\/profile\/pay/.exec(location.href) || /cart\/profile\/confirm/.exec(location.href) ? 'full' : 'short');
    var show_only = (/cart\/profile\/confirm/.exec(location.href) ? '&show_only' : null);
    if (type == 'full') // обновить инфо о баллах
    {
        $.ajax({
            url: '/api/editCart.api.php',
            data: 'cartState=1&type=' + type + '&qua=' + qua + '&catalog_id=' + id + '&bonus_info',
            success: function(data) {
                $('body').append('<div style="display: none">' + data + '</div>');
                //					alert('delete');
                //					console.log(data)

                //						if($('div.tooltipContent'))
                //							$('div.tooltipContent').html(data);
                //if($('#cart_tip'))
                //	$('#cart_tip').html(data);
            }
        });
    }

    $.ajax({
        url: '/api/editCart.api.php',
        data: 'cartState=1&type=' + type + '&qua=' + qua + '&catalog_id=' + id,
        success: function(data) {
            if (data == 'empty')
                location.href = '/';
            else
                $('#top_cart').html(data);
        }
    });

    // bonus block

}

/**
	 * Обновить корзину с учетом баллов
	 *
	 * @param qua
	 * @param id
	 */
function updateCartBill(qua, id) {
    id = typeof id == "undefined"?-1 : id;
    var type = (/cart\/profile$/.exec(location.href) || /cart\/profile\/delivery$/.exec(location.href) || /cart\/profile\/pay/.exec(location.href) || /cart\/profile\/confirm/.exec(location.href) ? 'full' : 'short');
    var show_only = /cart\/profile\/confirm/.exec(location.href) ? "&show_only": "";
    // обновить инфо о баллах
    //		if (type=="full") {
    //			$.ajax({
    //				url:  "/api/editCart.api.php",
    //				data: "cartState=1&to_bill=Y&type="+type+"&qua="+qua+"&catalog_id="+id+"&bonus_info",
    //				success: function (data) {
    //					var temp = $("div.tooltipContent");
    //					if (temp.size()) {
    //						temp.html(data);
    //					}
    //				}
    //			});
    //		}
    $.ajax({
        url: "/api/editCart.api.php",
        data: "cartState=1&to_bill=Y&type=" + type + "&qua=" + qua + "&catalog_id=" + id,
        success: function (data) {
            if (data == "empty") {
                location.href = "/";
            } else {
                $("#top_cart").html(data);
                var container = $("#bonuspoints-payment-option");
                if (qua > 0) {
                    container.find("span.pay").hide();
                    container.find("span.cancel").show().find('strong').html(qua + " руб.");
                } else {
                    container.find("span.pay").show();
                    container.find("span.cancel").hide();
                }
            }
        }
    });
}

function getCartMaxBill(id) {
    type = (/cart\/profile$/.exec(location.href) || /cart\/profile\/delivery$/.exec(location.href) || /cart\/profile\/pay/.exec(location.href) || /cart\/profile\/confirm/.exec(location.href) ? 'full' : 'short');

    $.ajax({
        url: '/api/editCart.api.php',
        data: 'cartState=1&to_bill=Y&type=' + type + '&catalog_id=' + id + '&max_bill',
        success: function(data) {
            updateCartBill(data, id);
        }
    });
}

// Очистить корзину
function clearCart() {
    type = (/cart\/profile/.exec(location.href) || /cart\/profile\/delivery$/.exec(location.href) || /cart\/profile\/pay/.exec(location.href) || /cart\/profile\/confirm/.exec(location.href) ? 'full' : 'short');
    if (type == 'full') // обновить инфо о баллах
    {
        $.ajax({
            url: '/api/editCart.api.php',
            data: 'cartState=1&type=' + type + '&qua=' + qua + '&catalog_id=' + id + '&bonus_info',
            success: function(data) {
                if ($('div.tooltipContent'))
                    $('div.tooltipContent').html(data);
                //if($('#cart_tip'))
                //	$('#cart_tip').html(data);
            }
        });
    }

    $.ajax({
        url: '/api/resetCart.api.php',
        data: 'cartState=1&type=' + type,
        success: function(data) {
            if (data == 'empty')
                location.href = '/';
            else
                $('#top_cart').html(data);
        }
    });
}

// Прайслисты
function getPriceLists() {
    if (!document.getElementById('div-pricelists')) {
        var div = document.createElement('DIV');
        div.id = 'div-pricelists';
        div.className = 'pricelists';
        document.getElementsByTagName('BODY')[0].appendChild(div);
    } else {
        div = document.getElementById('div-pricelists');
    }
    jQuery.post('/api/pricelists.api.php', function(data, textStatus, XMLHttpRequest) {
        if (data.length) {
            div.innerHTML = data;
            div.style.display = 'block'
        }
    });
    return false;
}





// Звездочки
function observeRate(obj) {
    var oldStars = new Array();
    var ob = obj;

    $('#' + $(obj).attr('id') + ' img').each(function(index) {
        oldStars[index] = $(this).attr('src');
        $(this).bind('mouseover mouseout', function() {
            colorStars($(this));
        });
        $(this).click(function() {
            $.ajax({
                url: '/api/rate.api.php',
                data: 'id=' + $(this).parent().attr('id').replace('rate_div_', '') + '&rate=' + $(this).attr('alt'),
                context: $(this).parent(),
                success: function(data) {
                    $(this).html(data);
                    observeRate(ob);
                }
            });
        });
    });
}


function colorStars(obj) {
    catchObj = false;
    var co = obj;

    $('#' + $(obj).parent().attr('id') + ' img').each(function(index) {
        if (catchObj) 
            $(this).attr('src', '/images/top2grey.gif');
        else 
            $(this).attr('src', '/images/top2yellow.gif');
        if ($(co).attr('alt') == $(this).attr('alt')) 
            catchObj = true;
    });
}


// Строчки в ценах
function showLines(id, classname) {
    $('.' + classname).each(function() {
        if ($(this).hasClass("hidden"))
        {
            $(this).removeClass("hidden");
            $(this).addClass("open");
            $('#comparison').focus();
            $('#plus_' + id).attr('src', '/images/grey_minus.gif');
        } else
        {
            $(this).removeClass("open");
            $(this).addClass("hidden");
            $('#plus_' + id).attr('src', '/images/grey_plus.gif');
        }
    });
}


function hoveredActions() {
    //уменьшаем ширину акции
    if (parseInt($('.actions_list').css('width')) < (parseInt($('.actions_list li').css('width')) * $('.actions_list li').size())) {
        $('.actions_list').addClass('hovered');
        actionsWidth = Math.round(parseInt($('.actions_list').css('width')) / ($('.actions_list li').size()));
        actionsML = (parseInt($('.actions_list li').css('width')) - actionsWidth);
        actionsML = actionsML + 6 + Math.round((actionsML / $('.actions_list li').size()));
        $('.actions_list li').css('margin-left', '-' + actionsML + 'px');
        $('.actions_list li').first().css('margin-left', 0);
    }
}


// Cabinet

function hilightLoginButton() {
    if ($('#login-form-div input.text_input:first').val() != 'e-mail' && $('#login-form-div input.text_input[type="password"]').val())
    {
        if (!/_a.gif/.test($('#login-form-div input[type="image"]').attr('src')))
            $('#login-form-div input[type="image"]').attr('src', $('#login-form-div input[type="image"]').attr('src').replace(/.gif$/, '_a.gif'));
    } else
        $('#login-form-div input[type="image"]').attr('src', $('#login-form-div input[type="image"]').attr('src').replace(/_a.gif$/, '.gif'));
}

$(function() {
    if ($('#login-form-div input[type="password"]').size() > 0)
        $('#login-form-div input[type="password"]').passDefault();

    if ($('#login-password').size() > 0)
        $('#login-password').passDefault({
            t: 5,
            f: 1.2
        });

    if ($('#login-form-div input').size() > 0) {

        hilightLoginButton();

        $('#login-form-div input.text_input').keyup(function() {
            hilightLoginButton() 
        });
    }

    //	if ($('#reg-form-password, #reg-form-password2').size() > 0)
    //		{
    //		$('#reg-form-password').passDefault({t: 5, f: 1.2});
    //		$('#reg-form-password2').passDefault({t: 5, f: 1.2, l: 'Повторите пароль'});
    //		}

    //opt ++

    if ($('#reg-form-opt-password, #reg-form-opt-password2').size() > 0)
    {
        $('#reg-form-opt-password').passDefault({
            t: 5,
            f: 1.2
        });
        $('#reg-form-opt-password2').passDefault({
            t: 5,
            f: 1.2,
            l: 'Повторите пароль'
        });
    }
    // opt --

    if ($('.enter_cb').length > 0) {
        $('.enter_cb .enter_wrap_cb .enter_lnk_cb').click(function() {
            if ($(this).hasClass('enter_lnk_cb_already_in')) {
                window.location = '/cabinet';
            } else {
                $(this).css({
                    color: '#F3B3B1'
                })
                $('.enter_cb .enter_wrap_cb .enter_form_cb').toggle()
            }
            return false;
        }).hover(function() {
            if ($('.enter_form_cb').is(':visible')) 
                return false;
            $(this).css({
                color: '#fff'
            }) 
        }, function() {
            $(this).css({
                color: '#F3B3B1'
            }) 
        });
        $('.enter_cb .enter_wrap_cb .enter_form_cb .enter_form_wrap_cb .close').click(function() {
            $('.enter_cb .enter_wrap_cb .enter_form_cb').hide()
            return false;
        })
    }
    if ($('.js_save_input').length > 0) {
        $('.js_save_input input[type="text"]').inputDefault();
        $('.js_save_input textarea').inputDefault();
    }
    if ($('.enter_form_wrap_cb').length > 0) {
        $('.enter_form_wrap_cb input[type="text"]').inputDefault();
    }
    if ($('.table_zacaz_cb').length > 0) {
        $.each($('.table_zacaz_cb'), function(i, n) {
            var e = $(n)
            /*				e.find(".sum span").tooltip({ 
            					track: true, 
            					delay: 1, 
            					showURL: false, 
            					opacity: 1,  
            					showBody: " - ", 
            					extraClass: "tt_top", 
            					top: 15, 
            					left: -130 ,
            				//	bodyHandler:content_tt_make
            					bodyHandler: function(){
            						var id  = this.parentNode.parentNode.parentNode.parentNode.parentNode.id.replace('my-order-','');
            						var out = $("#my-order-"+id+"-product-info").html();
            						return out;
            					}
            				}); 
            */

            e.find('span.product-info').toggle(
            function()
            {
                var id = $(this).parentsUntil('div.pink_box_cb').parent().attr('id').replace('my-order-', '');
                $("#my-order-" + id + "-product-info").slideDown();
            },

            function()
            {
                var id = $(this).parentsUntil('div.pink_box_cb').parent().attr('id').replace('my-order-', '');
                $("#my-order-" + id + "-product-info").slideUp();
            })

            e.find(".person span").tooltip({
                track: true,
                delay: 1,
                showURL: false,
                opacity: 1,
                showBody: " - ",
                extraClass: "tt_top_left",
                top: 15,
                left: -20 ,
                //	bodyHandler:content_tt_make2
                bodyHandler: function() {
                    var id = $(this).parentsUntil('.pink_box_cb').parent().attr('id').replace('my-order-', '');
                    if (document.getElementById("my-order-" + id + "-manager-info")) {
                        var out = $("#my-order-" + id + "-manager-info").html();
                        out = '<div class="tt_wrap"><div class="tt_content">' + out + '</div><div class="tt_decor"></div></div>'
                        return out;
                    }
                    return false;
                }
            });
            e.find(".my-review").tooltip({
                track: true,
                delay: 1,
                showURL: false,
                opacity: 1,
                showBody: " - ",
                extraClass: "tt_top_left",
                top: 15,
                left: -20 ,
                //	bodyHandler:content_tt_make2
                bodyHandler: function() {
                    var id = this.parentNode.parentNode.parentNode.parentNode.parentNode.id.replace('my-order-', '');
                    if (document.getElementById("my-order-" + id + "-review-info")) {
                        var out = $("#my-order-" + id + "-review-info").html();
                        out = '<div class="tt_wrap"><div class="tt_content">' + out + '</div><div class="tt_decor"></div></div>'
                        return out;
                    }
                    return false;
                }
            });
        })
    }

})
function content_tt_make() {
    var content = '<table><tr>' +
    '<td><img width="60" src="http://ikra-ikra.ru/attach/450/w120h120.png" alt=""></td>' +
    '<td><a href="">Краб цельный</a><br>в собственном соку</td>' +
    '<td><span class="red">6</span> шт</td>' +
    '</tr></table>';
    var out = '<div class="tt_wrap"><div class="tt_content">' + content + '</div><div class="tt_decor"></div></div>'
    return out 
}
function content_tt_make2() {
    var content = '<p class="red">Краснова Наталья</p>тел 2293711 доб 120<br>krasnova@delikateska.ru';
    var out = '<div class="tt_wrap"><div class="tt_content">' + content + '</div><div class="tt_decor"></div></div>'
    return out 
}

jQuery.fn.inputDefault = function() {
    return this.each(function() {
        var dflt = $(this).attr('default') || $(this).attr('data-default') || $(this).attr('data-placeholder');
        var e = $(this);

        e.focus(function() {
            //			console.log($(this).val()+' vs '+dflt);
            if ($(this).val() == dflt || $(this).val().length < 1) {
                $(this).val('').addClass('type');
            } else if (/\(___\) ___\-__\-__/.test($(this).val()))
                $(this).val('').addClass('type');
        });

        e.blur(function() {
            if ($(this).val() == dflt || $(this).val().length < 1) {
                $(this).val(dflt).removeClass('type');
            }
        });

        if ($(this).val() == dflt || $(this).val().length < 1) {
            //	if(e.val()=='' || e.val()==dflt){
            e.val(dflt).removeClass('type');
            //	}
        } else if (false == $(this).hasClass("type")) {
            $(this).addClass('type');
        }

    });
}

jQuery.fn.passDefault = function(set) {
    if (!set) 
        set = {
            t: 6,
            f: 1.25,
            l: 'Пароль'
        }

    if (!set.t)
        set.t = 6;

    if (!set.f)
        set.f = 1.25;

    if (!set.l)
        set.l = 'Пароль';

    return this.each(function() {
        $this = $(this);

        $this.wrap('<span style="position: relative; display: inline-block; zoom: 1; overflow: hidden; width: 100%;">')
        $this.parent().append('<label for="' + $this.attr('id') + '" style="position: absolute; left: 5px; top: ' + set.t + 'px; font-size: ' + set.f + 'em; color: #999;">' + set.l + '</label>');

        $this.focus(function() {
            if (!$(this).val()) {
                $(this).addClass('type').parent().find('label').hide();
            }
        });

        $this.blur(function() {
            if (!$(this).val()) {
                $(this).removeClass('type').parent().find('label').show();
            }
        });
    })
}



var cabinet = {
    editAddress: function(id) {
        $("#my-addresses-list div.my-address").each(function() {
            if (this.id != "my-address-" + id) {
                $(this).slideToggle();
            } else {
                $("#my-address-" + id + "-table").slideToggle();
                $("#my-address-" + id + "-form").slideToggle();
            }
        });
        return false;
    },
    deleteAddress: function(id) {
        $.post(
        '/api/cart.profile.address.php',
        {
            del: id
        },
        function(data) {
            if (data && data == 'ok') {
                $("#my-address-" + id).fadeOut();
            }
        },
        "html"
        );
        return false;
    },
    selectAddress: function(id) {

        $.post(
        '/api/cart.profile.address.php',
        {
            action: "selectAddress",
            id: id
        },
        function(data) {
            if (data) {
                /*$("div.pink_box_side_cb").removeClass("pink_box_side_active_cb");
                					$("div.control_cb").show();
                					$("#my-address-"+id).addClass("pink_box_side_active_cb");
                					$("#my-address-"+id+"-buttons").hide();*/

                $('#selected_address').html($("#my-address-" + id).html());
                $("#my-address-" + id).parent().find('.pink_box_side_cb:hidden').slideDown();
                $("#my-address-" + id).slideUp();

                /*
                					$("#delivery_form_content").html(data);
                					$('#delivery_form_content input[type="text"],#address-form textarea').inputDefault();
                					$("#delivery_form_content input.err").removeClass("err");
                					$("#delivery_form_content span.err").hide();
                					$("#address-form-phone,#address-form-landline_phone").mask("9-999-999-99-99");
                				*/
                $("#address-form").html(data);
                //					console.log(data)
                $('#address-form input[type="text"],#address-form textarea').inputDefault();
                $("#address-form input.err").removeClass("err");
                $("#address-form span.err").hide();
                $("#address-form-phone,#address-form-landline_phone").mask("9-999-999-99-99");

            }
        },
        "html"
        );
        $.post(
        '/api/cart.profile.address.php',
        {
            action: "selectCity",
            id: id
        },
        function(data) {
            if (data) {
                $("#city_block").html(data);

                //				console.log(data)
                // перезагрузка блока интревалов доставки
                $.post(
                "/api/getDelivery.api.php",
                {
                    city_id: $('#address-form-kladr_city_id').val()
                },
                function callback(answer) {
                    if (answer)
                        $("#delivery_form_content").html(answer);
                });
            }
        },
        "html"
        );




        /*
        		$.post(
        			'/api/cart.profile.address.php',
        			{change:id},
        			function(data){
        				if(data){
        					$("div.pink_box_side_cb").removeClass("pink_box_side_active_cb");
        					$("div.control_cb").show();
        					$("#my-address-"+id).addClass("pink_box_side_active_cb");
        					$("#my-address-"+id+"-buttons").hide();
        					for(var i in data){
        						$('#address-form-'+i).val(data[i]);
        					}
        					$('#address-form input[type="text"]').inputDefault();
        					$('#address-form textarea').inputDefault();
        					$("#address-form input.err").removeClass("err");
        					$("#address-form span.err").hide("err");
        				}
        			},
        			"json"
        		);
        */
        return false;
    },
    selectDeliveryType: function(el) {
        alert(1);
        var id = $("#address-form-id").val();
        $.post(
        '/api/cart.profile.address.php',
        {
            action: "selectAddress",
            delivery: el.value,
            id: id
        },
        function(data) {
            if (data) {
                $("#address-form").html(data);
                $('#address-form input[type="text"],#address-form textarea').inputDefault();
                $("#address-form input.err").removeClass("err");
                $("#address-form span.err").hide();
                $('#address-form-phone,#address-form-landline_phone').mask('9-999-999-99-99');
                $('#address-form-phone,#address-form-landline_phone').inputDefault();
            }
        },
        "html"
        );
    },
    addCartTemplate: function() {
        $.post(
        '/api/cart.template.php',
        {
            action: "add"
        },
        function(data) {
            if (data) {
                $("#cart-template-checkbox-place").html(data);
            }
        },
        "html"
        );
        return false;
    },
    addToCartTemplate: function(id) {
        $.post(
        '/api/cart.template.php',
        {
            action: "add_use",
            id: id
        },
        function(data) {
            if (data) {
                if (data == '[error]') {
                    alert('Не удалось использовать эту корзину!');
                } else {
                    top.window.location = "/cart";
                }
            }
        },
        "html"
        );
        return false;
    },
    selectCartTemplate: function(id) {
        $.post(
        '/api/cart.template.php',
        {
            action: "use",
            id: id
        },
        function(data) {
            if (data) {
                if (data == '[error]') {
                    alert('Не удалось использовать эту корзину!');
                } else {
                    top.window.location = "/cart";
                }
            }
        },
        "html"
        );
        return false;
    },
    deleteCartTemplate: function(id) {
        $.post(
        '/api/cart.template.php',
        {
            action: "delete",
            id: id
        },
        function(data) {
            if (data) {
                top.window.location = "/cabinet/cart-templates";
            }
        },
        "html"
        );
        return false;
    },
    editCartTemplateTitleGet: function(el, id) {
        $.post(
        '/api/cart.template.php',
        {
            action: "titleGet",
            id: id
        },
        function(data) {
            if (data) {
                var div = document.createElement("DIV");
                $(div).html(data);
                $(el.parentNode.parentNode.parentNode).prepend(div);
                $(el.parentNode.parentNode).remove();
            }
        },
        "html"
        );
        return false;
    },
    editCartTemplateTitleSet: function(el, id, save, tplpage) {
        save = typeof save == "undefined" ? "Y" : save;
        tplpage = typeof tplpage == "undefined" ? "N" : tplpage;
        if (save == "Y" && !el.value.length) {
            return false;
        }
        $.post(
        '/api/cart.template.php',
        {
            action: "titleSet",
            id: id,
            title: (save == "Y" ? encodeURIComponent(el.value) : ""),
            save: save,
            tplpage: tplpage
        },
        function(data) {
            if (data) {
                if (tplpage == "Y") {
                    $(el.parentNode.parentNode).html(data);
                } else {
                    $(el.parentNode.parentNode).prepend(data);
                    $(el.parentNode).remove();
                }
            }
        },
        "html"
        );
        return false;
    },
    derivePoints: function() {
        $("#bill-form-points").removeClass("err");
        $("#err-bill-form-points").hide().html("");
        var points = document.getElementById("bill-form-points");
        points.value = points.value.replace(/[^\d]/g, "");
        // error?
        if (!points.value.length) {
            $("#bill-form-points").addClass("err");
            $("#err-bill-form-points").html("Неверно заполнено поле!").show();
            return false;
        }
        $.post(
        '/api/order.points.derive.php',
        {
            points: Number(points.value)
        },
        function(data) {
            if (data.error) {
                $("#err-bill-form-result").html(data.error).show();
            } else if (data.success) {
                $("#err-bill-form-result").html(data.success).show();
                $("#bill-form-points").val("рубли").removeClass("type");
                $("#my-bill-value").html(data.bill);
                $.post(
                '/api/order.points.reload.php',
                {
                    reload: true
                },
                function(data) {
                    if (data) {
                        $("#my-bill-container").html(data);
                    }
                },
                "html"
                );
            }
        },
        "json"
        );
        return false;
    }
}

function showTextAboutAlcohol(obj, id, confirmed, card) {
    confirmed = typeof confirmed == "undefined" ? false : confirmed;
    card = typeof card == "undefined" ? false : card;
    if (confirmed) {
        jQuery.post(
        "/api/price.alcohol.php",
        {
            id: id,
            confirm: "yeah"
        },
        function(data) {
            jQuery("#popup_alcho").fadeOut(function() {
                $(this).remove();
                if (card)
                    addToCart(obj, id, card);
                else
                    addToCart(obj, id);
            });
        });
    } else {
        jQuery.post(
        "/api/price.alcohol.php",
        {
            id: id
        },
        function(data) {
            if (data && data.length) {
                $("body").append(data);
                $("#popup_alcho").show();
            } else {
                if (card)
                    addToCart(obj, id, card);
                else
                    addToCart(obj, id);
            }
        });
    }
    return false;
}

// php'шная in_array
function in_array(needle, haystack, strict) {
    var found = false, key, strict = !!strict;
    for (key in haystack) {
        if ((strict && haystack[key] === needle) || (!strict && haystack[key] == needle)) {
            found = true;
            break;
        }
    }
    return found;
}

function billInfo() {
    if (!jQuery('#bill_popup').size()) {
        jQuery('body').append('<div class="popup" id="bill_popup"><div class="opacity" onclick="jQuery(\'#bill_popup\').fadeOut(); return false;"></div><div class="text"><img class="close_banners" onclick="jQuery(\'#bill_popup\').fadeOut(); return false;" src="/images/close_banners.png" alt="" /><h3>Уважаемые клиенты!</h3><p>В нашем магазине каждый клиент может иметь обычный, серебряный или золотой статус. Каждый статус предоставляет свои привилегии.</p><p><b>Обычный статус</b> не дает никаких привилегий. Все расчеты ведутся по стандартному тарифу.</p><p><b>Серебряный статус</b> предоставляется от суммы оплаченных заказов <b>50000 руб</b>.</p><p><b>Золотой статус</b> предоставляется от суммы оплаченных заказов <b>100000 руб</b>.</p></div></div>');
    }
    jQuery('#bill_popup').fadeIn();

}

function svClubCard(el, oku) {
    oku = typeof oku == "undefined" ? false : oku;
    el.value = el.value.replace(/[^\d]/g, "");
    if (el.value.length) {
        $.post(
        "/api/svclub_card.php",
        "card=" + el.value,
        function(data) {
            if (data) {
                if (data != "yes") {
                    $("#address-form-svclub_card").css("border", "1px solid red");
                    if (!oku) {
                        $("#err-address-form-svclub_card").html('В номере карты допущена ошибка и она не будет принята. Проверьте правильность ввода номера, расположенного на обороте под штрих-кодом, и повторите попытку').show();
                    }
                } else {
                    $("#address-form-svclub_card").css("border", "1px solid green");
                    $("#err-address-form-svclub_card").html('').hide();
                }
            }
        });
    }
}

jQuery.fn.radio = function (options) {
    if (!options)
        options = {};

    return this.each(function () {
        var $this = $(this);

        if ($this.is(':radio')) {
            if ($this.data().radio)
                return;

            $this.css({
                position: 'absolute'
            }).wrap('<span style="width: 0; height: 0; display: inline-block; overflow: hidden; position: relative; zoom: 1;"></span>');

            var name = $this.attr('name');

            var radio = $('<label>', {
                'class': 'radio' + ($this.attr('disabled') ? ' disabled' : ''),
                'for': $this.attr('id'),
                rel: $this.attr('name')
            });

            if ($this.is(':checked'))
                radio.addClass('checked');

            radio.insertAfter($this.parent());

            //			$this.watch('disabled', {mode: 'attr'}, function () {
            //				if ($this.attr('disabled')) {
            //					radio.addClass('disabled');
            //				} else {
            //					radio.removeClass('disabled');
            //				}
            //			});

            $this.data({
                radio: radio
            });

            $this.change(function () {
                if ($(this).hasClass('disabled'))
                    return false;

                $('label.radio.checked[rel="' + name + '"]').removeClass('checked');

                if ($(this).is(':checked'))
                    radio.addClass('checked');
                else
                    radio.removeClass('checked');

                if (options.onChange) {
                    options.onChange.apply(this);
                }
            });
        }
    })
};

$.fn.tooltip = function(options) {
    var defaults = {
        position: 'left',
        show: false,
        trigger: 'click',
        closeTrigger: 'mouseleave',
        appendTo: null,
        width: null,
        createOnTrigger: false,
        positionBy: false
    };

    var opts = $.extend(defaults, options);

    var Tooltip = function() {
        this.init(opts);
    };

    Tooltip.prototype.template = '<div class="tooltip"><i class="tail"></i><div class="tooltipContent"></div></div>';

    Tooltip.prototype.position = function(pos, rel) {
        var offset = {
            top: 12,
            left: 15,
            right: 15
        };
        var tooltip = this.tt.show();

        var position;

        if (!opts.appendTo) {
            if (pos == 'left') {
                position = {
                    top: rel.offset().top - offset.top + 'px',
                    left: rel.offset().left - tooltip.outerWidth() - offset.left + 'px'
                };
                tooltip.addClass('left');
            } else if (pos == 'top') {
                position = {
                    top: rel.offset().top - tooltip.height() + 'px',
                    left: rel.offset().left + rel.outerWidth() / 2 - tooltip.width() / 2 + 'px'
                };
                tooltip.addClass('top');
            } else if (pos == 'bottom') {
                position = {
                    top: rel.offset().top + rel.height() + 'px',
                    left: rel.offset().left + rel.outerWidth() / 2 - tooltip.width() / 2 + 'px'
                };
                tooltip.addClass('bottom');
            } else if (pos == 'right') {
                position = {
                    top: rel.offset().top - offset.top + 'px',
                    left: rel.offset().left + rel.outerWidth() + offset.right + 'px'
                };
                tooltip.addClass('right');
            }
        } else {
            if (pos == 'left') {
                position = {
                    top: -12 + 'px',
                    right: 20 + 'px'
                };
                tooltip.addClass('left');
            } else if (pos == 'top') {
                position = {
                    bottom: 0 + 'px',
                    left: 20 + 'px'
                };
                tooltip.addClass('top');
            } else if (pos == 'bottom') {
                position = {
                    top: -12 + 'px',
                    left: 20 + 'px'
                };
                tooltip.addClass('bottom');
            } else if (pos == 'right') {
                position = {
                    top: -12 + 'px',
                    left: 20 + 'px'
                };
                tooltip.addClass('right');
            }
        }

        tooltip.hide().css(position);
    };

    Tooltip.prototype.createTooltip = function () {
        this.tt = $(this.template).hide().appendTo(opts.appendTo ? opts.appendTo : 'body');
        if (opts.width) {
            this.tt.css('width', opts.width)
        }
        this.tt.addClass(opts.position);
    };

    Tooltip.prototype.destroyTooltip = function () {
        if (this.tt) {
            this.tt.remove();
            this.tt = null;
        }
    };

    Tooltip.prototype.init = function(opts) {
        this.options = opts;
        if (!opts.createOnTrigger)
            this.createTooltip();
    };

    Tooltip.prototype.setContent = function(html) {
        this.tt.find('.tooltipContent').html(html);
    };

    Tooltip.prototype.show = function() {

        this.tt.fadeIn('fast');
    };

    Tooltip.prototype.hide = function () {
        var _this = this;

        this.tt.fadeOut('fast');

    };

    Tooltip.prototype.isVisible = function() {
        return this.tt.is(':visible');
    };

    return this.each(function() {

        var $this = $(this);

        var tooltip;

        if (!$this.data('tooltip')) {
            tooltip = new Tooltip();
            $this.data({
                tooltip: tooltip
            });
        }

        tooltip = $this.data('tooltip');

        if (opts.trigger) {

            $this.bind(opts.trigger, function(e, params) {
                e.preventDefault();

                if (opts.createOnTrigger)
                    tooltip.createTooltip();

                var text;

                if (params && params.text)
                    text = params.text;

                if (!text)
                    text = opts.text ? opts.text : $this.attr('title');

                tooltip.setContent(text);

                tooltip.position(opts.position, (!opts.positionBy ? $this : $(opts.positionBy)));

                tooltip.show();
            });
        }

        if (opts.show) {
            var text = opts.text ? opts.text : $this.attr('title');

            tooltip.setContent(text);

            tooltip.position(opts.position, (!opts.positionBy ? $this : $(opts.positionBy)));

            tooltip.show();
        }

        if (opts.closeTrigger) {
            $this.bind(opts.closeTrigger, function(e) {
                tooltip.hide();

            });
            tooltip.tt.bind(opts.closeTrigger, function(e) {
                tooltip.hide();
            });
        }

        //			$(window).resize(function(){
        //				var v = tooltip.isVisible()
        //
        //				tooltip.position(opts.position, $this);
        //
        //				if (v)
        //					tooltip.show();
        //			});

    });
};

$.fn.maxHeight = function() {
    var max = 0;
    this.each(function() {
        if ($(this).height() > max)
            max = $(this).height();
    });

    return max;
};

$.fn.placeholder = function(options) {
    options = $.extend({
        text: '',
        wrapCss: '',
        holderCss: ''
    }, options);

    $(this).wrap('<div class="holderWrap" style="display: block; position: relative; zoom: 1;" />');

    $(this).data({
        holder: $('<label style="position: absolute; cursor: text; ' + options.holderCss + '" for="' + $(this).attr('id') + '" >' + options.text + '</label>')
    });

    $(this).data('holder').css({
        position: 'absolute'
    });

    $(this).closest('.holderWrap').append($(this).data('holder'));

    if ($(this).val()) {
        $(this).data('holder').hide();
    }

    $(this).bind('focus', function(e) {
        //			if (!$(this).val()) {
        $(this).data('holder').fadeOut('fast');
        //			}
    }).bind('blur', function(e) {
        if (!$(this).val()) {
            $(this).data('holder').fadeIn('fast');
        }
    });
};
