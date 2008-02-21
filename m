From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/26] Hibernation: Handle DEBUG_PAGEALLOC on x86
Date: Thu, 21 Feb 2008 04:25:36 -0500
Message-ID: <8a235efad548abd2ab5ebea45a9ffa750c814375.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36615 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757107AbYBUJ3U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:20 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make hibernation work with CONFIG_DEBUG_PAGEALLOC set on x86, by
checking if the pages to be copied are marked as present in the
kernel mapping and temporarily marking them as present if that's not
the case.  No functional modifications are introduced if
CONFIG_DEBUG_PAGEALLOC is unset.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/mm/pageattr.c  |   19 ++++++++++++++++++-
 include/linux/mm.h      |    6 ++++++
 kernel/power/snapshot.c |   42 +++++++++++++++++++++++++++++-------------
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index e2a74ea..464d8fc 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -899,7 +899,24 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 	 */
 	cpa_fill_pool();
 }
-#endif
+
+#ifdef CONFIG_HIBERNATION
+
+bool kernel_page_present(struct page *page)
+{
+	unsigned int level;
+	pte_t *pte;
+
+	if (PageHighMem(page))
+		return false;
+
+	pte = lookup_address((unsigned long)page_address(page), &level);
+	return (pte_val(*pte) & _PAGE_PRESENT);
+}
+
+#endif /* CONFIG_HIBERNATION */
+
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /*
  * The testcases use internal knowledge of the implementation that shouldn't
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 26c7124..3b3e134 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1171,12 +1171,18 @@ static inline void enable_debug_pagealloc(void)
 {
 	debug_pagealloc_enabled = 1;
 }
+#ifdef CONFIG_HIBERNATION
+extern bool kernel_page_present(struct page *page);
+#endif /* CONFIG_HIBERNATION */
 #else
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
 static inline void enable_debug_pagealloc(void)
 {
 }
+#ifdef CONFIG_HIBERNATION
+static inline bool kernel_page_present(struct page *page) { return true; }
+#endif /* CONFIG_HIBERNATION */
 #endif
 
 extern struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 95250d7..72a020c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -875,8 +875,8 @@ static inline void *saveable_highmem_page(unsigned long pfn) { return NULL; }
 #endif /* CONFIG_HIGHMEM */
 
 /**
- *	saveable - Determine whether a non-highmem page should be included in
- *	the suspend image.
+ *	saveable_page - Determine whether a non-highmem page should be included
+ *	in the suspend image.
  *
  *	We should save the page if it isn't Nosave, and is not in the range
  *	of pages statically defined as 'unsaveable', and it isn't a part of
@@ -897,7 +897,8 @@ static struct page *saveable_page(unsigned long pfn)
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
 
-	if (PageReserved(page) && pfn_is_nosave(pfn))
+	if (PageReserved(page)
+	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
 		return NULL;
 
 	return page;
@@ -938,6 +939,25 @@ static inline void do_copy_page(long *dst, long *src)
 		*dst++ = *src++;
 }
 
+
+/**
+ *	safe_copy_page - check if the page we are going to copy is marked as
+ *		present in the kernel page tables (this always is the case if
+ *		CONFIG_DEBUG_PAGEALLOC is not set and in that case
+ *		kernel_page_present() always returns 'true').
+ */
+static void safe_copy_page(void *dst, struct page *s_page)
+{
+	if (kernel_page_present(s_page)) {
+		do_copy_page(dst, page_address(s_page));
+	} else {
+		kernel_map_pages(s_page, 1, 1);
+		do_copy_page(dst, page_address(s_page));
+		kernel_map_pages(s_page, 1, 0);
+	}
+}
+
+
 #ifdef CONFIG_HIGHMEM
 static inline struct page *
 page_is_saveable(struct zone *zone, unsigned long pfn)
@@ -946,8 +966,7 @@ page_is_saveable(struct zone *zone, unsigned long pfn)
 			saveable_highmem_page(pfn) : saveable_page(pfn);
 }
 
-static inline void
-copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
 	struct page *s_page, *d_page;
 	void *src, *dst;
@@ -961,29 +980,26 @@ copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 		kunmap_atomic(src, KM_USER0);
 		kunmap_atomic(dst, KM_USER1);
 	} else {
-		src = page_address(s_page);
 		if (PageHighMem(d_page)) {
 			/* Page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
-			do_copy_page(buffer, src);
+			safe_copy_page(buffer, s_page);
 			dst = kmap_atomic(pfn_to_page(dst_pfn), KM_USER0);
 			memcpy(dst, buffer, PAGE_SIZE);
 			kunmap_atomic(dst, KM_USER0);
 		} else {
-			dst = page_address(d_page);
-			do_copy_page(dst, src);
+			safe_copy_page(page_address(d_page), s_page);
 		}
 	}
 }
 #else
 #define page_is_saveable(zone, pfn)	saveable_page(pfn)
 
-static inline void
-copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static inline void copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 {
-	do_copy_page(page_address(pfn_to_page(dst_pfn)),
-			page_address(pfn_to_page(src_pfn)));
+	safe_copy_page(page_address(pfn_to_page(dst_pfn)),
+				pfn_to_page(src_pfn));
 }
 #endif /* CONFIG_HIGHMEM */
 
-- 
1.5.4.2

