From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 1/2] ACPI / SBS:  Add getting state operation in the acpi_sbs_battery_get_property()
Date: Fri,  1 Jul 2011 16:03:15 +0800
Message-ID: <1309507395-19211-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46717 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab1GAIDR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 1 Jul 2011 04:03:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, tianyu.lan@intel.com, rui.zhang@intel.com

https://bugzilla.kernel.org/show_bug.cgi?id=24492

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/sbs.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 51ae379..01dad1b 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -130,6 +130,9 @@ struct acpi_sbs {
 
 #define to_acpi_sbs(x) container_of(x, struct acpi_sbs, charger)
 
+static int acpi_sbs_remove(struct acpi_device *device, int type);
+static int acpi_battery_get_state(struct acpi_battery *battery);
+
 static inline int battery_scale(int log)
 {
 	int scale = 1;
@@ -195,6 +198,8 @@ static int acpi_sbs_battery_get_property(struct power_supply *psy,
 
 	if ((!battery->present) && psp != POWER_SUPPLY_PROP_PRESENT)
 		return -ENODEV;
+
+	acpi_battery_get_state(battery);
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (battery->rate_now < 0)
@@ -903,8 +908,6 @@ static void acpi_sbs_callback(void *context)
 	}
 }
 
-static int acpi_sbs_remove(struct acpi_device *device, int type);
-
 static int acpi_sbs_add(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs;
-- 
1.7.6.rc2.8.g28eb

