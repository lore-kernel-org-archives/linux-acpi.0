From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 1/8] fix memory leak when memory device is unbound from the
 module acpi_memhotplug
Date: Tue, 26 Jun 2012 17:19:02 +0800
Message-ID: <4FE97E86.60603@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:21580 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752928Ab2FZJOi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2012 05:14:38 -0400
In-Reply-To: <4FE97DD5.6030205@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

We allocate memory to store acpi_memory_info, so we should free it before
freeing mem_device.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d985713..f6831d1 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -399,6 +399,18 @@ static void acpi_memory_device_notify(acpi_handle handle, u32 event, void *data)
 	return;
 }
 
+static void acpi_free_memory_device(struct acpi_memory_device *mem_device)
+{
+	struct acpi_memory_info *info, *n;
+
+	if (!mem_device)
+		return;
+
+	list_for_each_entry_safe(info, n, &mem_device->res_list, list)
+		kfree(info);
+	kfree(mem_device);
+}
+
 static int acpi_memory_device_add(struct acpi_device *device)
 {
 	int result;
@@ -451,14 +463,10 @@ static int acpi_memory_device_add(struct acpi_device *device)
 
 static int acpi_memory_device_remove(struct acpi_device *device, int type)
 {
-	struct acpi_memory_device *mem_device = NULL;
-
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	mem_device = acpi_driver_data(device);
-	kfree(mem_device);
+	acpi_free_memory_device(acpi_driver_data(device));
 
 	return 0;
 }
-- 
1.7.1

