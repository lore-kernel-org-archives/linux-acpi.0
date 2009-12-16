From: Len Brown <lenb@kernel.org>
Subject: [PATCH 100/103] ACPI: dock: dock_add - hoist up
 platform_device_register_simple()
Date: Wed, 16 Dec 2009 03:36:51 -0500
Message-ID: <9751cb721ef650729e981c7b39abb7676cd646e1.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760796AbZLPKF5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:57 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:53 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Move the call to platform_device_register_simple so that we do it
before allocating and initializing our struct dock_station.

Signed-off-by: Alex Chiang <achiang@hp.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 0a12218..3bd8982 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -948,11 +948,18 @@ static int dock_add(acpi_handle handle)
 	struct dock_station *dock_station;
 	struct platform_device *dock_device;
 
+	dock_device =
+		platform_device_register_simple("dock",
+			dock_station_count, NULL, 0);
+	if (IS_ERR(dock_device))
+		return PTR_ERR(dock_device);
+
 	/* allocate & initialize the dock_station private data */
 	dock_station = kzalloc(sizeof(*dock_station), GFP_KERNEL);
 	if (!dock_station)
 		return -ENOMEM;
 	dock_station->handle = handle;
+	dock_station->dock_device = dock_device;
 	dock_station->last_dock_time = jiffies - HZ;
 	INIT_LIST_HEAD(&dock_station->dependent_devices);
 	INIT_LIST_HEAD(&dock_station->hotplug_devices);
@@ -961,15 +968,6 @@ static int dock_add(acpi_handle handle)
 	mutex_init(&dock_station->hp_lock);
 	ATOMIC_INIT_NOTIFIER_HEAD(&dock_notifier_list);
 
-	/* initialize platform device stuff */
-	dock_station->dock_device =
-		platform_device_register_simple("dock",
-			dock_station_count, NULL, 0);
-	dock_device = dock_station->dock_device;
-	if (IS_ERR(dock_device)) {
-		ret = PTR_ERR(dock_device);
-		goto out;
-	}
 	platform_device_add_data(dock_device, &dock_station,
 		sizeof(struct dock_station *));
 
-- 
1.6.0.6

