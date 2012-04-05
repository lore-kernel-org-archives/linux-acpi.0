From: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Subject: [PATCH 2/2] mm: consistently register / release memory resource
Date: Thu,  5 Apr 2012 20:07:02 +0200
Message-ID: <1333649222-24285-3-git-send-email-vasilis.liaskovitis@profitbricks.com>
References: <1333649222-24285-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48627 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322Ab2DESHy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2012 14:07:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so1590279bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Apr 2012 11:07:53 -0700 (PDT)
In-Reply-To: <1333649222-24285-1-git-send-email-vasilis.liaskovitis@profitbricks.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org
Cc: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>

add_memory() registers hotplugged memory resources by calling
register_memory_resource() for the whole memory range requested.
However, __remove_pages() releases memory resources by calling
release_memory_region on a per section basis. This discrepancy
can break memory hotplug operations when using memory devices
that span multiple sections. Specifically hot-readd
(hot-add/hot-remove/hot-add sequence) will not work. Fix by releasing
the memory resource as a whole (another option would be to register
and release always on a per section basis).

Signed-off-by: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
---
 mm/memory_hotplug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6629faf..8ab6b63 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -362,12 +362,12 @@ int __remove_pages(struct zone *zone, unsigned long phys_start_pfn,
 	sections_to_remove = nr_pages / PAGES_PER_SECTION;
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
-		release_mem_region(pfn << PAGE_SHIFT,
-				   PAGES_PER_SECTION << PAGE_SHIFT);
 		ret = __remove_section(zone, __pfn_to_section(pfn));
 		if (ret)
 			break;
 	}
+	release_mem_region(phys_start_pfn << PAGE_SHIFT,
+			nr_pages << PAGE_SHIFT);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__remove_pages);
-- 
1.7.9

