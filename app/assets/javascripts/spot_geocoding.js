// Code to watch form fields in a 'spot' form, and re-geocode as appropriate.
//
// The bit of looking for IDs within a specific form is... dodgy.  The reason
// is that jQuery mobile loads all pages within a single DOM.  Rails gives
// me unique IDs for the forms, but not for the input elements within them.
//
// Hence the business here looking for inputs having known IDs *within*
// a particular form.
//
// This code would also be more tasteful if properly namespaced...

var geo_timeout = null;
var blank_rx = /^ *$/;

function end_geo_timeout() {
  if (geo_timeout != null) {
    clearTimeout( geo_timeout );
    geo_timeout = null;
  }
}

function set_geo_timeout( form_jq ) {
  end_geo_timeout();
  geo_timeout = setTimeout( function() { try_spot_geocode( form_jq ) }, 
                            3000 );
}

function spot_address( form_jq ) {
  var addr1 = form_jq.find("#spot_addr1").val();
  var addr2 = form_jq.find("#spot_addr2").val();
  if (addr1.match( blank_rx )) 
    return addr2;
  else if (addr2.match( blank_rx ))
    return addr1;
  else
    return addr1 + ", " + addr2;
}

function try_spot_geocode( form_jq ) {

  end_geo_timeout();
  form_jq.find("#geo_status").text("LOCATING...");

  var addr_string = spot_address( form_jq ).replace(/"/g, " ");  // ");

  var query = 'select * from geo.placefinder where text="'+addr_string+'"';
  var proto = document.location.protocol === "https:" ? "https" : "http";
  var qurl = proto + "://query.yahooapis.com/v1/public/yql?callback=?";
    
  $.get( qurl, { q: query, format: "json" },
    function(data) {
      var result = data.query.results.Result;
      if (result.quality > 50) {
        form_jq.find("#spot_latitude" ).val(result.latitude);
        form_jq.find("#spot_longitude").val(result.longitude);
        form_jq.find("#geo_status"    ).text("LOCATED");
      }
      else {
        form_jq.find("#geo_status").text("NOT LOCATED");
      }
    }, "json");
}

function init_spot_geocode( form_jq ) {
  form_jq.find("#spot_addr1").change( function(){ try_spot_geocode( form_jq )});
  form_jq.find("#spot_addr2").change( function(){ try_spot_geocode( form_jq )});
  form_jq.find("#spot_addr1").keypress(function(){ set_geo_timeout( form_jq )});
  form_jq.find("#spot_addr2").keypress(function(){ set_geo_timeout( form_jq )});
}

  
