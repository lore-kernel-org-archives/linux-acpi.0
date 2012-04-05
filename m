From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: [PATCH 1/2] acpi: remove section mappings on memory hot-remove
Date: Thu,  5 Apr 2012 20:07:01 +0200
Message-ID: <1333649222-24285-2-git-send-email-vasilis.liaskovitis@profitbricks.com>
References: <1333649222-24285-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48627 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab2DESHw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2012 14:07:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so1590279bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Apr 2012 11:07:52 -0700 (PDT)
In-Reply-To: <1333649222-24285-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>


Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
---
 drivers/acpi/acpi_memhotplug.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index d985713..75d33cd 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/mm.h>
 #include <linux/memory_hotplug.h>
 #include <linux/slab.h>
 #include <acpi/acpi_drivers.h>
@@ -310,7 +311,8 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 {
 	int result;
 	struct acpi_memory_info *info, *n;
-
+	int start_pfn, end_pfn;
+	struct zone *zone;
 
 	/*
 	 * Ask the VM to offline this memory range.
@@ -321,6 +323,19 @@ static int acpi_memory_disable_device(struct acpi_memory_device *mem_device)
 			result = remove_memory(info->start_addr, info->length);
 			if (result)
 				return result;
+			/*
+			 * Remove section mappings and sysfs entries for the
+			 * section of the memory we are removing.
+			 */
+
+			start_pfn = PFN_DOWN(info->start_addr);
+			end_pfn = start_pfn + PFN_DOWN(info->length);
+			zone = page_zone(pfn_to_page(start_pfn));
+			result = __remove_pages(zone, start_pfn,
+						end_pfn - start_pfn);
+			if (result)
+				return result;
+
 		}
 		kfree(info);
 	}
-- 
1.7.9

