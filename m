From: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: FW: [PATCH] Fix ACPI passive thermal management
Date: Tue, 22 Nov 2005 11:31:57 +0800
Message-ID: <200511221131.57603.luming.yu@gmail.com>
References: <3ACA40606221794F80A5670F0AF15F84041AC228@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC228@pdsmsx403>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-AlSwsSmVLrQ@public.gmane.org
Cc: akpm-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> Hi!
>
> > Fix issue: passive mode is not left, once entered
> > http://bugzilla.kernel.org/show_bug.cgi?id=3410
>
> For this big patch, I believe you should provide longer description.

Oops, I forget this:

From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: [ACPI] Leave thermal passive cooling when machine cooled down
References: 98178

Patch to leave thermal passive cooling when machine cooled down.
Without this patch the polling frequency will always stay at
passive cooling trip point polling frequency (tsp - BIOS) instead of
tzp value (BIOS) or the possibly overridden value by
/proc/acpi/thermal_zone/*/polling_frequency.

This will cause critical shutdowns on hot machines with a high tsp
value exported by BIOS (e.g. the debugged machine (Thinkpad) exported
a value of 600 which means in passive mode the temperature is only polled
each 60 seconds).

Acked-by: okir-l3A5Bk7waGM@public.gmane.org


>From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>

>
> Please fix indentation
>
>
> ...and avoid C++ comments.
>
>
> It would be nice to at least fit comments into 80 columns.
>
>
> 							Pavel
The incremental patch addressing these comments:

diff -Bru a/drivers/acpi/processor_thermal.c 
b/drivers/acpi/processor_thermal.c
--- a/drivers/acpi/processor_thermal.c	2005-11-22 10:17:03.000000000 +0800
+++ b/drivers/acpi/processor_thermal.c	2005-11-22 10:17:51.000000000 +0800
@@ -127,10 +127,10 @@
 
 	if (cpufreq_thermal_reduction_pctg[cpu] > 20)
 		cpufreq_thermal_reduction_pctg[cpu] -= 20;
-        else
-                cpufreq_thermal_reduction_pctg[cpu] = 0;
+	else
+		cpufreq_thermal_reduction_pctg[cpu] = 0;
 	cpufreq_update_policy(cpu);
-	// We reached max freq again and can leave passive mode
+	/* We reached max freq again and can leave passive mode */
 	return !cpufreq_thermal_reduction_pctg[cpu];
 }
 
@@ -258,7 +258,7 @@
 
 		if (pr->flags.throttling) {
 			if (tx == 0) {
-                                max_tx_px = 1;
+				max_tx_px = 1;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "At minimum throttling state\n"));
 			} else {
@@ -269,8 +269,10 @@
 
 		result = acpi_thermal_cpufreq_decrease(pr->id);
 		if (result) {
-			// We only could get -ERANGE, 1 or 0.
-			// In the first two cases we reached max freq again.
+			/*
+			 * We only could get -ERANGE, 1 or 0.
+			 * In the first two cases we reached max freq again.
+			 */
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "At minimum performance state\n"));
 			max_tx_px = 1;
diff -Bru a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c	2005-11-22 10:17:33.000000000 +0800
+++ b/drivers/acpi/thermal.c	2005-11-22 10:18:17.000000000 +0800
@@ -558,15 +558,22 @@
 		/* Cooling off? */
 		else if (trend < 0) {
 			for (i = 0; i < passive->devices.count; i++)
-				// assume that we are on highest freq/lowest thrott
-				// and can leave passive mode, even in error case
-				if (!acpi_processor_set_thermal_limit(
-					    passive->devices.handles[i],
-					    ACPI_PROCESSOR_LIMIT_DECREMENT))
+				/*
+				 * assume that we are on highest
+				 * freq/lowest thrott and can leave
+				 * passive mode, even in error case
+				 */
+				if (!acpi_processor_set_thermal_limit
+				    (passive->devices.handles[i],
+				     ACPI_PROCESSOR_LIMIT_DECREMENT))
 					result = 0;
-			// Leave cooling mode, even if the temp might higher than trip point.
-			// This is because some machines might have long thermal polling 
frequencies
-			// (tsp) defined. We will fall back into passive mode in next cycle 
(probably quicker)
+			/*
+			 * Leave cooling mode, even if the temp might
+			 * higher than trip point This is because some
+			 * machines might have long thermal polling
+			 * frequencies (tsp) defined. We will fall back
+			 * into passive mode in next cycle (probably quicker)
+			 */
 			if (result) {
 				passive->flags.enabled = 0;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -584,17 +591,17 @@
 	 * and avoid thrashing around the passive trip point.  Note that we
 	 * assume symmetry.
 	 */
-	if (!passive->flags.enabled) 
+	if (!passive->flags.enabled)
 		return;
 	for (i = 0; i < passive->devices.count; i++)
-		if (!acpi_processor_set_thermal_limit(
-				passive->devices.handles[i],
-				ACPI_PROCESSOR_LIMIT_DECREMENT))
+		if (!acpi_processor_set_thermal_limit
+		    (passive->devices.handles[i],
+		     ACPI_PROCESSOR_LIMIT_DECREMENT))
 			result = 0;
 	if (result) {
 		passive->flags.enabled = 0;
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
-			"Disabling passive cooling (zone is cool)\n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Disabling passive cooling (zone is cool)\n"));
 	}
 }
 
@@ -624,22 +631,25 @@
 			 */
 			if (active->temperature > maxtemp)
 				tz->state.active_index = i;
-				maxtemp = active->temperature;
+			maxtemp = active->temperature;
 			if (active->flags.enabled)
 				continue;
 			for (j = 0; j < active->devices.count; j++) {
-				result = acpi_bus_set_power(active->devices.handles[j],
-							ACPI_STATE_D0);
+				result =
+				    acpi_bus_set_power(active->devices.
+						       handles[j],
+						       ACPI_STATE_D0);
 				if (result) {
 					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-								"Unable to turn cooling device [%p] 'on'\n",
-								active->devices.handles[j]));
+							  "Unable to turn cooling device [%p] 'on'\n",
+							  active->devices.
+							  handles[j]));
 					continue;
 				}
 				active->flags.enabled = 1;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-							"Cooling device [%p] now 'on'\n",
-							active->devices.handles[j]));
+						  "Cooling device [%p] now 'on'\n",
+						  active->devices.handles[j]));
 			}
 			continue;
 		}
@@ -653,17 +663,17 @@
 		 */
 		for (j = 0; j < active->devices.count; j++) {
 			result = acpi_bus_set_power(active->devices.handles[j],
-				ACPI_STATE_D3);
+						    ACPI_STATE_D3);
 			if (result) {
 				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-							"Unable to turn cooling device [%p] 'off'\n",
-							active->devices.handles[j]));
+						  "Unable to turn cooling device [%p] 'off'\n",
+						  active->devices.handles[j]));
 				continue;
 			}
 			active->flags.enabled = 0;
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						"Cooling device [%p] now 'off'\n",
-						active->devices.handles[j]));
+					  "Cooling device [%p] now 'off'\n",
+					  active->devices.handles[j]));
 		}
 	}
 }




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
