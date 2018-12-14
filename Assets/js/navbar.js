 $(function() {
       var print = function(msg) {
         alert(msg);
       };

       var setInvisible = function(elem) {
         elem.css('visibility', 'hidden');
       };
       
       var setVisible = function(elem) {
         elem.css('visibility', 'visible');
       };

       var elem = $("#elem");
       var items = elem.children();

       // Inserting Buttons
       elem.prepend('<div id="right-button"> < </div>');
       elem.append(' <div id="left-button"> > </div>');

       // Inserting Inner
       items.wrapAll('<div id="inner" />');

       // Inserting Outer
       elem.find('#inner').wrap('<div id="outer"/>');

       var outer = $('#outer');

       var updateUI = function() {
    	   
         var maxWidth = outer.outerWidth(true);
         var actualWidth = 0;
         $.each($('#inner >'), function(i, item) {
           actualWidth += $(item).outerWidth(true);
         });

         if (actualWidth <= maxWidth) {
           setVisible($('#left-button'));
         }
       };
       updateUI();

		 setVisible($('#right-button'));
		 setVisible($('#left-button'));

       $('#right-button').click(function() {
         var leftPos = outer.scrollLeft();
         outer.animate({
           scrollLeft: leftPos - 500
         }, 800, function() {

           if ($('#outer').scrollLeft() <= 0) {
             //setInvisible($('#right-button'));
           }
         });
         updateUI();
       });

       $('#left-button').click(function() {
         setVisible($('#right-button'));
         var leftPos = outer.scrollLeft();
         outer.animate({
           scrollLeft: leftPos + 500
         }, 800);
         updateUI();
       });

       $(window).resize(function() {
         updateUI();
       });
     });
