From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH] Fix polling policy in the absence of _TZP
Date: Wed, 14 May 2008 02:00:00 +0100
Message-ID: <20080514010000.GB21608@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:45153 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1757356AbYENBAM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 May 2008 21:00:12 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Fix Linux to conform to 11.3.18 of the ACPI spec 3.0. In the absence of 
a _TZP method, we should be polling at a default frequency. While it can 
be argued that "0" is a default frequency, I don't think that's what the 
spec authors had in mind.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

Arguably this should be implemented in such a way that the polling rate 
increases as the temperature rises and drops if the trend is downwards. 
That would give higher resolution when we're heading towards a trip 
point, without any significant increase in power consumption since 
increased temperatures imply that the CPU is probably not idle.

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 504385b..93cb3e8 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -846,10 +846,11 @@ static void acpi_thermal_check(void *data)
 	 * Calculate Sleep Time
 	 * --------------------
 	 * If we're in the passive state, use _TSP's value.  Otherwise
-	 * use the default polling frequency (e.g. _TZP).  If no polling
-	 * frequency is specified then we'll wait forever (at least until
-	 * a thermal event occurs).  Note that _TSP and _TZD values are
-	 * given in 1/10th seconds (we must covert to milliseconds).
+	 * use the default polling frequency (e.g. _TZP).  If no
+	 * polling frequency is specified then we'll wait 10 seconds
+	 * (or until a thermal event occurs).  Note that _TSP and _TZD
+	 * values are given in 1/10th seconds (we must covert to
+	 * milliseconds).
 	 */
 	if (tz->state.passive) {
 		sleep_time = tz->trips.passive.tsp * 100;
@@ -1575,8 +1576,9 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	/* Get default polling frequency [_TZP] (optional) */
 	if (tzp)
 		tz->polling_frequency = tzp;
-	else
-		acpi_thermal_get_polling_frequency(tz);
+	else if (acpi_thermal_get_polling_frequency(tz) == -ENODEV)
+		/* If no _TZP, default to polling every 10 seconds */
+		tz->polling_frequency = 100;
 
 	return 0;
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
