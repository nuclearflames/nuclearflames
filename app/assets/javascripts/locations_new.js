     
      var marker;

      
      function loadaction() {      
      
         var contentString = 
        '<div id="content1">' +
          '<% form_for(@location) do |f| %>' +
            '<p>' +
              '<b>Name</b><br />' +
              '<%= f.text_field :title %>' +
            '</p>' +
            '<p>' +
              '<b>Lat</b><br />' +
              '<%= f.text_field :lat, :value=>"a number", :readonly => "readonly"  %>' +
            '</p>' +
            '<p>' +
              '<b>Long</b><br />' +
              '<%= f.text_field :long, :value=>"a number", :readonly => "readonly"  %>' +
            '</p>' +
            '<p>' +
              '<b>Description</b><br />' +
              '<%= f.text_field :description  %>' +
            '</p>' +
            '<p>' +
              '<b>Creator</b><br />' +
              '<%= f.text_field :owner, :value=> session[:user_first_name].to_s, :readonly => "readonly"  %>' +
            '</p>' +
            '<p>' +
              '<b>Visibility</b><br />' +
            '<select id="location_status" name="location[status]"><option value="public">public</option>' +
'<option value="private">private</option>' +
'<option value="inviteonly">invonly</option></select>' +
            '</p>' +
            '<p>' +
              '<%= f.submit "Create" %>' +
            '</p>' +
          '<% end %>' +
        '</div>'; 
    
        var infowindow = new google.maps.InfoWindow({ 
          content:contentString
        });

        var latlng = new google.maps.LatLng(-34.397, 150.644);
        
        var myOptions = {
          zoom: 8,
          center: latlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };

          var map = new google.maps.Map(document.getElementById("map_canvas"),
            myOptions);
            
            marker = new google.maps.Marker({
            position: latlng,
            map: map,
            title: "LatLng",
            draggable: true,
            animation: google.maps.Animation.DROP,
            });
            
          google.maps.event.addListener(marker, 'click', function() {
            infowindow.open(map, marker);
          });
          
          google.maps.event.addListener(marker, 'mouseout', updateXY);    
      }
      
       function updateXY()
        {
        latlng = marker.getPosition();
        
        document.getElementById("location_lat").value=latlng.lat();
        document.getElementById("location_long").value=latlng.lng(); 

        }