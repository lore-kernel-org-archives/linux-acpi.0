From: Alex Hung <alex.hung@canonical.com>
Subject: [PATCH 1/2] firmware: dmi_scan: add DMI_OEM_STRING support to dmi_matches
Date: Wed, 31 Jan 2018 00:40:04 -0800
Message-ID: <1517388005-14852-1-git-send-email-alex.hung@canonical.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38695 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeAaIkS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Jan 2018 03:40:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, jdelvare@suse.com, gregkh@linuxfoundation.org, davem@davemloft.net, mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, f.fainelli@gmail.com, dmitry.torokhov@gmail.com, kishon@ti.com, karniksayli1995@gmail.com, linux-acpi@vger.kernel.org, alex.hung@canonical.com, Mario.Limonciello@dell.com

OEM strings are defined by each OEM and they contain customized and
useful OEM information. Supporting it provides more flexible uses of
the dmi_matches function.

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/firmware/dmi_scan.c     | 8 ++++++++
 include/linux/mod_devicetable.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 7830419..e534d1b 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -797,11 +797,19 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
 			else if (dmi->matches[i].exact_match &&
 				 !strcmp(dmi_ident[s], dmi->matches[i].substr))
 				continue;
+		} else if (s == DMI_OEM_STRING) {
+			const struct dmi_device *valid;
+
+			valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
+						dmi->matches[i].substr, NULL);
+			if (valid)
+				continue;
 		}
 
 		/* No match */
 		return false;
 	}
+
 	return true;
 }
 
diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index abb6dc2..5739c4c 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -482,6 +482,7 @@ enum dmi_field {
 	DMI_CHASSIS_VERSION,
 	DMI_CHASSIS_SERIAL,
 	DMI_CHASSIS_ASSET_TAG,
+	DMI_OEM_STRING,
 	DMI_STRING_MAX,
 };
 
-- 
2.7.4

