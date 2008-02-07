From: Len Brown <lenb@kernel.org>
Subject: [PATCH 080/112] ACPI: battery: add sysfs serial number
Date: Thu,  7 Feb 2008 04:34:42 -0500
Message-ID: <7c2670bbb53820d0a4fab8d74593eeccd1eef225.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:9414 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753894AbYBGJgh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:37 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: maximilian attems <max@stro.at>, Len Brown <len.brown@intel.com>

From: maximilian attems <max@stro.at>

egrep serial /proc/acpi/battery/BAT0/info
serial number:           32090

serial number can tell you from the imminent danger
of beeing set on fire.

Signed-off-by: maximilian attems <max@stro.at>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c             |    5 +++++
 drivers/power/power_supply_sysfs.c |    1 +
 include/linux/power_supply.h       |    1 +
 3 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c4a769d..f6215e8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -194,6 +194,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = battery->oem_info;
 		break;
+	case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+		val->strval = battery->serial_number;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -212,6 +215,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
 static enum power_supply_property energy_battery_props[] = {
@@ -226,6 +230,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 #endif
 
diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index d482484..ad2bed0 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -116,6 +116,7 @@ static struct device_attribute power_supply_attrs[] = {
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_ATTR(model_name),
 	POWER_SUPPLY_ATTR(manufacturer),
+	POWER_SUPPLY_ATTR(serial_number),
 };
 
 static ssize_t power_supply_show_static_attrs(struct device *dev,
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 5cbf3e3..68ed19c 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -94,6 +94,7 @@ enum power_supply_property {
 	/* Properties of type `const char *' */
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
 enum power_supply_type {
-- 
1.5.4.23.gef5b9

