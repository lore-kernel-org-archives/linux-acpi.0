From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/27] ACPI / SBS: Add getting state operation in the
 acpi_sbs_battery_get_property()
Date: Tue, 02 Aug 2011 16:53:09 -0400
Message-ID: <1dd5c715e5b7524da8c1030f5cf1ea903e45c457.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:53434 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab1HBUyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 16:54:04 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00MOUJDY6W45@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 15:54:01 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <len.brown@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

https://bugzilla.kernel.org/show_bug.cgi?id=24492

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.7.6.396.ge0613

