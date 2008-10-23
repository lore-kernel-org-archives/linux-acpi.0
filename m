From: Len Brown <lenb@kernel.org>
Subject: [PATCH 075/122] ACPI: remove unused acpi_is_child_device()
Date: Thu, 23 Oct 2008 02:38:49 -0400
Message-ID: <ea5c8af9b1241a10dc4ba6cd2d2362c179884b74.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40898 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250AbYJWGkS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:18 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K960009VIIXXYQ2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:09 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 89c112e..91fed42 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1161,20 +1161,6 @@ static int acpi_bus_remove(struct acpi_device *dev, int rmdevice)
 }
 
 static int
-acpi_is_child_device(struct acpi_device *device,
-			int (*matcher)(struct acpi_device *))
-{
-	int result = -ENODEV;
-
-	do {
-		if (ACPI_SUCCESS(matcher(device)))
-			return AE_OK;
-	} while ((device = device->parent));
-
-	return result;
-}
-
-static int
 acpi_add_single_object(struct acpi_device **child,
 		       struct acpi_device *parent, acpi_handle handle, int type,
 			struct acpi_bus_ops *ops)
-- 
1.5.5.1

