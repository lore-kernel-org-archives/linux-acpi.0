From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer (take
 3)
Date: Fri, 03 Jul 2009 01:46:28 +0200
Message-ID: <4A4D46D4.7060101@marcansoft.com>
References: <4A4BA8F9.9070803@marcansoft.com>	<20090701112958.1d24e06f.akpm@linux-foundation.org>	<4A4C2EDC.6070209@marcansoft.com> <20090702155642.0d55ee57.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:53695 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbZGBXq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 2 Jul 2009 19:46:29 -0400
In-Reply-To: <20090702155642.0d55ee57.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> So please always resend the full changelog (possibly after revising 
> it) with each version of a patch.
Trying again then. Hope I nailed the right Thunderbird options this time
for optimal patch submission.


Acer Aspire 8930G laptops (and possibly others) report the battery
current as a 16-bit signed negative when it is charging. It also reports
it as 0x10000 when the current is 0. This patch adds a quirk for this
which takes the absolute value of the reported current cast to an s16.
This is a DSDT bug present in the latest BIOS revision (the EC register
is 16 bits signed and the DSDT attempts to take the 16-bit two's
complement of this, which works for discharge but not charge. It also
breaks zero values because a 32-bit register is used and the high bits
aren't thrown away).

I've enabled this for all Acer systems which report in mA units. This
should be safe since it won't break compliant systems unless they report
a current above 32A, which is insane. The patch also detects the valid
32-bit value -1, which indicates unknown status, and does not attempt
the fix in that case (note that this does not conflict with 16-bit -1,
which is 65535 as read normally and gets translated to 1mA).

Signed-off-by: Hector Martin <hector@marcansoft.com>
--- linux-2.6.30/drivers/acpi/battery.c.old	2009-07-02 04:04:52.000000000 +0200
+++ linux-2.6.30/drivers/acpi/battery.c	2009-07-02 04:07:20.000000000 +0200
@@ -85,6 +85,10 @@ static const struct acpi_device_id batte
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
+/* For buggy DSDTs that report negative 16-bit values for either charging
+ * or discharging current and/or report 0 as 65536 due to bad math.
+ */
+#define QUIRK_SIGNED16_CURRENT 0x0001
 
 struct acpi_battery {
 	struct mutex lock;
@@ -112,6 +116,7 @@ struct acpi_battery {
 	int state;
 	int power_unit;
 	u8 alarm_present;
+	long quirks;
 };
 
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
@@ -390,6 +395,11 @@ static int acpi_battery_get_state(struct
 				 state_offsets, ARRAY_SIZE(state_offsets));
 	battery->update_time = jiffies;
 	kfree(buffer.pointer);
+
+	if ((battery->quirks & QUIRK_SIGNED16_CURRENT) &&
+	    battery->rate_now != -1)
+		battery->rate_now = abs((s16)battery->rate_now);
+
 	return result;
 }
 
@@ -495,6 +505,14 @@ static void sysfs_remove_battery(struct 
 }
 #endif
 
+static void acpi_battery_quirks(struct acpi_battery *battery)
+{
+	battery->quirks = 0;
+	if (dmi_name_in_vendors("Acer") && battery->power_unit) {
+		battery->quirks |= QUIRK_SIGNED16_CURRENT;
+	}
+}
+
 static int acpi_battery_update(struct acpi_battery *battery)
 {
 	int result, old_present = acpi_battery_present(battery);
@@ -513,6 +531,7 @@ static int acpi_battery_update(struct ac
 		result = acpi_battery_get_info(battery);
 		if (result)
 			return result;
+		acpi_battery_quirks(battery);
 		acpi_battery_init_alarm(battery);
 	}
 #ifdef CONFIG_ACPI_SYSFS_POWER



-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc

