From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: [PATCH 6/6] ACPI:  update thermal temperature
Date: Thu, 10 Apr 2008 16:20:23 +0800
Message-ID: <1207815623.27304.49.camel@acpi-hp-zz.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56759 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbYDJIiB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 04:38:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


Fix the problem that thermal_get_temp returns the cached value,
which causes the temperature in generic thermal never updates.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/thermal.c
===================================================================
--- linux-2.6.orig/drivers/acpi/thermal.c
+++ linux-2.6/drivers/acpi/thermal.c
@@ -884,10 +884,15 @@ static void acpi_thermal_check(void *dat
 static int thermal_get_temp(struct thermal_zone_device *thermal, char *buf)
 {
 	struct acpi_thermal *tz = thermal->devdata;
+	int result;
 
 	if (!tz)
 		return -EINVAL;
 
+	result = acpi_thermal_get_temperature(tz);
+	if (result)
+		return result;
+
 	return sprintf(buf, "%ld\n", KELVIN_TO_MILLICELSIUS(tz->temperature));
 }
 


