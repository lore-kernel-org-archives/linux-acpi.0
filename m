From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/37] ACPI: thermal: use round_jiffies when thermal zone polling is enabled
Date: Wed, 10 Oct 2007 01:06:10 -0400
Message-ID: <1191992804-14965-4-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:45224 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbXJJFGr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Oct 2007 01:06:47 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <21bc42ab852549f4a547d18d77e0e4d1b24ffd96.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

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
---
 drivers/acpi/thermal.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index bc6d586..15d5fdc 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -711,6 +711,7 @@ static void acpi_thermal_check(void *data)
 	int result = 0;
 	struct acpi_thermal *tz = data;
 	unsigned long sleep_time = 0;
+	unsigned long timeout_jiffies = 0;
 	int i = 0;
 	struct acpi_thermal_state state;
 
@@ -787,10 +788,13 @@ static void acpi_thermal_check(void *data)
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
@@ -804,12 +808,11 @@ static void acpi_thermal_check(void *data)
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
-- 
1.5.3.4.206.g58ba4
