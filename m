From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/60] Add lock-less version of bitmap_set/clear
Date: Mon, 25 Oct 2010 02:20:53 -0400
Message-ID: <2bc7089b5a8dde8c5098f778458159e614ee846f.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:63717 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0JYILE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 04:11:04 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AR06QCM6U2@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 03:11:02 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

cmpxchg is used to change the bitmap instead of the ordinary unsigned
long assigning. Several users can set/clear the same bitmap
simultaneously without lock. If there is conflict between two user,
(set/clear same bit), one will return remain bits immediately.

This can be used to implement the lock-less resource allocator.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/bitmap.h |    4 ++
 lib/bitmap.c           |  101 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index daf8c48..7c12d8a 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -44,6 +44,8 @@
  * bitmap_weight(src, nbits)			Hamming Weight: number set bits
  * bitmap_set(dst, pos, nbits)			Set specified bit area
  * bitmap_clear(dst, pos, nbits)		Clear specified bit area
+ * bitmap_set_ll(dst, pos, nbits)		Set specified bit area, lock-less version
+ * bitmap_clear_ll(dst, pos, nbits)		Clear specified bit area, lock-less version
  * bitmap_find_next_zero_area(buf, len, pos, n, mask)	Find bit free area
  * bitmap_shift_right(dst, src, n, nbits)	*dst = *src >> n
  * bitmap_shift_left(dst, src, n, nbits)	*dst = *src << n
@@ -113,6 +115,8 @@ extern int __bitmap_weight(const unsigned long *bitmap, int bits);
 
 extern void bitmap_set(unsigned long *map, int i, int len);
 extern void bitmap_clear(unsigned long *map, int start, int nr);
+extern int bitmap_set_ll(unsigned long *map, int i, int len);
+extern int bitmap_clear_ll(unsigned long *map, int start, int nr);
 extern unsigned long bitmap_find_next_zero_area(unsigned long *map,
 					 unsigned long size,
 					 unsigned long start,
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ffb78c9..90c60b3 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -315,6 +315,107 @@ void bitmap_clear(unsigned long *map, int start, int nr)
 }
 EXPORT_SYMBOL(bitmap_clear);
 
+static inline int set_bits_ll(unsigned long *addr, unsigned long mask_to_set)
+{
+	unsigned long val, nval;
+
+	nval = *addr;
+	do {
+		val = nval;
+		if (val & mask_to_set)
+			return -EBUSY;
+	} while ((nval = cmpxchg(addr, val, val | mask_to_set)) != val);
+
+	return 0;
+}
+
+static inline int clear_bits_ll(unsigned long *addr,
+				unsigned long mask_to_clear)
+{
+	unsigned long val, nval;
+
+	nval = *addr;
+	do {
+		val = nval;
+		if ((val & mask_to_clear) != mask_to_clear)
+			return -EBUSY;
+	} while ((nval = cmpxchg(addr, val, val & ~mask_to_clear)) != val);
+
+	return 0;
+}
+
+/**
+ * bitmap_set_ll - set the specified number of bits at the specified position
+ * @map: pointer to a bitmap
+ * @start: a bit position in @map
+ * @nr: number of bits to set
+ *
+ * Set @nr bits start from @start in @map lock-lessly. Several users
+ * can set/clear the same bitmap simultaneously without lock. If two
+ * users set the same bit, one user will return remain bits, otherwise
+ * return 0.
+ */
+int bitmap_set_ll(unsigned long *map, int start, int nr)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const int size = start + nr;
+	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_set = BITMAP_FIRST_WORD_MASK(start);
+
+	while (nr - bits_to_set >= 0) {
+		if (set_bits_ll(p, mask_to_set))
+			return nr;
+		nr -= bits_to_set;
+		bits_to_set = BITS_PER_LONG;
+		mask_to_set = ~0UL;
+		p++;
+	}
+	if (nr) {
+		mask_to_set &= BITMAP_LAST_WORD_MASK(size);
+		if (set_bits_ll(p, mask_to_set))
+			return nr;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_set_ll);
+
+/**
+ * bitmap_clear_ll - clear the specified number of bits at the specified position
+ * @map: pointer to a bitmap
+ * @start: a bit position in @map
+ * @nr: number of bits to set
+ *
+ * Clear @nr bits start from @start in @map lock-lessly. Several users
+ * can set/clear the same bitmap simultaneously without lock. If two
+ * users clear the same bit, one user will return remain bits,
+ * otherwise return 0.
+ */
+int bitmap_clear_ll(unsigned long *map, int start, int nr)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const int size = start + nr;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (nr - bits_to_clear >= 0) {
+		if (clear_bits_ll(p, mask_to_clear))
+			return nr;
+		nr -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (nr) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		if (clear_bits_ll(p, mask_to_clear))
+			return nr;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(bitmap_clear_ll);
+
 /*
  * bitmap_find_next_zero_area - find a contiguous aligned zero area
  * @map: The address to base the search on
-- 
1.7.3.2.90.gd4c43

