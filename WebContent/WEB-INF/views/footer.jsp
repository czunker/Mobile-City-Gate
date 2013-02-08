<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<!-- Piwik -->
<script type="text/javascript" src="http://<c:out value="${config.piwikServer}"/>/piwik.js">
<!-- var pkBaseURL = (("https:" == document.location.protocol) ? "https://www.mobiles-stadttor.de/piwik/" : "http://www.mobiles-stadttor.de/piwik/"); 
var pkBaseURL = "http://<c:out value="${config.piwikServer}"/>/";
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
-->
</script>
<script type="text/javascript">
try {
var pkBaseURL = "http://<c:out value="${config.piwikServer}"/>/";
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</script><noscript><p><img src="http://<c:out value="${config.piwikServer}"/>/piwik.php?idsite=1" style="border:0" alt="" /></p></noscript>
<!-- End Piwik Tracking Code -->