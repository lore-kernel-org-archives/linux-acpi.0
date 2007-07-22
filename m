From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/77] ACPI: dock: send envp with uevent
Date: Sun, 22 Jul 2007 05:13:56 -0400
Message-ID: <11850957131802-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
 <11850957062754-git-send-email-len.brown@intel.com>
 <11850957073494-git-send-email-len.brown@intel.com>
 <1185095708928-git-send-email-len.brown@intel.com>
 <11850957093360-git-send-email-len.brown@intel.com>
 <11850957102641-git-send-email-len.brown@intel.com>
 <11850957111797-git-send-email-len.brown@intel.com>
 <11850957123807-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761457AbXGVJPR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:17 -0400
In-Reply-To: <11850957123807-git-send-email-len.brown@intel.com>
Message-Id: <79a8f70b4b9127eacfc91dd1436c4a7be05e62ab.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Send an env along with our KOBJ_CHANGE uevent so that user space has
the option of checking for that to see if a dock or undock has occurred.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 4efc12c..dc3df93 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -336,11 +336,19 @@ static void hotplug_dock_devices(struct dock_station *ds, u32 event)
 static void dock_event(struct dock_station *ds, u32 event, int num)
 {
 	struct device *dev = &dock_device->dev;
+	char event_string[7];
+	char *envp[] = { event_string, NULL };
+
+	if (num == UNDOCK_EVENT)
+		sprintf(event_string, "UNDOCK");
+	else
+		sprintf(event_string, "DOCK");
+
 	/*
 	 * Indicate that the status of the dock station has
 	 * changed.
 	 */
-	kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 
 /**
-- 
1.5.3.rc2.22.g69a9b
