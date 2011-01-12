From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/48] ACPI / PM: Make suspend_nvs_save() use
 acpi_os_map_memory()
Date: Wed, 12 Jan 2011 05:19:11 -0500
Message-ID: <ca9b600be38c73b7d25acfb8b7e4e9a9e941d881.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:30 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:24 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

It turns out that the NVS memory region that suspend_nvs_save()
attempts to map has been already mapped by acpi_os_map_memory(), so
suspend_nvs_save() should better use acpi_os_map_memory() for mapping
memory to avoid conflicts.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/nvs.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 7d64809..54b6ab8 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <acpi/acpiosxf.h>
 
 /*
  * Platforms, like ACPI, may want us to save some memory used by them during
@@ -79,7 +80,7 @@ void suspend_nvs_free(void)
 			free_page((unsigned long)entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
-				iounmap(entry->kaddr);
+				acpi_os_unmap_memory(entry->kaddr, entry->size);
 				entry->kaddr = NULL;
 			}
 		}
@@ -113,7 +114,8 @@ int suspend_nvs_save(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			entry->kaddr = ioremap(entry->phys_start, entry->size);
+			entry->kaddr = acpi_os_map_memory(entry->phys_start,
+							  entry->size);
 			if (!entry->kaddr) {
 				suspend_nvs_free();
 				return -ENOMEM;
-- 
1.7.4.rc1.7.g2cf08

