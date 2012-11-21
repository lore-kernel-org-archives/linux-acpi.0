From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Subject: [PATCH] acpi: Read temperature before trip points for HP Compaq
 6715b and 6715s
Date: Wed, 21 Nov 2012 23:26:20 +0100
Message-ID: <20121121222619.GA9078@tweety>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:33888 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281Ab2KVTzj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Nov 2012 14:55:39 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so3332366eaa.19
        for <linux-acpi@vger.kernel.org>; Thu, 22 Nov 2012 11:55:38 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: Suloev Dmitry <suloevdmitry@gmail.com>, Thomas Renninger <trenn@suse.de>, Katabami Kohei <katabami@lavabit.com>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org

From: Katabami Kohei <katabami@lavabit.com>

For HP Compaq 6715b and 6715s, temperature has to be read before
trip points. This fixes bug #43284 which is introduced by:

commit 9bcb8118965ab4631a65ee0726e6518f75cda6c5
Author: Matthew Garrett <mjg <at> redhat.com>
Date:   Wed Feb 1 10:26:54 2012 -0500

  ACPI: Evaluate thermal trip points before reading temperature

The patch is originally written by Jason Vas Dias:
http://thread.gmane.org/gmane.linux.kernel/1324409/focus=1324503

Katabami cleaned it up.

Cc: stable@vger.kernel.org # >= 3.4
Reported-by: Suloev Dmitry <suloevdmitry@gmail.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Katabami Kohei <katabami@lavabit.com>
Signed-off-by: Andreas Herrmann <herrmann.der.user@googlemail.com>
---
 drivers/acpi/thermal.c |   56 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

Hi Len,

I didn't find Katabami's patch in your git tree. Please apply this
patch as soon as possible as in fact it's fixing a regression that was
introduced with Matthew's change.

The corresponding bug report is
http://bugzilla.kernel.org/show_bug.cgi?id=43284

I've rebased the patch on v3.7-rc6-46-g45e7715 and also added a stable
tag.


Thanks,

Andreas

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 804204d..5efb9de 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -96,6 +96,8 @@ static int psv;
 module_param(psv, int, 0644);
 MODULE_PARM_DESC(psv, "Disable or override all passive trip points.");
 
+static int temp_before_trip;
+
 static int acpi_thermal_add(struct acpi_device *device);
 static int acpi_thermal_remove(struct acpi_device *device, int type);
 static void acpi_thermal_notify(struct acpi_device *device, u32 event);
@@ -992,15 +994,32 @@ static int acpi_thermal_get_info(struct acpi_thermal *tz)
 	if (!tz)
 		return -EINVAL;
 
-	/* Get trip points [_CRT, _PSV, etc.] (required) */
-	result = acpi_thermal_get_trip_points(tz);
-	if (result)
-		return result;
+	if (temp_before_trip) {
+		/*
+		 * some hardwares need temperature before trip points
+		 * can be obtained
+		 */
 
-	/* Get temperature [_TMP] (required) */
-	result = acpi_thermal_get_temperature(tz);
-	if (result)
-		return result;
+		/* Get temperature [_TMP] (required) */
+		result = acpi_thermal_get_temperature(tz);
+		if (result)
+			return result;
+
+		/* Get trip points [_CRT, _PSV, etc.] (required) */
+		result = acpi_thermal_get_trip_points(tz);
+		if (result)
+			return result;
+	} else {
+		/* Get trip points [_CRT, _PSV, etc.] (required) */
+		result = acpi_thermal_get_trip_points(tz);
+		if (result)
+			return result;
+
+		/* Get temperature [_TMP] (required) */
+		result = acpi_thermal_get_temperature(tz);
+		if (result)
+			return result;
+		}
 
 	/* Set the cooling mode [_SCP] to active cooling (default) */
 	result = acpi_thermal_set_cooling_mode(tz, ACPI_THERMAL_MODE_ACTIVE);
@@ -1164,6 +1183,15 @@ static int thermal_psv(const struct dmi_system_id *d) {
 	return 0;
 }
 
+static int thermal_temp_before_trip(const struct dmi_system_id *d)
+{
+
+	printk(KERN_NOTICE "ACPI: %s detected: getting temperature before trip point initialisation\n",
+	       d->ident);
+	temp_before_trip = 1;
+	return 0;
+}
+
 static struct dmi_system_id thermal_dmi_table[] __initdata = {
 	/*
 	 * Award BIOS on this AOpen makes thermal control almost worthless.
@@ -1201,6 +1229,18 @@ static struct dmi_system_id thermal_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_BOARD_NAME, "7ZX"),
 		},
 	},
+	/*
+	 * Some HP Compaq require temperature before trip points
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=43284
+	 */
+	{
+	 .callback = thermal_temp_before_trip,
+	 .ident = "HP Compaq 6715b or 6715s",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq 6715"),
+		},
+	},
 	{}
 };
 
-- 
1.7.9.5

