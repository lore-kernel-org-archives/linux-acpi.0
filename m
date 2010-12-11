From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/15] ACPI ac: update AC status upon sysfs query
Date: Sat, 11 Dec 2010 02:06:28 -0500
Message-ID: <3151dbb04ad5a5bd6358371c0bfb457216d00205.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:56222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab0LKHGy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:06:54 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900FU853GWMR1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:06:54 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

http://marc.info/?l=linux-acpi&m=128855015826728&w=2
https://bugzilla.kernel.org/show_bug.cgi?id=21722

Tested_by: Seblu <seblu@seblu.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c |   46 +++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index ba9afea..25d3aae 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -100,24 +100,7 @@ static const struct file_operations acpi_ac_fops = {
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
@@ -140,6 +123,35 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
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
-- 
1.7.3.3.480.g2f76a

