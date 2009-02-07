From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/30] ACPI: proc_dir_entry 'video/VGA' already registered
Date: Sat, 07 Feb 2009 01:41:26 -0500
Message-ID: <f3b39f1393d5cebe56f43a584ef47efbebd2702c.1233988825.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:44024 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZBGGmD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:03 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KEO008CCNXWQFA1@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:41:57 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

eliminate the duplicate the name of "VGA"

http://bugzilla.kernel.org/show_bug.cgi?id=12514

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index f261737..1981eaf 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2006,6 +2006,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
 			device->pnp.bus_id[3] = '0' + instance;
 		instance ++;
 	}
+	/* a hack to fix the duplicate name "VGA" problem on Pa 3553 */
+	if (!strcmp(device->pnp.bus_id, "VGA")) {
+		if (instance)
+			device->pnp.bus_id[3] = '0' + instance;
+		instance++;
+	}
 
 	video->device = device;
 	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
-- 
1.5.6.6

