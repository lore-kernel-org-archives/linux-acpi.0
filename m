From: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Fix ACPI passive thermal management
Date: Sat, 19 Nov 2005 22:22:59 +0800
Message-ID: <200511192223.00151.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
To: akpm-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Fix issue: passive mode is not left, once entered
http://bugzilla.kernel.org/show_bug.cgi?id=3410

Signed-off-by: Luming Yu
Cc: "Brown, Len" 
Signed-off-by: Alexey Starikovskiy  (alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org)
Signed-off-by: Thomas Renninger (trenn-l3A5Bk7waGM@public.gmane.org)
---
 processor_thermal.c |   36 ++++++-----
 thermal.c           |  159 
+++++++++++++++++++++++++---------------------------
 2 files changed, 99 insertions(+), 96 deletions(-)

diff --git a/drivers/acpi/processor_thermal.c 
b/drivers/acpi/processor_thermal.c
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -101,9 +101,7 @@ static unsigned int acpi_thermal_cpufreq
 static int cpu_has_cpufreq(unsigned int cpu)
 {
 	struct cpufreq_policy policy;
-	if (!acpi_thermal_cpufreq_is_init)
-		return -ENODEV;
-	if (!cpufreq_get_policy(&policy, cpu))
+	if (!acpi_thermal_cpufreq_is_init || cpufreq_get_policy(&policy, cpu))
 		return -ENODEV;
 	return 0;
 }
@@ -127,13 +125,13 @@ static int acpi_thermal_cpufreq_decrease
 	if (!cpu_has_cpufreq(cpu))
 		return -ENODEV;
 
-	if (cpufreq_thermal_reduction_pctg[cpu] >= 20) {
+	if (cpufreq_thermal_reduction_pctg[cpu] > 20)
 		cpufreq_thermal_reduction_pctg[cpu] -= 20;
-		cpufreq_update_policy(cpu);
-		return 0;
-	}
-
-	return -ERANGE;
+        else
+                cpufreq_thermal_reduction_pctg[cpu] = 0;
+	cpufreq_update_policy(cpu);
+	// We reached max freq again and can leave passive mode
+	return !cpufreq_thermal_reduction_pctg[cpu];
 }
 
 static int acpi_thermal_cpufreq_notifier(struct notifier_block *nb,
@@ -200,7 +198,7 @@ int acpi_processor_set_thermal_limit(acp
 	int result = 0;
 	struct acpi_processor *pr = NULL;
 	struct acpi_device *device = NULL;
-	int tx = 0;
+	int tx = 0, max_tx_px = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_processor_set_thermal_limit");
 
@@ -259,19 +257,25 @@ int acpi_processor_set_thermal_limit(acp
 		/* if going down: T-states first, P-states later */
 
 		if (pr->flags.throttling) {
-			if (tx == 0)
+			if (tx == 0) {
+                                max_tx_px = 1;
 				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 						  "At minimum throttling state\n"));
-			else {
+			} else {
 				tx--;
 				goto end;
 			}
 		}
 
 		result = acpi_thermal_cpufreq_decrease(pr->id);
-		if (result == -ERANGE)
+		if (result) {
+			// We only could get -ERANGE, 1 or 0.
+			// In the first two cases we reached max freq again.
 			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 					  "At minimum performance state\n"));
+			max_tx_px = 1;
+		} else
+			max_tx_px = 0;
 
 		break;
 	}
@@ -290,8 +294,10 @@ int acpi_processor_set_thermal_limit(acp
 				  pr->limit.thermal.px, pr->limit.thermal.tx));
 	} else
 		result = 0;
-
-	return_VALUE(result);
+	if (max_tx_px)
+		return_VALUE(1);
+	else
+		return_VALUE(result);
 }
 
 int acpi_processor_get_limit_info(struct acpi_processor *pr)
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -72,7 +72,7 @@
 #define _COMPONENT		ACPI_THERMAL_COMPONENT
 ACPI_MODULE_NAME("acpi_thermal")
 
-    MODULE_AUTHOR("Paul Diefenbaugh");
+MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
 MODULE_LICENSE("GPL");
 
@@ -517,9 +517,9 @@ static int acpi_thermal_hot(struct acpi_
 	return_VALUE(0);
 }
 
-static int acpi_thermal_passive(struct acpi_thermal *tz)
+static void acpi_thermal_passive(struct acpi_thermal *tz)
 {
-	int result = 0;
+	int result = 1;
 	struct acpi_thermal_passive *passive = NULL;
 	int trend = 0;
 	int i = 0;
@@ -527,7 +527,7 @@ static int acpi_thermal_passive(struct a
 	ACPI_FUNCTION_TRACE("acpi_thermal_passive");
 
 	if (!tz || !tz->trips.passive.flags.valid)
-		return_VALUE(-EINVAL);
+		return;
 
 	passive = &(tz->trips.passive);
 
@@ -547,7 +547,7 @@ static int acpi_thermal_passive(struct a
 				  trend, passive->tc1, tz->temperature,
 				  tz->last_temperature, passive->tc2,
 				  tz->temperature, passive->temperature));
-		tz->trips.passive.flags.enabled = 1;
+		passive->flags.enabled = 1;
 		/* Heating up? */
 		if (trend > 0)
 			for (i = 0; i < passive->devices.count; i++)
@@ -556,12 +556,25 @@ static int acpi_thermal_passive(struct a
 								 handles[i],
 								 ACPI_PROCESSOR_LIMIT_INCREMENT);
 		/* Cooling off? */
-		else if (trend < 0)
+		else if (trend < 0) {
 			for (i = 0; i < passive->devices.count; i++)
-				acpi_processor_set_thermal_limit(passive->
-								 devices.
-								 handles[i],
-								 ACPI_PROCESSOR_LIMIT_DECREMENT);
+				// assume that we are on highest freq/lowest thrott
+				// and can leave passive mode, even in error case
+				if (!acpi_processor_set_thermal_limit(
+					    passive->devices.handles[i],
+					    ACPI_PROCESSOR_LIMIT_DECREMENT))
+					result = 0;
+			// Leave cooling mode, even if the temp might higher than trip point.
+			// This is because some machines might have long thermal polling 
frequencies
+			// (tsp) defined. We will fall back into passive mode in next cycle 
(probably quicker)
+			if (result) {
+				passive->flags.enabled = 0;
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+						  "Disabling passive cooling, still above threshold,"
+						  " but we are cooling down\n"));
+			}
+		}
+		return;
 	}
 
 	/*
@@ -571,23 +584,21 @@ static int acpi_thermal_passive(struct a
 	 * and avoid thrashing around the passive trip point.  Note that we
 	 * assume symmetry.
 	 */
-	else if (tz->trips.passive.flags.enabled) {
-		for (i = 0; i < passive->devices.count; i++)
-			result =
-			    acpi_processor_set_thermal_limit(passive->devices.
-							     handles[i],
-							     ACPI_PROCESSOR_LIMIT_DECREMENT);
-		if (result == 1) {
-			tz->trips.passive.flags.enabled = 0;
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-					  "Disabling passive cooling (zone is cool)\n"));
-		}
+	if (!passive->flags.enabled) 
+		return;
+	for (i = 0; i < passive->devices.count; i++)
+		if (!acpi_processor_set_thermal_limit(
+				passive->devices.handles[i],
+				ACPI_PROCESSOR_LIMIT_DECREMENT))
+			result = 0;
+	if (result) {
+		passive->flags.enabled = 0;
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
+			"Disabling passive cooling (zone is cool)\n"));
 	}
-
-	return_VALUE(0);
 }
 
-static int acpi_thermal_active(struct acpi_thermal *tz)
+static void acpi_thermal_active(struct acpi_thermal *tz)
 {
 	int result = 0;
 	struct acpi_thermal_active *active = NULL;
@@ -598,74 +609,63 @@ static int acpi_thermal_active(struct ac
 	ACPI_FUNCTION_TRACE("acpi_thermal_active");
 
 	if (!tz)
-		return_VALUE(-EINVAL);
+		return;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-
 		active = &(tz->trips.active[i]);
 		if (!active || !active->flags.valid)
 			break;
-
-		/*
-		 * Above Threshold?
-		 * ----------------
-		 * If not already enabled, turn ON all cooling devices
-		 * associated with this active threshold.
-		 */
 		if (tz->temperature >= active->temperature) {
+			/*
+			 * Above Threshold?
+			 * ----------------
+			 * If not already enabled, turn ON all cooling devices
+			 * associated with this active threshold.
+			 */
 			if (active->temperature > maxtemp)
-				tz->state.active_index = i, maxtemp =
-				    active->temperature;
-			if (!active->flags.enabled) {
-				for (j = 0; j < active->devices.count; j++) {
-					result =
-					    acpi_bus_set_power(active->devices.
-							       handles[j],
-							       ACPI_STATE_D0);
-					if (result) {
-						ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-								  "Unable to turn cooling device [%p] 'on'\n",
-								  active->
-								  devices.
-								  handles[j]));
-						continue;
-					}
-					active->flags.enabled = 1;
-					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-							  "Cooling device [%p] now 'on'\n",
-							  active->devices.
-							  handles[j]));
+				tz->state.active_index = i;
+				maxtemp = active->temperature;
+			if (active->flags.enabled)
+				continue;
+			for (j = 0; j < active->devices.count; j++) {
+				result = acpi_bus_set_power(active->devices.handles[j],
+							ACPI_STATE_D0);
+				if (result) {
+					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+								"Unable to turn cooling device [%p] 'on'\n",
+								active->devices.handles[j]));
+					continue;
 				}
+				active->flags.enabled = 1;
+				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+							"Cooling device [%p] now 'on'\n",
+							active->devices.handles[j]));
 			}
+			continue;
 		}
+		if (!active->flags.enabled)
+			continue;
 		/*
 		 * Below Threshold?
 		 * ----------------
 		 * Turn OFF all cooling devices associated with this
 		 * threshold.
 		 */
-		else if (active->flags.enabled) {
-			for (j = 0; j < active->devices.count; j++) {
-				result =
-				    acpi_bus_set_power(active->devices.
-						       handles[j],
-						       ACPI_STATE_D3);
-				if (result) {
-					ACPI_DEBUG_PRINT((ACPI_DB_WARN,
-							  "Unable to turn cooling device [%p] 'off'\n",
-							  active->devices.
-							  handles[j]));
-					continue;
-				}
-				active->flags.enabled = 0;
-				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-						  "Cooling device [%p] now 'off'\n",
-						  active->devices.handles[j]));
+		for (j = 0; j < active->devices.count; j++) {
+			result = acpi_bus_set_power(active->devices.handles[j],
+				ACPI_STATE_D3);
+			if (result) {
+				ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+							"Unable to turn cooling device [%p] 'off'\n",
+							active->devices.handles[j]));
+				continue;
 			}
+			active->flags.enabled = 0;
+			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+						"Cooling device [%p] now 'off'\n",
+						active->devices.handles[j]));
 		}
 	}
-
-	return_VALUE(0);
 }
 
 static void acpi_thermal_check(void *context);
@@ -744,15 +744,12 @@ static void acpi_thermal_check(void *dat
 	 * Again, separated from the above two to allow independent policy
 	 * decisions.
 	 */
-	if (tz->trips.critical.flags.enabled)
-		tz->state.critical = 1;
-	if (tz->trips.hot.flags.enabled)
-		tz->state.hot = 1;
-	if (tz->trips.passive.flags.enabled)
-		tz->state.passive = 1;
+	tz->state.critical = tz->trips.critical.flags.enabled;
+	tz->state.hot = tz->trips.hot.flags.enabled;
+	tz->state.passive = tz->trips.passive.flags.enabled;
+	tz->state.active = 0;
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		if (tz->trips.active[i].flags.enabled)
-			tz->state.active = 1;
+		tz->state.active |= tz->trips.active[i].flags.enabled;
 
 	/*
 	 * Calculate Sleep Time


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
