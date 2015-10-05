# SocialShareKit.init();

# hash = window.location.hash

# $('#playbill .date-block .date').fitText(1.2, { minFontSize: '25px', maxFontSize: '100px' })

$.noConflict()
jQuery(document).ready ($) ->

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



	# $(".secondary-navigation .nav-menu-item > a").click (e) ->
	# 	e.preventDefault()

	# 	link = $(this)
	# 	item = link.parent()
	# 	dest = $(link.attr("href"))
	# 	# window.location = link.attr("href")

	# 	unless item.attr("class") is "active"
	# 		$(".secondary-navigation .nav-menu-item").removeClass "active"
	# 		item.addClass "active"
	# 		unless $('.content .section').attr("class") is "active"
	# 			$('.content .section').addClass "active"
	# 			unless dest.attr("class") is "active"
	# 				$('.content .section').removeClass "active"
	# 				dest.addClass "active"



	BuyPopUpShow = ->
		$('.buy-popup').show()

	BuyPopUpHide = ->
		$('.buy-popup').hide()


	# $('.buy-button').click (e) ->
	# 	e.preventDefault()
	# 	e.stopPropagation()

	# 	# BuyPopUpShow()

	# $('.button-buy').click (e) ->
	# 	e.preventDefault()
	# 	e.stopPropagation()

	# 	BuyPopUpShow()


	# ShowSideMenu = (e) ->
	#     e.show


	$(".mainMenu .mainMenu-item > a").click (e) ->
		mainMenuLink = $(this)
		mainMenuItem = mainMenuLink.parent()
		mainMenuItems = mainMenuItem.parent().children()
		sideMenu = mainMenuItem.children(".sideMenu")
		sideMenus = mainMenuItems.children(".sideMenu")
		# item.parent().addClass('parent')
		# dest = $(mainMenuLink.attr("href"))
		# window.location = mainMenuLink.attr("href")

		if $(window).width() <= 1440
			e.preventDefault()
			unless sideMenu.is(':visible')
				# mainMenuItems.removeClass "active"
				# mainMenuItems.removeClass "child-active"
				# mainMenuItem.addClass "active"
				# mainMenuItem.addClass "child-active"
				sideMenus.hide()
				sideMenu.show()
			else
				# mainMenuItem.removeClass "active"
				# mainMenuItem.removeClass "child-active"
				sideMenu.hide()





	# AlignBackgrounds = ->
	#     backgrounds = $('.bg-container .bg')
	#     console.log backgrounds

	#     images = []

	#     for image in backgrounds
	#         do (image) ->
	#             svg = $('svg', image)
	#             width = svg.attr('width')
	#             height = svg.attr('height')

	#             images.push [width, height]

	#     console.log images




	# $(document).ready ->
	#     AlignBackgrounds()



	$(".nav.slick-next").click (e) ->
		console.log 'Click Next'
		el = $(".calendar .slide")
		console.log left = el.position().left
		items = $(".calendar .slide .slider-item")
		console.log count = items.size()
		console.log width = el.prop('scrollWidth')
		console.log step = 5*(width/count)
		# console.log step = pos.left - ($(".calendar .slide .slider-item.active").outerWidth(true) * 5)
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


	# test = (e) ->
	# 	bileter_api_key = 'd98a3e8ab87ecd3721a78a273bd9146a'
	# 	bileter_api_url = 'http://komedianty.apit.bileter.ru/'

	# 	$.ajax(
	# 		async: !0
	# 		type: 'POST'
	# 		url: bileter_api_url + bileter_api_key + '/afisha/'
	# 		dataType: 'html'
	# 		data:
	# 			api_key: bileter_api_key
	# 		success: (t) ->
	# 			console.log t
	# 			return
	# 	)
	# 	return


	$(document).ready ->
		BuyPopUpHide()
		# test()