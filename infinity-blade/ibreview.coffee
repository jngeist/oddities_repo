IBReview =
    doBloodline: (bloodlinenum, skip = false) ->
        bloodline = IBReview.bloodlines[bloodlinenum]
        IBReview.gothrough(bloodline, skip)

    gothrough: (a, skip = false) ->
        if a.length
            hash = a.shift()
            if !$.isArray hash.id
                hash.id = [hash.id]

            if skip
                count = if hash.count then 1 else 0
                delay = 0
                speed = 1
            else
                count = if hash.count then hash.count else 0
                delay = hash.delay
                speed = hash.speed

            simult = if hash.simult then hash.simult else 0

            for item, i in hash.id
                if i+1 < hash.id.length
                    IBReview.run '#' + item, hash.a, delay, speed
                else
                    IBReview.run '#' + item, hash.a, delay, speed, (-> IBReview.gothrough a, skip ), simult, count

        return null

    hide: (element, delay, b, callback = $.noop) ->
        element.delay(delay).hide 'fade', b, callback

    show: (element, delay, b, callback = $.noop) ->
        element.delay(delay).animate({opacity: 1, color: '#D11818'}, b).show('fade', b).animate {color: '#000'}, b, callback

    openspace: (element, delay, b, callback = $.noop) ->
        #element.delay(delay).css({opacity: 0}).show 'fade', b, callback
        element.css({opacity: 0, display: 'inline'}).delay(delay).animate {opacity: 0}, b, callback

    run: (element, a, delay = 0, b = 750, callback = $.noop, simult, count) ->
        element = $ element
        switch a
            when 'h'
                if simult
                    IBReview.hide element, delay, b
                    callback()
                else
                    IBReview.hide element, delay, b, callback
            when 's'
                if simult
                    IBReview.show element, delay, b
                    callback()
                else
                    IBReview.show element, delay, b, callback
            when 'o'
                if simult
                    IBReview.openspace element, delay, b
                    callback()
                else
                    IBReview.openspace element, delay, b, callback
            when 'heartbeat'
                IBReview.heartbeat count
                callback()
            when '.'
                $('#b3h1').text($('#b3h1').text() + '.').animate({}, 0, callback)
            when 'f'
                $('#b4a4').delay(delay).animate {opacity: "+=0"}, 1,
                    -> $(this).text('faith.'); callback()
            when 'i'
                element.delay(delay).animate {opacity: 0}, b, callback
            when 'b'
                $('span:not(#b5d)').delay(delay).animate({opacity: 0}, b).last().animate {opacity: '+= 0'}, 10, -> $('button span').css({opacity: 1}); callback();
            when 'e'
                IBReview.swapbande 3, callback, delay
            when 'c'
                IBReview.countup callback
            when 'l'
                $('#b3i32').delay(delay).animate {opacity: '+= 0'}, 0, -> $('#b3i32').text 'like the liturgy. '; callback()

    heartbeat: (i) ->
        if i
            `$('#d1').animate({opacity: 1, color: '#D11818'}, 1000, function () {
    			$('#d2').animate({opacity: 1, color: '#D11818'}, 1000, function () {
    				$('#d3').animate({opacity: 1, color: '#D11818'}, 1000, function () {
    					$('#d4').animate({opacity: 1, color: '#D11818'}, 1000, function () { IBReview.heartbeat(i - 1);}).animate({color: '#111'}, 1000);
    				}).animate({color: '#111'}, 1000);
    			}).animate({color: '#111'}, 1000);
    		}).animate({color: '#111'}, 1000);`

    countup: (callback) ->
        a = $('#b2d1')
        if +a.text() < 5
            a.animate {opacity: 0}, 500, ->
                a.text(+a.text() + 1).css({color: '#D11818'}).animate({opacity: 1}, 500).animate {color: '#111'}, 500, -> IBReview.countup callback
        else
            callback()

    swapbande: (count, callback, delay) ->
        if count
            delay = if delay then delay else 0
            elem = $('#b1d2')
            width = elem.width()

            unless IBReview.swapbande.hasrun
                IBReview.swapbande.hasrun = 1
                elem.delay(delay).css({'text-align': 'center'}).animate({width: width}, 500)

            newtext = if elem.text() == 'ends' then 'begins' else 'ends'

            elem.delay(delay).animate {opacity: 0}, 500, ->
                elem.text(newtext).css({color: '#D11818'}).animate({opacity: 1}, 500).animate({color: '#111'}, 500).animate({opacity: "+= 0"}, 500, -> IBReview.swapbande count-1, callback)
        else
            callback()

    reset: ->
        $('#reset').hide 'fade', 1000
        $('span.start').css {opacity: 0}
        $('p').delay(1000).show()
        $('p span:not(.start)').hide()
        $('span.start').delay(1100).show().animate({opacity: 1}, 1000)
        $('#run2').delay(3000).show('fade', 1000)
        IBReview.swapbande.hasrun = 0

    bloodlines:
        2: [
            {a: 'h', id: ['run2', 'skip2'], simult: 1},
            {a: 'h', id: 'b1a', simult: 1, delay: 1000},
            {a: 'o', id: ['b2a1', 'b2a2', 'b2a3'], delay: 1000},
            {a: 's', id: 'b2a1', delay: 1000}, #cosmetics
            {a: 's', id: 'b2a2', delay: 1000}, #new hat
            {a: 's', id: 'b2a3', delay: 1000}, # new sword
            {a: 'h', id: 'b1b', delay: 2000, simult: 1}, # dies at the God king's blade
            {a: 'o', id: ['b2b1', 'b2b2'], delay: 2749},
            {a: 's', id: 'b2b1', delay: 1000}, # vanquishes
            {a: 's', id: 'b2b2', delay: 1000}, # threat
            {a: 'e', delay: 1500}, #ends
            {a: 'o', id: ['b2c1', 'b2c2', 'b2c3', 'b2c4', 'b2c5'], delay: 1000},
            {a: 's', id: 'b2c1'},			# sword
            {a: 's', id: 'b2c2', delay: 500}, # club
            {a: 's', id: 'b2c3', delay: 500}, # two blades
            {a: 's', id: 'b2c4', delay: 1000}, # dark knight
            {a: 's', id: 'b2c5', delay: 1000}, # god king
            {a: 's', id: ['b2d', 'b2d6', 'b2d1'], delay: 1500}, #this ring gives me
            {a: 'c'},
            {a: 'h', id: 'b1h', delay: 1000, simult: 1}, #grind
            {a: 's', id: 'b2e', delay: 1000},			#pointlessness
            {a: 'h', id: 'b1j', simult: 1, delay: 1000},
            {a: 'o', id: ['b2f1', 'b2f2', 'b2f3'], delay: 1000},
            {a: 's', id: 'b2f1', delay: 1000},
            {a: 's', id: 'b2f2', delay: 1000},
            {a: 's', id: 'b2f3', delay: 1000},
            {a: 's', id: ['run3', 'skip3'], delay: 3000},
        ]

        3: [
            {a: 'h', id: ['run3', 'skip3'], delay: 0},
            {a: 'h', id: ['b2a1', 'b2a2', 'b2a3'], simult: 1},
            {a: 'o', id: ['b3a', 'b3a1'], delay: 0},
            {a: 's', id: 'b3a'},
            {a: 's', id: 'b3a1', delay: 1000},
            {a: 'o', id: ['b3b1', 'b3b2', 'b3b3']},
            {a: 's', id: 'b3b1', speed: 375},
            {a: 's', id: 'b3b2', speed: 375},
            {a: 's', id: 'b3b3', speed: 375},
            {a: 'h', id: ['b3b1', 'b3b2', 'b3b3'], delay: 750, speed: 375},
            {a: 'o', id: ['b3d1', 'b3d2', 'b3d3']},
            {a: 's', id: 'b3d1', speed: 375},
            {a: 's', id: 'b3d2', speed: 375},
            {a: 's', id: 'b3d3', speed: 375},
            {a: 'h', id: ['b3d1', 'b3d2', 'b3d3'], delay: 750, speed: 375},
            {a: 'o', id: ['b3e1', 'b3e2', 'b3e3']},
            {a: 's', id: 'b3e1', speed: 375},
            {a: 's', id: 'b3e2', speed: 375},
            {a: 's', id: 'b3e3', speed: 375},
            {a: 'o', id: ['b3f1', 'b3f2', 'b3f3', 'b3f4', 'b3f5']},
            {a: 's', id: 'b3f1', delay: 375},
            {a: 's', id: 'b3f2', delay: 425},
            {a: 's', id: 'b3f3', delay: 500},
            {a: 's', id: 'b3f4', delay: 750},
            {a: 's', id: 'b3f5', delay: 1000},
            {a: 'h', id: ['b2b1', 'b2b2'], delay: 1500},
            {a: 'o', id: ['b3g1', 'b3g2']},
            {a: 's', id: 'b3g1', delay: 1000},
            {a: 's', id: 'b3g2', delay: 1000},
            {a: 'h', id: 'b1d4', delay: 1500},
            {a: 'o', id: ['b3h1', 'b3h2', 'b3h3', 'b3h4']},
            {a: 's', id: 'b3h1', delay: 0},
            {a: 's', id: 'b3h2', delay: 500},
            {a: 's', id: 'b3h3', delay: 500},
            {a: 's', id: 'b3h4', delay: 500},
            {a: 'o', id: ['b3h5', 'b3h6', 'b3h7', 'b3h8'], delay: 1000},
            {a: 's', id: 'b3h5', delay: 0},
            {a: 's', id: 'b3h6', delay: 500},
            {a: 's', id: 'b3h7', delay: 500},
            {a: 's', id: 'b3h8', delay: 500},
            {a: 'o', id: ['b3h9', 'b3h10', 'b3h11', 'b3h12'], delay: 1000},
            {a: 's', id: 'b3h9', delay: 0},
            {a: 's', id: 'b3h10', delay: 750},
            {a: 's', id: 'b3h11', delay: 750},
            {a: 's', id: 'b3h12', delay: 1250},
            {a: 'o', id: ['b3i1', 'b3i0', 'd1', 'd2', 'd3', 'd4', 'b3i2', 'b3i3', 'b3i32', 'b3i4'], delay: 1000},
            {a: 's', id: ['b3i1', 'b3i0'], delay: 0},
            {a: 'heartbeat', count: 6},
            {a: 's', id: 'b3i2', delay: 8750, speed: 1000},
            {a: 's', id: 'b3i3', delay: 1750, speed: 1000},
            {a: 's', id: 'b3i32', delay: 1750, speed: 1000},
            {a: 's', id: 'b3i4', delay: 1750, speed: 1000},
            {a: 'h', id: 'b1e2', delay: 2000, simult: 1},
            {a: 's', id: 'b3e2a', delay: 2000},
            {a: 'h', id: 'b2c1', delay: 4000, simult: 1},
            {a: 's', id: 'b3c1a', delay: 4000},
            {a: 'h', id: 'b2c2', delay: 1000, simult: 1},
            {a: 's', id: 'b3c2a', delay: 1000},
            {a: 'h', id: 'b2c3', delay: 1000, simult: 1},
            {a: 's', id: 'b3c3a', delay: 1000},
            {a: 'h', id: ['b2e', 'b1i', 'b2f1', 'b2f2', 'b2f3'], delay: 4000},
            {a: 'o', id: ['b3j1', 'b3j2', 'b3j3', 'b3j4', 'b3j5'], delay: 0},
            {a: 's', id: 'b3j1', delay: 1000},
            {a: 's', id: 'b3j2', delay: 1000},
            {a: 's', id: 'b3j3', delay: 1000},
            {a: 's', id: 'b3j4', delay: 1000},
            {a: 's', id: 'b3j5', delay: 1000},
            {a: 's', id: ['run4', 'skip4'], delay: 5000},
        ]

        4: [
            {a: 'h', id: ['run4', 'skip4']},
            {a: 'h', id: ['b3a', 'b3a1', 'b3e1', 'b3e2', 'b3e3', 'b3f1', 'b3f2', 'b3f3', 'b3f4', 'b3f5'], delay: 0}, # drudgery ->
            {a: 'o', id: ['b4a1', 'b4a2', 'b4a3', 'b4a4', 'b4a5', 'b4a6', 'b4a7', 'b4a8', 'b4a9'], delay: 0},
            {a: 's', id: 'b4a1'}, # -> cyclicality
            {a: 's', id: 'b4a2'}, # -> birth
            {a: 's', id: 'b4a3'}, # -> death
            {a: 's', id: 'b4a4'}, # -> faith
            {a: 's', id: 'b4a5'}, # -> politics
            {a: 's', id: 'b4a6'}, # -> prejudice
            {a: 's', id: 'b4a7'}, # -> alcoholism
            {a: 's', id: 'b4a8'}, # -> abuse
            {a: 's', id: 'b4a9', delay: 1000}, # -> the moment . . .
            {a: 'h', id: ['b4b', 'b3g1', 'b3g2', 'b1c'], delay: 1000, speed: 2000}, # conceit: -> the process repeats.
            {a: 'h', id: ['b3h2', 'b3h3', 'b3h4', 'b3h5', 'b3h6', 'b3h7', 'b3h8', 'b3h9', 'b3h10', 'b3h11', 'b3h12'], delay: 3000, speed: 2000}, # walk ->
            {a: '.'}, # .
            {a: 'h', id: ['b1e1', 'b1e2', 'b3e2a', 'b2c4', 'b2c5', 'b1f', 'b2d', 'b2d1', 'b2d6', 'b3c1a', 'b3c2a', 'b3c3a'], delay: 3000, speed: 2000}, # gameplay shortened
            {a: 'h', id: ['b3j1', 'b3j2', 'b3j3', 'b3j4', 'b3j5', 'b1g1'], delay: 3000}, # evolution ->
            {a: 'o', id: ['b4d1', 'b4d2'], delay: 0},
            {a: 's', id: 'b4d1', delay: 1000}, # -> statement of faith
            {a: 's', id: 'b4d2', delay: 1000}, # ->most fundamental hope
            {a: 's', id: ['run5', 'skip5'], delay: 3000},
        ]

        5: [
            {a: 'h', id: ['run5', 'skip5'], delay: 0},
            {a: 'h', id: ['b5a', 'b5a1'], delay: 1000, speed: 1500}, # conceit, repetition ->
            {a: 'h', id: ['b1e0', 'b3i1'], delay: 3000}, # gameplay ->
            {a: 'h', id: ['b3i1', 'd1', 'd2', 'd3', 'd4'], delay: 4000}, # dodge ->
            {a: 'h', id: 'b3i2', delay: 2000}, # ouroboros ->
            {a: 'h', id: ['b3i3', 'b3i4'], delay: 2000},
            {a: 'h', id: 'b3i0', delay: 3000, simult: 1},
            {a: 'l', delay: 3500},
            {a: 'h', id: 'b4a9', delay: 4000},
            {a: 'h', id: 'b4a8', delay: 1000},
            {a: 'h', id: 'b4a7', delay: 1000},
            {a: 'h', id: 'b4a6', delay: 1000},
            {a: 'h', id: 'b4a5', delay: 1000},
            {a: 'h', id: ['b4a1', 'b4a2', 'b4a3'], delay: 4000, simult: 1},
            {a: 'f', delay: 4000},
            {a: 'h', id: ['b1e', 'b5g', 'b5d1', 'b3i32', 'b5b', 'b5c', 'b5e', 'b5f'], delay: 4000, speed: 1500},
            # {a: 's', id: 'scoreBox', delay: 5000, speed: 2000},
            {a: 'b', delay: 5000, speed: 5000},
            {a: 'h', id: 'b5d', delay: 0, speed: 5000},
            {a: 's', id: 'reset', delay: 3000},
        ]

    setup: ->
        version = $.fn.jquery
        $.getScript "https://ajax.googleapis.com/ajax/libs/jqueryui/#{version}/jquery-ui.min.js", ->
            #$('span:not(.start)').hide();
            #$('#scoreBox').hide();
            $('button').hide().css({width: '120px', height: '60px', margin: 'auto', display: 'none'});
            $(".bloodline").each ->
                $(@).click (event) ->
                    event.preventDefault()
                    button = @
                    $('html, body').animate
                        scrollTop: $("#review").offset().top
                    , 500,
                        IBReview.doBloodline $(button).attr('data-bloodline'), $(button).attr('data-skip')
            $('#reset').click(IBReview.reset);
            # Delay for publication
            $('#run2').show('fade', 1000);
            # Delete for publication
            $('#skip2').show('fade', 1000);

$(document).ready IBReview.setup()
