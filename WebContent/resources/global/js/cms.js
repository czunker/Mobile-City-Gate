		$(document).ready(function() {
			$("button").button();
			$("#poidiv").hide();
			$("#routediv").hide();
			$("#categorydiv").hide();
			getClientsAndTheirData();
			//createPoiMap();
			//createRouteMap();
		});
		
		function createUploaderKML(url) {
			/* doesn't work
			if (uploaderKML) { return false; }
			*/
			uploaderKML = new plupload.Uploader({
				runtimes : 'gears,html5,browserplus',
				browse_button : 'pickfiles-kml',
				container : 'container-kml',
				url : url,
				max_file_size : '500kb',
				filters : [
					{title : "KML files", extensions : "kml"},
				],
				multipart : true
			});
		
			$('#uploadfiles-kml').click(function(e) {
				uploaderKML.start();
				e.preventDefault();
			});
		
			uploaderKML.bind('Init', function(up, params) {
				//$('#filelist-kml').html("<div>Current runtime: " + params.runtime + "</div>");
				$('#filelist-kml').html("<div>Diese Datei hochladen:</div>");
			});
			
			uploaderKML.init();
			
			uploaderKML.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist-kml').append(
						'<div id="' + file.id + '">' +
						file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
					'</div>');
				});
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderKML.bind('UploadProgress', function(up, file) {
				$('#' + file.id + " b").html(file.percent + "%");
			});
		
			uploaderKML.bind('Error', function(up, err) {
				$('#filelist-kml').append("<div>Fehler: " + err.code +
					", Fehlertext: " + err.message +
					(err.file ? ", Datei: " + err.file.name : "") +
					"</div>"
				);
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderKML.bind('FileUploaded', function(up, file, response) {
				$('#' + file.id + " b").html("100%");
			    $("#route-kml-file").val(response['response']);
			    setTimeout(function () { $('#filelist-kml').html("<div>Diese Datei hochladen:</div>"); },2000);
			});
		}
		
		function createUploaderIVRText(url) {
			/* doesn't work
			if (uploaderIVRText) { return false; }
			*/
			uploaderIVRText = new plupload.Uploader({
				runtimes : 'gears,html5,browserplus',
				browse_button : 'pickfiles-ivrtext',
				container : 'container-ivrtext',
				url : url,
				max_file_size : '500kb',
				filters : [
					{title : "HTML files", extensions : "html,htm"},
				],
				multipart : true
			});
		
			$('#uploadfiles-ivrtext').click(function(e) {
				uploaderIVRText.start();
				e.preventDefault();
			});
		
			uploaderIVRText.bind('Init', function(up, params) {
				//$('#filelist-ivrtext').html("<div>Current runtime: " + params.runtime + "</div>");
				$('#filelist-ivrtext').html("<div>Diese Datei hochladen:</div>");
			});
			
			uploaderIVRText.init();
			
			uploaderIVRText.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist-ivrtext').append(
						'<div id="' + file.id + '">' +
						file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
					'</div>');
				});
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderIVRText.bind('UploadProgress', function(up, file) {
				$('#' + file.id + " b").html(file.percent + "%");
			});
		
			uploaderIVRText.bind('Error', function(up, err) {
				$('#filelist-ivrtext').append("<div>Fehler: " + err.code +
					", Fehlertext: " + err.message +
					(err.file ? ", Datei: " + err.file.name : "") +
					"</div>"
				);
		
				up.refresh(); // Reposition Flash/Silverlight
			});
		
			uploaderIVRText.bind('FileUploaded', function(up, file, response) {
				$('#' + file.id + " b").html("100%");
			    $("#poi-ivr-text-url").val(response['response']);
			    setTimeout(function () { $('#filelist-ivrtext').html("<div>Diese Datei hochladen:</div>"); },2000);
			});
		}
		
		$(function() {
			$("#tabs").tabs();
			$("#colorSelector").ColorPicker({
				color: '#0000ff',
				onSubmit: function(hsb, hex, rgb, colpkr) {
					$(colpkr).val(hex);
					$("#route-color").val('#' + hex);
					$(colpkr).ColorPickerHide();
				},
				onShow: function (colpkr) {
					$(colpkr).fadeIn(500);
					return false;
				},
				onHide: function (colpkr) {
					$(colpkr).fadeOut(500);
					return false;
				},
				onChange: function (hsb, hex, rgb) {
					$("#colorSelector div").css('backgroundColor', '#' + hex);
					$("#route-color").val('#' + hex);
				}
			});
		});
		
		/*************************************************
		* Function: $.postJSON ( url, jsonObject, success, options )
		*    url:           The url to post the json object to
		*    jsonObject:    The JSON object to post
		*    success:       The success handler to invoke on successful submission
		*    options:       Additional options to provide to the AJAX call. This is the exact same object you would use when calling $.ajax directly.
		*
		* Description:
		* $.postJSON simplifies posting JSON objects to any url by invoking $.ajax with the required options. The specified JSON object will be stringified and posted to the url.
		* It's up to the server to deserialize the stringified JSON object. ASP.NET MVC 3 will do this automatically
		*
		* Sample usage:
		* var onSuccess = function() { ... };
		* var onError = function() { ... };
		* $.postJSON ( '/account/login', { username: 'jack', password: 'secretPass' }, onSuccess, { error: onError } );
		**************************************************/

		(function ($) {
		    $.extend({
		        postJSON: function (url, jsonData, success, options) {
		            var config = {
		                url: url,
		                type: "POST",
		                data: jsonData ? JSON.stringify(jsonData) : null,
		                dataType: "json",
		                contentType: "application/json; charset=utf-8",
		                success: success
		            };
		            $.ajax($.extend(options, config));
		        }
		    });
		})(jQuery);
		
		