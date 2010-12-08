From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/4] ACPI ac: update AC status first when querying from
 sysfs
Date: Wed, 08 Dec 2010 10:40:45 +0800
Message-ID: <1291776045.19296.704.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24868 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848Ab0LHCkp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Dec 2010 21:40:45 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, seblu@seblu.net, "Zhang, Rui" <rui.zhang@intel.com>

Update AC status first when querying from sysfs.
http://marc.info/?l=linux-acpi&m=128855015826728&w=2
https://bugzilla.kernel.org/show_bug.cgi?id=21722

Tested_by: Seblu <seblu@seblu.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/ac.c |   46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -100,24 +100,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 #endif
-static int get_ac_property(struct power_supply *psy,
-			   enum power_supply_property psp,
-			   union power_supply_propval *val)
-{
-	struct acpi_ac *ac = to_acpi_ac(psy);
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = ac->state;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
 
-static enum power_supply_property ac_props[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-};
 /* --------------------------------------------------------------------------
                                AC Adapter Management
    -------------------------------------------------------------------------- */
@@ -140,6 +123,35 @@ static int acpi_ac_get_state(struct acpi
 	return 0;
 }
 
+/* --------------------------------------------------------------------------
+                            sysfs I/F
+   -------------------------------------------------------------------------- */
+static int get_ac_property(struct power_supply *psy,
+			   enum power_supply_property psp,
+			   union power_supply_propval *val)
+{
+	struct acpi_ac *ac = to_acpi_ac(psy);
+
+	if (!ac)
+		return -ENODEV;
+
+	if (acpi_ac_get_state(ac))
+		return -ENODEV;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ac->state;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
+
 #ifdef CONFIG_ACPI_PROCFS_POWER
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)


