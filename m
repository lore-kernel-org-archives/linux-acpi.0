From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: [PATCH] hysteresis for active cooling
Date: Sat, 23 Jul 2005 14:56:10 -0400
Message-ID: <E1DwPAQ-0006Oa-FA@approximate.corpus.cam.ac.uk>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

My laptop's fan was turning on and off as the temperature crossed the
active trip point.  The patch below adds hysteresis: It turns off active
cooling only when the temperature falls, say, 2 C below the trip point.
Maybe the magic difference should be 5 degrees; I'd be curious what
setting suits people best.

Tested and working on my TP 600X (Debian 'etch', kernel 2.6.11.4,
original DSDT with fixes).  It patches cleanly against 2.6.13-rc3 and is
conceptually simple, so I'd hope it works there too.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal


--- linux/drivers/acpi/thermal.c.old	2005-03-17 16:40:04.000000000 -0500
+++ linux/drivers/acpi/thermal.c	2005-07-23 13:44:35.000000000 -0400
@@ -66,6 +66,8 @@
 #define ACPI_THERMAL_MAX_ACTIVE	10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN 65
 
+#define AC_HYSTERESIS 2		/* active-cooling hysteresis, in C */
+
 #define KELVIN_TO_CELSIUS(t)    (long)(((long)t-2732>=0) ? ((long)t-2732+5)/10 : ((long)t-2732-5)/10)
 #define CELSIUS_TO_KELVIN(t)	((t+273)*10)
 
@@ -625,8 +627,14 @@
 		 * ----------------
 		 * Turn OFF all cooling devices associated with this
 		 * threshold.
+                 *
+		 * With hysteresis: Turn off only when temp is
+		 * AC_HYSTERESIS [in C] below threshold.  Safer to
+		 * adjust fan-off rather than fan-on behavior.
 		 */
-		else if (active->flags.enabled) {
+		else if (active->flags.enabled &&
+			 KELVIN_TO_CELSIUS(tz->temperature) <=
+			 KELVIN_TO_CELSIUS(active->temperature) - AC_HYSTERESIS) {
 			for (j = 0; j < active->devices.count; j++) {
 				result = acpi_bus_set_power(active->devices.handles[j], ACPI_STATE_D3);
 				if (result) {


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
