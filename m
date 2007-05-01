From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: delete un-reliable concept of cooling mode
Date: Mon, 30 Apr 2007 23:35:53 -0400
Message-ID: <200704302335.54271.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47154 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbXEACeY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 22:34:24 -0400
Received: from [10.251.2.25] ([192.102.209.1])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l412X9WZ021494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 1 May 2007 02:34:23 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The scheme where the thermal driver displayed the
cooling mode /proc/acpi/thermal_zone/*/cooling_mode
was flawed in two ways.

First, the success of _SCP doesn't actually mean
that the BIOS moved any trip points.
On many BIOS, _SCP is present, but does nothing.
So displaying what _SCP executed actually
was wrong more times than it was right.

Second, examining the relative position of the
trip points when the thermal_zone is added
is insufficient -- as the BIOS reserves the right
to change the trip points at run-time.

The only reliable way for the user to determine if
the thermal zone is in active, passive, or critical
mode is to examine the relative position of the trip points.
The user can do this without the kernel doing it
for them by looking in /proc/acpi/thermal_zone/*/trip_points

New contents for /proc/acpi/thermal_zone/*/cooling_mode:

If _SCP available:
"0 - Active; 1 - Passive\n"

If _SCP unavailable:
"<setting not supported>\n"

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   39 ++-------------------------------------
 1 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 73b6fe7..1ada017 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -59,8 +59,6 @@
 #define ACPI_THERMAL_NOTIFY_CRITICAL	0xF0
 #define ACPI_THERMAL_NOTIFY_HOT		0xF1
 #define ACPI_THERMAL_MODE_ACTIVE	0x00
-#define ACPI_THERMAL_MODE_PASSIVE	0x01
-#define ACPI_THERMAL_MODE_CRITICAL   	0xff
 #define ACPI_THERMAL_PATH_POWEROFF	"/sbin/poweroff"
 
 #define ACPI_THERMAL_MAX_ACTIVE	10
@@ -164,7 +162,6 @@ struct acpi_thermal {
 	unsigned long temperature;
 	unsigned long last_temperature;
 	unsigned long polling_frequency;
-	u8 cooling_mode;
 	volatile u8 zombie;
 	struct acpi_thermal_flags flags;
 	struct acpi_thermal_state state;
@@ -293,11 +290,6 @@ static int acpi_thermal_set_cooling_mode(struct acpi_thermal *tz, int mode)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	tz->cooling_mode = mode;
-
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Cooling mode [%s]\n",
-			  mode ? "passive" : "active"));
-
 	return 0;
 }
 
@@ -893,15 +885,10 @@ static int acpi_thermal_cooling_seq_show(struct seq_file *seq, void *offset)
 	if (!tz)
 		goto end;
 
-	if (!tz->flags.cooling_mode) {
+	if (!tz->flags.cooling_mode)
 		seq_puts(seq, "<setting not supported>\n");
-	}
-
-	if (tz->cooling_mode == ACPI_THERMAL_MODE_CRITICAL)
-		seq_printf(seq, "cooling mode:	critical\n");
 	else
-		seq_printf(seq, "cooling mode:	%s\n",
-			   tz->cooling_mode ? "passive" : "active");
+		seq_puts(seq, "0 - Active; 1 - Passive\n");
 
       end:
 	return 0;
@@ -1158,28 +1145,6 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	result = acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
 	if (!result)
 		tz->flags.cooling_mode = 1;
-	else {
-		/* Oh,we have not _SCP method.
-		   Generally show cooling_mode by _ACx, _PSV,spec 12.2 */
-		tz->flags.cooling_mode = 0;
-		if (tz->trips.active[0].flags.valid
-		    && tz->trips.passive.flags.valid) {
-			if (tz->trips.passive.temperature >
-			    tz->trips.active[0].temperature)
-				tz->cooling_mode = ACPI_THERMAL_MODE_ACTIVE;
-			else
-				tz->cooling_mode = ACPI_THERMAL_MODE_PASSIVE;
-		} else if (!tz->trips.active[0].flags.valid
-			   && tz->trips.passive.flags.valid) {
-			tz->cooling_mode = ACPI_THERMAL_MODE_PASSIVE;
-		} else if (tz->trips.active[0].flags.valid
-			   && !tz->trips.passive.flags.valid) {
-			tz->cooling_mode = ACPI_THERMAL_MODE_ACTIVE;
-		} else {
-			/* _ACx and _PSV are optional, but _CRT is required */
-			tz->cooling_mode = ACPI_THERMAL_MODE_CRITICAL;
-		}
-	}
 
 	/* Get default polling frequency [_TZP] (optional) */
 	if (tzp)
-- 
1.5.0.1.771.g77e6f

