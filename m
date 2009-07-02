From: Hector Martin <hector@marcansoft.com>
Subject: Re: [PATCH] Work around negative s16 battery current on Acer
Date: Thu, 02 Jul 2009 05:51:56 +0200
Message-ID: <4A4C2EDC.6070209@marcansoft.com>
References: <4A4BA8F9.9070803@marcansoft.com> <20090701112958.1d24e06f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060003060007050604080107"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from marcansoft.com ([80.68.93.119]:41982 "EHLO smtp.marcansoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbZGBDvz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2009 23:51:55 -0400
In-Reply-To: <20090701112958.1d24e06f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: astarikovskiy@suse.de, lenb@kernel.org, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060003060007050604080107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> acpi_battery has no field `current_now' in 2.6.30 or 2.6.31-rc1.  Which
> kernel version are you patching here?

Updated patch for 2.6.30 attached. current_now got renamed to rate_now.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------060003060007050604080107
Content-Type: text/plain;
 name="acpi-battery-acer-rate-quirk2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpi-battery-acer-rate-quirk2.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com">
--- linux-2.6.30-gentoo-r1/drivers/acpi/battery.c.old	2009-07-02 04:04:52.000000000 +0200
+++ linux-2.6.30-gentoo-r1/drivers/acpi/battery.c	2009-07-02 04:07:20.000000000 +0200
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

--------------060003060007050604080107--
