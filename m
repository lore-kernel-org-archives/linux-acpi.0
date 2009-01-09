From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/94] Hibernate: Do not oops on resume if image data are
 incorrect
Date: Fri, 09 Jan 2009 04:26:11 -0500
Message-ID: <69643279a88dea000ac2f858091d0e365f778245.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40915 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669AbZAIJ1u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:50 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LRA6ADLN97@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:50 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

During resume from hibernation using the userland interface image
data are being passed from the used space process to the kernel.
These data need not be valid, but currently the kernel sometimes
oopses if it gets invalid image data, which is wrong.  Make the
kernel return error codes to the user space in such cases.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/snapshot.c |   43 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 5d2ab83..955c8cc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -519,6 +519,14 @@ static int memory_bm_test_bit(struct memory_bitmap *bm, unsigned long pfn)
 	return test_bit(bit, addr);
 }
 
+static bool memory_bm_pfn_present(struct memory_bitmap *bm, unsigned long pfn)
+{
+	void *addr;
+	unsigned int bit;
+
+	return !memory_bm_find_bit(bm, pfn, &addr, &bit);
+}
+
 /**
  *	memory_bm_next_pfn - find the pfn that corresponds to the next set bit
  *	in the bitmap @bm.  If the pfn cannot be found, BM_END_OF_MAP is
@@ -1459,9 +1467,7 @@ load_header(struct swsusp_info *info)
  *	unpack_orig_pfns - for each element of @buf[] (1 page at a time) set
  *	the corresponding bit in the memory bitmap @bm
  */
-
-static inline void
-unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
+static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
@@ -1469,8 +1475,13 @@ unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		memory_bm_set_bit(bm, buf[j]);
+		if (memory_bm_pfn_present(bm, buf[j]))
+			memory_bm_set_bit(bm, buf[j]);
+		else
+			return -EFAULT;
 	}
+
+	return 0;
 }
 
 /* List of "safe" pages that may be used to store data loaded from the suspend
@@ -1608,7 +1619,7 @@ get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
 	pbe = chain_alloc(ca, sizeof(struct highmem_pbe));
 	if (!pbe) {
 		swsusp_free();
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_page = page;
 	if (safe_highmem_pages > 0) {
@@ -1677,7 +1688,7 @@ prepare_highmem_image(struct memory_bitmap *bm, unsigned int *nr_highmem_p)
 static inline void *
 get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline void copy_last_highmem_page(void) {}
@@ -1788,8 +1799,13 @@ prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm)
 static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 {
 	struct pbe *pbe;
-	struct page *page = pfn_to_page(memory_bm_next_pfn(bm));
+	struct page *page;
+	unsigned long pfn = memory_bm_next_pfn(bm);
 
+	if (pfn == BM_END_OF_MAP)
+		return ERR_PTR(-EFAULT);
+
+	page = pfn_to_page(pfn);
 	if (PageHighMem(page))
 		return get_highmem_page_buffer(page, ca);
 
@@ -1805,7 +1821,7 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 	pbe = chain_alloc(ca, sizeof(struct pbe));
 	if (!pbe) {
 		swsusp_free();
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_address = page_address(page);
 	pbe->address = safe_pages_list;
@@ -1868,7 +1884,10 @@ int snapshot_write_next(struct snapshot_handle *handle, size_t count)
 				return error;
 
 		} else if (handle->prev <= nr_meta_pages) {
-			unpack_orig_pfns(buffer, &copy_bm);
+			error = unpack_orig_pfns(buffer, &copy_bm);
+			if (error)
+				return error;
+
 			if (handle->prev == nr_meta_pages) {
 				error = prepare_image(&orig_bm, &copy_bm);
 				if (error)
@@ -1879,12 +1898,14 @@ int snapshot_write_next(struct snapshot_handle *handle, size_t count)
 				restore_pblist = NULL;
 				handle->buffer = get_buffer(&orig_bm, &ca);
 				handle->sync_read = 0;
-				if (!handle->buffer)
-					return -ENOMEM;
+				if (IS_ERR(handle->buffer))
+					return PTR_ERR(handle->buffer);
 			}
 		} else {
 			copy_last_highmem_page();
 			handle->buffer = get_buffer(&orig_bm, &ca);
+			if (IS_ERR(handle->buffer))
+				return PTR_ERR(handle->buffer);
 			if (handle->buffer != buffer)
 				handle->sync_read = 0;
 		}
-- 
1.5.6.6

