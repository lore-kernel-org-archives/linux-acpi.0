From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/1] fixup! ACPI / utils: Add acpi_dev_present()
Date: Fri, 1 Jan 2016 22:52:15 +0100
Message-ID: <8e8f8983abe74c4cd43d95a444016fac0e5f822d.1451671935.git.lukas@wunner.de>
References: <cover.1451671935.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:41677 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcAAWCE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jan 2016 17:02:04 -0500
In-Reply-To: <cover.1451671935.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 60bda0d..1e6833a 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -88,7 +88,7 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent);
 
 extern struct list_head acpi_bus_id_list;
 
-struct acpi_device_bus_id{
+struct acpi_device_bus_id {
 	char bus_id[15];
 	unsigned int instance_no;
 	struct list_head node;
-- 
1.8.5.2 (Apple Git-48)

