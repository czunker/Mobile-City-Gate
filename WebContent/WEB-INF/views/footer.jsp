<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<%-- Piwik --%>  
<script type="text/javascript">
<compress:js>
var pkBaseURL = (("https:" == document.location.protocol) ? "https://mmis22.pcconsultants.de/piwik/" : "http://mmis22.pcconsultants.de/piwik/");
document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
</compress:js>
</script>
<script type="text/javascript">
<compress:js>
try {
var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
piwikTracker.trackPageView();
piwikTracker.enableLinkTracking();
} catch( err ) {}
</compress:js>
</script>
<noscript>
<p><img src="http://mmis22.pcconsultants.de/piwik/piwik.php?idsite=1" style="border:0" alt="" /></p>
</noscript>
<%-- End Piwik Tracking Code --%>