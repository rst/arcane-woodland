// Cargo-culted from a Leaflet stock example...

function setup_map( map_url, map_div_id ) {
  
  // Adjust size of map_div.  Sample code also arranges to do this on
  // window resize.  Need to see where that's necessary; skipping for now.

  var map_div = $("#"+map_div_id);
  
  map_div.height( $(window).height() );
  map_div.width(  $(window).width() );

  // Get points and load the map.  Would be best to start loading tiles 
  // while waiting for the point data; later...

  $.get( map_url, { format: "json" },
         function(data) {
           load_map( map_div, map_div_id, data);
         }, "json")

}

function load_map( map_div, map_div_id, spots ) {
  var point_layer = new L.LayerGroup();
  for (var i = 0; i < spots.length; i++ ) {
    var spot = spots[i];
    var posn = new L.LatLng( spot.latitude, spot.longitude );
    var marker = new L.Marker( posn ).bindPopup( spot_link_markup(spot) );
    point_layer.addLayer( marker );
  }

  var attribution = "Map data &copy; OpenStreetMap, Imagery &copy; CloudMade";
  var mkstyle = function(style) { 
    options = {maxZoom: 18, attribution: attribution, styleId: style};
    return options;
  }
  var url = 'http://{s}.tile.cloudmade.com/8ee2a50541944fb9bcedded5165f09d9/{styleId}/256/{z}/{x}/{y}.png';

  var tiles = new L.TileLayer( url, mkstyle(22677) ); // not 999
  var center = new L.LatLng( spots[0].latitude, spots[0].longitude );
  var map = new L.map( map_div_id, 
                       { center: center, 
                         zoom: 14,
                         layers: [ tiles, point_layer ]});
  // ... and maybe map.addControl ...
}

// XXX first mobile-specific JS.  Would need to adjust for a desktop version.

function spot_link_markup( spot ) {
  var url = "/spots/" + spot.id;
  var base = $('<div><a/></div>');
  anchor = base.find("a");
  anchor.attr('href', url );
  anchor.attr('onclick', "$.mobile.changePage('" + url + "'); return false");
  anchor.text( spot.name );
  return base.html();
}