From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH] ACPI: Evaluate thermal trip points before reading temperature
Date: Mon, 29 Aug 2011 09:33:47 -0400
Message-ID: <1314624827-27094-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10747 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753616Ab1H2Nen (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Aug 2011 09:34:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rui.zhang@intel.com, Matthew Garrett <mjg@redhat.com>

An HP laptop (Pavilion G4-1016tx) has the following code in _TMP:

       Store (\_SB.PCI0.LPCB.EC0.RTMP, Local0)
       If (LGreaterEqual (Local0, S4TP))
       {
           Store (One, HTS4)
       }

S4TP is initialised at 0 and not programmed further until either _HOT or
_CRT is called. If we evaluate _TMP before the trip points then HTS4 will
always be set, causing the firmware to generate a message on boot
complaining that the system shut down because of overheating. The simplest
solution is just to reverse the checking of trip points and _TMP in thermal
init.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/thermal.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 48fbc64..7dbebea 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -941,13 +941,13 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	if (!tz)
 		return -EINVAL;
 
-	/* Get temperature [_TMP] (required) */
-	result = acpi_thermal_get_temperature(tz);
+	/* Get trip points [_CRT, _PSV, etc.] (required) */
+	result = acpi_thermal_get_trip_points(tz);
 	if (result)
 		return result;
 
-	/* Get trip points [_CRT, _PSV, etc.] (required) */
-	result = acpi_thermal_get_trip_points(tz);
+	/* Get temperature [_TMP] (required) */
+	result = acpi_thermal_get_temperature(tz);
 	if (result)
 		return result;
 
-- 
1.7.6

