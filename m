From: Len Brown <len.brown@intel.com>
Subject: [PATCH 10/77] ACPI: dock: unsuppress uevents
Date: Sun, 22 Jul 2007 05:13:55 -0400
Message-ID: <11850957123807-git-send-email-len.brown@intel.com>
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
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33449 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202AbXGVJPO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:14 -0400
In-Reply-To: <11850957111797-git-send-email-len.brown@intel.com>
Message-Id: <9ef2a9a9f08722998540ed2ff38bccd0c54344c8.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Len Brown <len.brown@intel.com>

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Platform devices may not send uevents by default - override the setting
so that we can send uevents on dock/undock.

Signed-off-by:  Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 98ec717..4efc12c 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -751,6 +751,9 @@ static int dock_add(acpi_handle handle)
 		return PTR_ERR(dock_device);
 	}
 
+	/* we want the dock device to send uevents */
+	dock_device->dev.uevent_suppress = 0;
+
 	ret = device_create_file(&dock_device->dev, &dev_attr_docked);
 	if (ret) {
 		printk("Error %d adding sysfs file\n", ret);
-- 
1.5.3.rc2.22.g69a9b
