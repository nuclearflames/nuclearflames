   var markers=[];
    var places=[];
    var map;
    var iterator1 = 0;

    
  function loadaction() 
  {
      places = [
        <% for location in @locations %>["<%=h location.title %>", new google.maps.LatLng(<%=h location.lat %>,<%=h location.long %>)],
        <% end %>];

       
        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var myOptions = {
          zoom: 8,
          center: latlng,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        
        map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);




drop();  
        
    google.maps.event.addListener(markers[0], 'click', function() {
      infowindow.open(map, markers[0])});   

  }
  
  function drop() {
      for (var i = 0; i < places.length; i++) {
        setTimeout(function() {
          addMarkers();
        }, i * 200);
      }
  }

  function addMarkers() {
  
    markers.push(new google.maps.Marker({
      position: places[iterator1][1],
      map: map,
      title:"Title: " + places[iterator1][0],
      draggable: false,
      animation: google.maps.Animation.DROP
    }));
    iterator1 ++;

  }