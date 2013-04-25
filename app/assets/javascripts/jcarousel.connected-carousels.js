

(function($) {
    // This is the connector function.
    // It connects one item from the navigation carousel to one item from the
    // stage carousel.
    // The default behaviour is, to connect items with the same index from both
    // carousels. This might _not_ work with circular carousels!
    var connector = function(itemNavigation, carouselStage) {
        return carouselStage.jcarousel('items').eq(itemNavigation.index());
    };

    var loadImageData = function(imageId) {
        $.get('/images/data/' + imageId + '.json', function(imageData) {
          //console.log(imageData);
          
          
          // Populate image sizes
          var sizes = imageData['GetImageDetailsResult']['Images'][0]['SizesDownloadableImages'];
          // console.log(sizes);

          // Populate file information here
          $('#caption').text(imageData['GetImageDetailsResult']['Images'][0]['Caption']);
          $('#collection').text(imageData['GetImageDetailsResult']['Images'][0]['CollectionName']);          
          $('#copyright').text(imageData['GetImageDetailsResult']['Images'][0]['Copyright']);

        $('#imageNumber').text(imageId);
        $('#imageTitle').text(imageData['GetImageDetailsResult']['Images'][0]['Title']);
        $('#imageArtist').text(imageData['GetImageDetailsResult']['Images'][0]['Artist']);

          imageUrl = imageData['GetImageDetailsResult']['Images'][0]['UrlPreview'];
          imageUrl = imageData['GetImageDetailsResult']['Images'][0]['UrlWatermarkComp'];
          $('body').css('background-image', 'url(' + imageUrl + ')');

          console.log(imageData['GetImageDetailsResult']['Images'][0]);
          
          // Populate
          
          
        });
    };

    $(function() {
        // Setup the carousels. Adjust the options for both carousels here.
        var carouselStage      = $('.carousel-stage').jcarousel();
        var carouselNavigation = $('.carousel-navigation').jcarousel();

        // We loop through the items of the navigation carousel and set it up
        // as a control for an item from the stage carousel.
        carouselNavigation.jcarousel('items').each(function() {
            var item = $(this);

            // This is where we actually connect to items.
            var target = connector(item, carouselStage);

            item
                .on('active.jcarouselcontrol', function() {
                    carouselNavigation.jcarousel('scrollIntoView', this);
                    item.addClass('active');
                    //console.log($(this).find("img").attr('id'))
                    loadImageData($(this).find("img").attr('id'));
                })
                .on('inactive.jcarouselcontrol', function() {
                    item.removeClass('active');
                })
                .jcarouselControl({
                    target: target,
                    carousel: carouselStage
                });
        });

        // Setup controls for the stage carousel
        $('.prev-stage')
            .on('inactive.jcarouselcontrol', function() {
                $(this).addClass('inactive');
            })
            .on('active.jcarouselcontrol', function() {
                $(this).removeClass('inactive');
            })
            .jcarouselControl({
                target: '-=1'
            });

        $('.next-stage')
            .on('inactive.jcarouselcontrol', function() {
                $(this).addClass('inactive');
            })
            .on('active.jcarouselcontrol', function() {
                $(this).removeClass('inactive');
            })
            .jcarouselControl({
                target: '+=1'
            });

        // Setup controls for the navigation carousel
        $('.prev-navigation')
            .on('inactive.jcarouselcontrol', function() {
                $(this).addClass('inactive');
            })
            .on('active.jcarouselcontrol', function() {
                $(this).removeClass('inactive');
            })
            .jcarouselControl({
                target: '-=1'
            });

        $('.next-navigation')
            .on('inactive.jcarouselcontrol', function() {
                $(this).addClass('inactive');
            })
            .on('active.jcarouselcontrol', function() {
                $(this).removeClass('inactive');
            })
            .jcarouselControl({
                target: '+=1'
            });
    });
})(jQuery);
