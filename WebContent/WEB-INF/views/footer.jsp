<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://htmlcompressor.googlecode.com/taglib/compressor" prefix="compress" %>
<!-- Piwik -->

<script async type="text/javascript" src="http://<c:out value="${config.piwikServer}"/>/piwik.js" ></script>

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

<noscript>
	<p><img src="http://<c:out value="${config.piwikServer}"/>/piwik.php?idsite=1" style="border:0" alt="" /></p>
</noscript>
