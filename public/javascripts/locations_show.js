 function loadaction() {
      
  var latlng = new google.maps.LatLng(<%= @location.lat %>, <%= @location.long %>);
    
    var myOptions = {
      zoom: 8,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    
    var marker = new google.maps.Marker({
      position: latlng, 
      map: map, 
      draggable: false,
      title:"<%= @location.name %>"
    });
        
  }