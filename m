From: Wen Congyang <wency@cn.fujitsu.com>
Subject: [PATCH 4/8] donot allow to eject the memory device if it is being
 used
Date: Tue, 26 Jun 2012 17:20:44 +0800
Message-ID: <4FE97EEC.6060008@cn.fujitsu.com>
References: <4FE97DD5.6030205@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:50505 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753473Ab2FZJQT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2012 05:16:19 -0400
In-Reply-To: <4FE97DD5.6030205@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>

We eject the memory device even if it is in use. It is very dangerous,
and it will cause the kernel panicked.

Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/acpi/acpi_memhotplug.c |   34 +++++++++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index a325bb9..2e5d5ab 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -78,6 +78,7 @@ struct acpi_memory_info {
 	unsigned short caching;	/* memory cache attribute */
 	unsigned short write_protect;	/* memory read/write attribute */
 	unsigned int enabled:1;
+	unsigned int failed:1;
 };
 
 struct acpi_memory_device {
@@ -251,9 +252,19 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
 		result = add_memory(node, info->start_addr, info->length);
-		if (result)
+
+		/*
+		 * If the memory block has been used by the kernel, add_memory()
+		 * returns -EEXIST. If add_memory() returns the other error, it
+		 * means that this memory block is not used by the kernel.
+		 */
+		if (result && result != -EEXIST) {
+			info->failed = 1;
 			continue;
-		info->enabled = 1;
+		}
+
+		if (!result)
+			info->enabled = 1;
 		num_enabled++;
 	}
 	if (!num_enabled) {
@@ -317,11 +328,20 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 	 * Note: Assume that this function returns zero on success
 	 */
 	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
-		if (info->enabled) {
-			result = remove_memory(info->start_addr, info->length);
-			if (result)
-				return result;
-		}
+		if (info->failed)
+			/* The kernel does not use this memory block */
+			continue;
+
+		if (!info->enabled)
+			/*
+			 * The kernel uses this memory block, but it may be not
+			 * managed by us.
+			 */
+			return -EBUSY;
+
+		result = remove_memory(info->start_addr, info->length);
+		if (result)
+			return result;
 		list_del(&info->list);
 		kfree(info);
 	}
-- 
1.7.1

