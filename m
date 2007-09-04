From: Len Brown <lenb@kernel.org>
Subject: [PATCH] ACPI: thermal: use round_jiffies() when thermal zone polling is enabled
Date: Tue, 4 Sep 2007 07:27:20 -0400
Message-ID: <200709040727.20864.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57437 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbXIDLpp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Sep 2007 07:45:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>

From: Len Brown <len.brown@intel.com>

Properly functioning systems do not use thermal zone polling,
they use event-based notification.

However, some users enable periodic thermal zone polling
to work around bugs on their platforms, and at least one
platform exists with a real _TZP that requests polling.

While thermal zone polling (_TZP) is specified in units to 0.1 seconds,
it actually has a maximum granularity of 1 second.  Thus, we can safely
round up the _TZP timeout to occur on the next 1-second boundary.
This will batch it with other 1-second-granularity timers in the
system and thus potentially extend processor idle duration.

Note that the same timer is used both for _TZP
and for passive processor thermal throttling.
We can not round up the timeout when it is used
for passive thermal throttling.

Also, we can not make this a deferrable timer,
as temperature is just as relevant during idle
as it is during non-idle.

Signed-off-by: Len Brown <len.brown@intel.com>

Index: acpi/drivers/acpi/thermal.c
===================================================================
--- acpi.orig/drivers/acpi/thermal.c
+++ acpi/drivers/acpi/thermal.c
@@ -711,6 +711,7 @@ static void acpi_thermal_check(void *dat
 	int result = 0;
 	struct acpi_thermal *tz = data;
 	unsigned long sleep_time = 0;
+	unsigned long timeout_jiffies = 0;
 	int i = 0;
 	struct acpi_thermal_state state;
 
@@ -787,10 +788,13 @@ static void acpi_thermal_check(void *dat
 	 * a thermal event occurs).  Note that _TSP and _TZD values are
 	 * given in 1/10th seconds (we must covert to milliseconds).
 	 */
-	if (tz->state.passive)
+	if (tz->state.passive) {
 		sleep_time = tz->trips.passive.tsp * 100;
-	else if (tz->polling_frequency > 0)
+		timeout_jiffies =  jiffies + (HZ * sleep_time) / 1000;
+	} else if (tz->polling_frequency > 0) {
 		sleep_time = tz->polling_frequency * 100;
+		timeout_jiffies =  round_jiffies(jiffies + (HZ * sleep_time) / 1000);
+	}
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "%s: temperature[%lu] sleep[%lu]\n",
 			  tz->name, tz->temperature, sleep_time));
@@ -804,12 +808,11 @@ static void acpi_thermal_check(void *dat
 			del_timer(&(tz->timer));
 	} else {
 		if (timer_pending(&(tz->timer)))
-			mod_timer(&(tz->timer),
-					jiffies + (HZ * sleep_time) / 1000);
+			mod_timer(&(tz->timer), timeout_jiffies);
 		else {
 			tz->timer.data = (unsigned long)tz;
 			tz->timer.function = acpi_thermal_run;
-			tz->timer.expires = jiffies + (HZ * sleep_time) / 1000;
+			tz->timer.expires = timeout_jiffies;
 			add_timer(&(tz->timer));
 		}
 	}
