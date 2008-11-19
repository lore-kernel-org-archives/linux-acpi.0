From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: update AC status before exporting it
Date: Wed, 19 Nov 2008 09:24:12 +0800
Message-ID: <1227057852.15014.256.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58593 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbYKSBYt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Nov 2008 20:24:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

sometimes the AC status is not updated in time,
i.e. no AC event when AC is plugged/unplugged.
In this case, we need to update its status before exporting it.
http://bugzilla.kernel.org/show_bug.cgi?id=12035

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Alexey Starikovskiy <astarikovskiy@suse.de>
---
 drivers/acpi/ac.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -87,6 +87,7 @@ struct acpi_ac {
 	unsigned long long state;
 };
 
+static int acpi_ac_get_state(struct acpi_ac *ac);
 #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
@@ -103,15 +104,18 @@ static int get_ac_property(struct power_
 			   enum power_supply_property psp,
 			   union power_supply_propval *val)
 {
+	int result;
 	struct acpi_ac *ac = to_acpi_ac(psy);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_ONLINE:
+		result = acpi_ac_get_state(ac);
 		val->intval = ac->state;
 		break;
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return result;
 }
 
 static enum power_supply_property ac_props[] = {


