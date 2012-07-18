From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: [RFC PATCH v4 9/13] memory-hotplug : move register_page_bootmem_info_node
 and put_page_bootmem for sparse-vmemmap
Date: Wed, 18 Jul 2012 19:14:03 +0900
Message-ID: <50068C6B.3040707@jp.fujitsu.com>
References: <50068974.1070409@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:56907 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128Ab2GRKOZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jul 2012 06:14:25 -0400
In-Reply-To: <50068974.1070409@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org
Cc: rientjes@google.com, liuj97@gmail.com, len.brown@intel.com, benh@kernel.crashing.org, paulus@samba.org, cl@linux.com, minchan.kim@gmail.com, akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com, wency@cn.fujitsu.com

For implementing register_page_bootmem_info_node of sparse-vmemmap, 
register_page_bootmem_info_node and put_page_bootmem are moved to
memory_hotplug.c

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org> 
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> 
CC: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 include/linux/memory_hotplug.h |    9 ---------
 mm/memory_hotplug.c            |    8 ++++++--
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: linux-3.5-rc6/include/linux/memory_hotplug.h
===================================================================
--- linux-3.5-rc6.orig/include/linux/memory_hotplug.h	2012-07-18 18:00:40.461982690 +0900
+++ linux-3.5-rc6/include/linux/memory_hotplug.h	2012-07-18 18:01:24.217435670 +0900
@@ -160,17 +160,8 @@ static inline void arch_refresh_nodedata
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
 
-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-static inline void put_page_bootmem(struct page *page)
-{
-}
-#else
 extern void register_page_bootmem_info_node(struct pglist_data *pgdat);
 extern void put_page_bootmem(struct page *page);
-#endif
 
 /*
  * Lock for memory hotplug guarantees 1) all callbacks for memory hotplug
Index: linux-3.5-rc6/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc6.orig/mm/memory_hotplug.c	2012-07-18 18:01:12.586581077 +0900
+++ linux-3.5-rc6/mm/memory_hotplug.c	2012-07-18 18:01:24.221435622 +0900
@@ -91,7 +91,6 @@ static void release_memory_resource(stru
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
 static void get_page_bootmem(unsigned long info,  struct page *page,
 			     unsigned long type)
 {
@@ -127,6 +126,7 @@ void __ref put_page_bootmem(struct page 
 
 }
 
+#ifndef CONFIG_SPARSEMEM_VMEMMAP
 static void register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long *usemap, mapsize, section_nr, i;
@@ -163,6 +163,11 @@ static void register_page_bootmem_info_s
 		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);
 
 }
+#else
+static inline void register_page_bootmem_info_section(unsigned long start_pfn)
+{
+}
+#endif
 
 void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
@@ -198,7 +203,6 @@ void register_page_bootmem_info_node(str
 		register_page_bootmem_info_section(pfn);
 
 }
-#endif /* !CONFIG_SPARSEMEM_VMEMMAP */
 
 static void grow_zone_span(struct zone *zone, unsigned long start_pfn,
 			   unsigned long end_pfn)

