From: Len Brown <lenb@kernel.org>
Subject: [PATCH 82/85] ACPI: remove unused acpi_is_child_device()
Date: Sat, 11 Oct 2008 02:36:42 -0400
Message-ID: <a4573ad01f58e3b002c3e93e0a6724d0cf00ff29.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:52519 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbYJKGh1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:27 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
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

