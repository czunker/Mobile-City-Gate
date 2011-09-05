// $(window).load($.mobile.silentScroll(0));

$(document).ready(function() {
	//$.mobile.silentScroll(0);
  	$(window).bind("orientationchange resize pageshow", fixgeometry);
});

$(window).load(function () { $.mobile.silentScroll(0); $('#loading').hide(); });

// Map zoom  
$("#plus").click(function(){
    map.zoomIn();
});
$("#minus").click(function(){
    map.zoomOut();
});

$("#north").click(function(){
    map.pan(0,-50);
});
$("#south").click(function(){
	map.pan(0,50);
});
$("#west").click(function(){
	map.pan(-50,0);
});
$("#east").click(function(){
	map.pan(50,0);
});

$("#location").click(function(){
    //determine if the handset has client side geo location capabilities
	if(geo_position_js.init()){
 		geo_position_js.getCurrentPosition(geo_success, geo_error);
 	}
});

// does not generate real guid, but this is not nessecary
// http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
function guidGenerator() {
    var S4 = function() {
       return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    };
    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}

//filter out some nasties
function filterData(data) {
	data = data.replace(/<?\/body[^>]*>/g,'');
	data = data.replace(/<--[Ss]*?-->/g,'');
	data = data.replace(/<noscript[^>]*>[Ss]*?<\/noscript>/g,'');
	data = data.replace(/<script[^>]*>[Ss]*?<\/script>/g,'');
	data = data.replace(/<script.*\/>/,'');
	return data;
}

function makePhoneCall(url) {
	alert(url);
	//$.get(url);
	window.localtion=url;
	//$("#"+currentPopupGuid).dialog('close');
}

//http://www.semicomplete.com/blog/geekery/jquery-mobile-full-height-content.html
var fixgeometry = function() {
	$("#north").css('top', 10);
	$("#north").css('left', $(window).width()*0.5);
	
	$("#south").css('bottom', 10);
	$("#south").css('left', $(window).width()*0.5);
	
	$("#east").css('top', $(window).height()*0.5);
	$("#east").css('right', 10);
	
	$("#west").css('top', $(window).height()*0.5);
	$("#west").css('left', 10);
	
	$("#location").css('bottom', 10);
	$("#location").css('right', 10);
	
	//don't know why it has to be 0, but otherwise it wouldn't on the same height with the other icons
	$("#navigation").css('bottom', 0);
	$("#navigation").css('left', 10);
	
	$('#mappage-content').height($(window).height()*0.98);
    //$('#mappage-content').width($(window).width());
};

//var mainPage;
// it is neccessary to generate random ids, otherwise you can call page() only once per dialog
// http://jquerymobiledictionary.dyndns.org/faq.html
function openPopup (evt) {
	//mainPage = $.mobile.activePage;
    var feature = evt.feature;
    if (currentPopupGuid) {
    	$("#"+currentPopupGuid).remove();
    }
    
    currentPopupGuid = guidGenerator();
    //remove close icon from header
    $("#"+currentPopupGuid).live('pagecreate', function() { $('div.ui-corner-top.ui-overlay-shadow.ui-bar-a.ui-header > a').remove(); });
    //data-position='inline' 
    var div_dialog = "<div id='"+currentPopupGuid+"' data-role='dialog'><div data-role='header'>";
    div_dialog += "<h1>"+feature.attributes["header"]+"</h1>";
    div_dialog += "</div><div data-role='content'>";
    div_dialog += feature.attributes["content"];
    div_dialog += "</div></div>";
    $.mobile.pageContainer.append(div_dialog);
    $("#"+currentPopupGuid).page();
    $("#"+currentPopupGuid).attr('data-url',currentPopupGuid);
    // deselect feature
    // is needed, otherwise you couldn't select the same POI again without clicking somewhere else on the map
    selectControl.unselect(feature);
    $.mobile.changePage("#"+currentPopupGuid, "pop");
    return false;
}

function openIvrPopup (url, headertext, closebuttontext) {
	if (currentIvrGuid) {
    	$("#"+currentIvrGuid).remove();
    }
    //if (currentPopupGuid) {
		// close other dialog
	    //$("#"+currentPopupGuid).remove();
	//}
	currentIvrGuid = guidGenerator();
	//remove close icon from header
    $('#' + currentIvrGuid).live('pagecreate', function() { $('div.ui-corner-top.ui-overlay-shadow.ui-bar-a.ui-header > a').remove(); });
    $('#' + currentIvrGuid).live('pagehide', function() { $("#"+currentPopupGuid).dialog('close'); });
    $.get(url ,	function(data) {
				var div_dialog = "<div id='"+currentIvrGuid+"' data-role='dialog'><div data-role='header'><h1>" + headertext + "</h1></div><div data-role='content'>";
			    div_dialog += filterData(data);
			    div_dialog += "<a href='#' onClick='closedDialog = true;' data-role='button' data-rel='back' data-transition='pop'>" + closebuttontext + "</a>";
			    div_dialog += "</div></div>";
			    $.mobile.pageContainer.append(div_dialog);
			    $("#"+currentIvrGuid).page();
			    $("#"+currentIvrGuid).attr('data-url',currentIvrGuid);
			    //$("#"+currentPopupGuid).dialog('close');
			    //var currentPopup = $.mobile.activePage;
			    //currentPopup.dialog('close');
			    //alert("currentPopupGuid: " + currentPopupGuid + " currentIvrGuid: " + currentIvrGuid);
			    $.mobile.changePage("#"+currentIvrGuid, "pop");
			    //alert("currentPopupGuid: " + currentPopupGuid + " currentIvrGuid: " + currentIvrGuid);
			    
			});
	return false;
}