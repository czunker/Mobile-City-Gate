<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<!-- Piwik -->
<script async type="text/javascript" src="http://<c:out value="${config.piwikServer}"/>/piwik.js" ></script>
<!-- var pkBaseURL = (("https:" == document.location.protocol) ? "https://www.mobiles-stadttor.de/piwik/" : "http://www.mobiles-stadttor.de/piwik/"); 
var pkBaseURL = "http://<c:out value="${config.piwikServer}"/>/";
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
-->
<script async type="text/javascript">
<compress:js>
try {
var pkBaseURL = "http://<c:out value="${config.piwikServer}"/>/";
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</compress:js>
</script>
<noscript><p><img src="http://<c:out value="${config.piwikServer}"/>/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
<!-- End Piwik Tracking Code -->