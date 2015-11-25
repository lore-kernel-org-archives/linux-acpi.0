From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 1/2] ACPI / scan: Fix acpi_bus_id_list bookkeeping
Date: Wed, 25 Nov 2015 21:19:55 +0100
Message-ID: <994278b96189033970d0a2add95645110c716fbb.1448480385.git.lukas@wunner.de>
References: <cover.1448480385.git.lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:53689 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbKYUUW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2015 15:20:22 -0500
In-Reply-To: <cover.1448480385.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: devel@acpica.org, Hanjun Guo <guohanjun@huawei.com>, Robert Moore <robert.moore@intel.com>, Mark Brown <broonie@kernel.org>, Hui Wang <hui.wang@canonical.com>, Darren Hart <dvhart@infradead.org>

acpi_device_add() allocates and adds an element to acpi_bus_id_list
(or increments the instance count if the device's HID is already
present in the list), but the element is never deleted from the list
nor freed. Fix it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/acpi/scan.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 78d5f02..a0e942b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -471,10 +471,24 @@ static void acpi_device_release(struct device *dev)
 
 static void acpi_device_del(struct acpi_device *device)
 {
+	struct acpi_device_bus_id *acpi_device_bus_id;
+
 	mutex_lock(&acpi_device_lock);
 	if (device->parent)
 		list_del(&device->node);
 
+	list_for_each_entry(acpi_device_bus_id, &acpi_bus_id_list, node)
+		if (!strcmp(acpi_device_bus_id->bus_id,
+			    acpi_device_hid(device))) {
+			if (acpi_device_bus_id->instance_no > 0)
+				acpi_device_bus_id->instance_no--;
+			else {
+				list_del(&acpi_device_bus_id->node);
+				kfree(acpi_device_bus_id);
+			}
+			break;
+		}
+
 	list_del(&device->wakeup_list);
 	mutex_unlock(&acpi_device_lock);
 
-- 
1.8.5.2 (Apple Git-48)

