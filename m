From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/2] Give ACPI hwmon thermal devices a name if BIOS provides one
Date: Mon, 25 Aug 2008 00:11:37 +0200
Message-ID: <1219615897-21130-3-git-send-email-trenn@suse.de>
References: <20080821174852.0689681d@hyperion.delvare>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38097 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203AbYHXWLj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Aug 2008 18:11:39 -0400
In-Reply-To: <20080821174852.0689681d@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: khali@linux-fr.org
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>

On a HP tx2500z laptop one thermal device provides this function:
            Name (REGN, "Processor Thermal Zone")

Evaluate it and pass it as a name to hwmon.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/thermal.c        |   15 ++++++++++++++-
 drivers/thermal/thermal_sys.c |   11 +++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9127036..8095e9e 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1600,11 +1600,24 @@ static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 static int acpi_thermal_get_info(struct acpi_thermal *tz)
 {
 	int result = 0;
-
+	char *name = NULL;
+	acpi_status status;
 
 	if (!tz)
 		return -EINVAL;
 
+	/* Get optional name of the thermal zone */
+	status = acpi_evaluate_string(tz->device->handle, "REGN", NULL,
+				      &name);
+	if (ACPI_SUCCESS(status)){
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Thermal zone %s has name: "
+				  "%s\n", acpi_device_bid(tz->device), name));
+		/* This is hard coded limited to 16, why? */
+		strncpy(tz->thermal_zone->temp_input.name, name, 16);
+		kfree(name);
+		tz->thermal_zone->temp_input.name[15] = '\n';
+	}
+
 	/* Get temperature [_TMP] (required) */
 	result = acpi_thermal_get_temperature(tz);
 	if (result)
diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index fe07462..51a7077 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -371,8 +371,15 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	tz->hwmon = hwmon;
 	hwmon->count++;
 
-	snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
-		 "temp%d_input", hwmon->count);
+	/*
+	 * What happens if we get duplicate zone names from the BIOS?
+	 * Is that allowed? If not, should we still just add the
+	 * hwmon count at the end?
+	 * tz->temp_input.name is char[16], this is ugly to do...
+	 */
+	if (!tz->temp_input.name)
+		snprintf(tz->temp_input.name, THERMAL_NAME_LENGTH,
+			 "temp%d_input", hwmon->count);
 	tz->temp_input.attr.attr.name = tz->temp_input.name;
 	tz->temp_input.attr.attr.mode = 0444;
 	tz->temp_input.attr.show = temp_input_show;
-- 
1.5.4.5

