From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 4/4] [PATCH] remove goto statement
Date: Mon, 18 Feb 2008 23:42:01 -0300
Message-ID: <1203388921-13688-1-git-send-email-gcosta@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:46591 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362AbYBSCtJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 21:49:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, paul.s.diefenbaugh@intel.com, linux@brodo.de, anil.s.keshavamurthy@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, lizf@cn.fujitsu.com

This patch removes goto statements in favour of plain returns
in places that had nothing left behind that would justify
such construction
---
 drivers/acpi/processor_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 06a230a..70f62b6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -651,7 +651,7 @@ static int __cpuinit acpi_processor_star
 
 	result = acpi_processor_add_fs(device);
 	if (result)
-		goto end;
+		return result;
 
 	status = acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOTIFY,
 					     acpi_processor_notify, pr);
@@ -675,7 +675,7 @@ #endif
 			"%s is registered as cooling_device%d\n",
 			device->dev.bus_id, cdev->id);
 	else
-		goto end;
+		return result;
 
 	result = sysfs_create_link(&device->dev.kobj, &cdev->device.kobj,
 					"thermal_cooling");
-- 
1.4.2

