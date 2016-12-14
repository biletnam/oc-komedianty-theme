$.noConflict()
jQuery(document).ready ($) ->

    # Calendar
    $("#playbill .calendar a").click (e) ->
        e.preventDefault()
        unless $(this).attr("class") is "active"
            $("#playbill .calendar a").removeClass "active"
            $(this).addClass "active"
            unless $("#playbill .event").attr("class") is "active"
                $("#playbill .event").addClass "active"
                unless $($(this).attr("href")).attr("class") is "active"
                    $("#playbill .event").removeClass "active"
                    $($(this).attr("href")).addClass "active"
        else
            $($(this).attr("href")).removeClass "active"
            $(this).removeClass "active"
            $("#playbill .event").removeClass "active"

    # Main menu
    $(".mainMenu .mainMenu-item.has-child > a").click (e) ->
        mainMenuLink = $(this)
        mainMenuItem = mainMenuLink.parent()
        mainMenuItems = mainMenuItem.parent().children()
        sideMenu = mainMenuItem.children(".sideMenu")
        sideMenus = mainMenuItems.children(".sideMenu")

        if $(window).width() <= 1440
            e.preventDefault()
            unless sideMenu.is(':visible')
                sideMenus.hide()
                sideMenu.show()
            else
                sideMenu.hide()

    # Calendar 2
    $(".nav.slick-next").click (e) ->
        console.log 'Click Next'
        el = $(".calendar .slide")
        console.log left = el.position().left
        items = $(".calendar .slide .slider-item")
        console.log count = items.size()
        console.log width = el.prop('scrollWidth')
        console.log step = 5*(width/count)
        console.log step = left - step
        el.css('left', step)
        console.log slider = $(".calendar .slider").outerWidth(true)
        console.log check = width - slider + step
        if check < 0
            step = slider - width
            el.css('left', step)

    $(".nav.slick-prev").click (e) ->
        console.log 'Click Prev'
        el = $(".calendar .slide")
        console.log left = el.position().left
        console.log step = left + $(".calendar .slide .slider-item.active").outerWidth(true) * 5
        if step > 0
            el.css('left', 0)
        else
            el.css('left', step)
