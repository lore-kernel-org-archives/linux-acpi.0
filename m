From: Len Brown <len.brown@intel.com>
Subject: [PATCH 16/77] ACPI: bay: send envp with uevent
Date: Sun, 22 Jul 2007 05:14:01 -0400
Message-ID: <11850957181201-git-send-email-len.brown@intel.com>
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
 <11850957131802-git-send-email-len.brown@intel.com>
 <1185095714699-git-send-email-len.brown@intel.com>
 <1185095715506-git-send-email-len.brown@intel.com>
 <11850957162801-git-send-email-len.brown@intel.com>
 <11850957173842-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762570AbXGVJPU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:20 -0400
In-Reply-To: <11850957173842-git-send-email-len.brown@intel.com>
Message-Id: <3f8698d4d3f72252980575fb8d7b4cafeb5dd0a2.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Stephan Berberig <s.berberig@arcor.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Make the bay driver send env information on bay events.

Upon any bay event, we will send the string "BAY_EVENT=%d" along with the
KOBJ_CHANGE, and report the event number.  What the event number means will
be platform specific.  Event 3 is always an eject request, but an insert
may be either event 1, or it may be event 0.  Event 1 may also be a
remove request.  It would be best if you check the number of your event
with udevmonitor before writing any udev scripts for inserting and
removing drive bays.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Stephan Berberig <s.berberig@arcor.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 00d3f3f..56a5b3f 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -333,18 +333,12 @@ static void bay_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct bay *bay_dev = (struct bay *)data;
 	struct device *dev = &bay_dev->pdev->dev;
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
 
 	bay_dprintk(handle, "Bay event");
-
-	switch(event) {
-	case ACPI_NOTIFY_BUS_CHECK:
-	case ACPI_NOTIFY_DEVICE_CHECK:
-	case ACPI_NOTIFY_EJECT_REQUEST:
-		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		break;
-	default:
-		printk(KERN_ERR PREFIX "Bay: unknown event %d\n", event);
-	}
+	sprintf(event_string, "BAY_EVENT=%d\n", event);
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 
 static acpi_status
-- 
1.5.3.rc2.22.g69a9b
