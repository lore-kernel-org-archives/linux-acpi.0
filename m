From: Pingfan Liu <kernelfans@gmail.com>
Subject: [RFC PATCH 4/4] x86/mm: remove bottom-up allocation style for x86_64
Date: Mon,  7 Jan 2019 16:24:45 +0800
Message-ID: <1546849485-27933-5-git-send-email-kernelfans@gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

There are two acheivements by this patch.
-1st. keep the subtree of pgtable away from movable node.
Background about the defect of the current bottom-up allocation style, take
the following scenario:
  |  unmovable node |     movable node                           |
     | kaslr-kernel |subtree of pgtable for phy<->virt |

Although kaslr-kernel can avoid to stain the movable node. [1] But the
pgtable can still stain the movable node. That is a probability problem,
with low probability, but still exist. This patch tries to eliminate the
probability. With the previous patch, at the point of init_mem_mapping(),
memblock allocator can work with the knowledge of acpi memory hotmovable
info, and avoid to stain the movable node. As a result,
memory_map_bottom_up() is not needed any more.

-2nd. simplify the logic of memory_map_top_down()
Thanks to the help of early_make_pgtable(), x86_64 can directly set up the
subtree of pgtable at any place, hence the careful iteration in
memory_map_top_down() can be discard.

[1]: https://lore.kernel.org/patchwork/patch/1029376/
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org

---
 arch/x86/mm/init.c        | 140 +++-------------------------------------------
 arch/x86/mm/init_32.c     | 123 ++++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/mm_internal.h |   7 +++
 3 files changed, 139 insertions(+), 131 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 84baa66..4e0286b 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -72,8 +72,6 @@ static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
 
-static unsigned long min_pfn_mapped;
-
 static bool __initdata can_use_brk_pgt = true;
 
 static unsigned long min_pfn_allowed;
@@ -504,7 +502,7 @@ unsigned long __ref init_memory_mapping(unsigned long start,
  * That range would have hole in the middle or ends, and only ram parts
  * will be mapped in init_range_memory_mapping().
  */
-static unsigned long __init init_range_memory_mapping(
+unsigned long __init init_range_memory_mapping(
 					   unsigned long r_start,
 					   unsigned long r_end)
 {
@@ -532,127 +530,6 @@ static unsigned long __init init_range_memory_mapping(
 	return mapped_ram_size;
 }
 
-static unsigned long __init get_new_step_size(unsigned long step_size)
-{
-	/*
-	 * Initial mapped size is PMD_SIZE (2M).
-	 * We can not set step_size to be PUD_SIZE (1G) yet.
-	 * In worse case, when we cross the 1G boundary, and
-	 * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
-	 * to map 1G range with PTE. Hence we use one less than the
-	 * difference of page table level shifts.
-	 *
-	 * Don't need to worry about overflow in the top-down case, on 32bit,
-	 * when step_size is 0, round_down() returns 0 for start, and that
-	 * turns it into 0x100000000ULL.
-	 * In the bottom-up case, round_up(x, 0) returns 0 though too, which
-	 * needs to be taken into consideration by the code below.
-	 */
-	return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
-}
-
-/**
- * memory_map_top_down - Map [map_start, map_end) top down
- * @map_start: start address of the target memory range
- * @map_end: end address of the target memory range
- *
- * This function will setup direct mapping for memory range
- * [map_start, map_end) in top-down. That said, the page tables
- * will be allocated at the end of the memory, and we map the
- * memory in top-down.
- */
-static void __init memory_map_top_down(unsigned long map_start,
-				       unsigned long map_end)
-{
-	unsigned long real_end, start, last_start;
-	unsigned long step_size;
-	unsigned long addr;
-	unsigned long mapped_ram_size = 0;
-
-	/* xen has big range in reserved near end of ram, skip it at first.*/
-	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
-
-	/* step_size need to be small so pgt_buf from BRK could cover it */
-	step_size = PMD_SIZE;
-	max_pfn_mapped = 0; /* will get exact value next */
-	min_pfn_mapped = real_end >> PAGE_SHIFT;
-	last_start = start = real_end;
-
-	/*
-	 * We start from the top (end of memory) and go to the bottom.
-	 * The memblock_find_in_range() gets us a block of RAM from the
-	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
-	 * for page table.
-	 */
-	while (last_start > map_start) {
-		if (last_start > step_size) {
-			start = round_down(last_start - 1, step_size);
-			if (start < map_start)
-				start = map_start;
-		} else
-			start = map_start;
-		mapped_ram_size += init_range_memory_mapping(start,
-							last_start);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-		last_start = start;
-		min_pfn_mapped = last_start >> PAGE_SHIFT;
-		if (mapped_ram_size >= step_size)
-			step_size = get_new_step_size(step_size);
-	}
-
-	if (real_end < map_end) {
-		init_range_memory_mapping(real_end, map_end);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-	}
-}
-
-/**
- * memory_map_bottom_up - Map [map_start, map_end) bottom up
- * @map_start: start address of the target memory range
- * @map_end: end address of the target memory range
- *
- * This function will setup direct mapping for memory range
- * [map_start, map_end) in bottom-up. Since we have limited the
- * bottom-up allocation above the kernel, the page tables will
- * be allocated just above the kernel and we map the memory
- * in [map_start, map_end) in bottom-up.
- */
-static void __init memory_map_bottom_up(unsigned long map_start,
-					unsigned long map_end)
-{
-	unsigned long next, start;
-	unsigned long mapped_ram_size = 0;
-	/* step_size need to be small so pgt_buf from BRK could cover it */
-	unsigned long step_size = PMD_SIZE;
-
-	start = map_start;
-	min_pfn_mapped = start >> PAGE_SHIFT;
-
-	/*
-	 * We start from the bottom (@map_start) and go to the top (@map_end).
-	 * The memblock_find_in_range() gets us a block of RAM from the
-	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
-	 * for page table.
-	 */
-	while (start < map_end) {
-		if (step_size && map_end - start > step_size) {
-			next = round_up(start + 1, step_size);
-			if (next > map_end)
-				next = map_end;
-		} else {
-			next = map_end;
-		}
-
-		mapped_ram_size += init_range_memory_mapping(start, next);
-		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
-		start = next;
-
-		if (mapped_ram_size >= step_size)
-			step_size = get_new_step_size(step_size);
-	}
-}
-
 void __init init_mem_mapping(void)
 {
 	unsigned long end;
@@ -663,6 +540,7 @@ void __init init_mem_mapping(void)
 
 #ifdef CONFIG_X86_64
 	end = max_pfn << PAGE_SHIFT;
+	set_alloc_range(0x100000, end);
 #else
 	end = max_low_pfn << PAGE_SHIFT;
 #endif
@@ -673,6 +551,13 @@ void __init init_mem_mapping(void)
 	/* Init the trampoline, possibly with KASLR memory offset */
 	init_trampoline();
 
+#ifdef CONFIG_X86_64
+	init_range_memory_mapping(ISA_END_ADDRESS, end);
+	if (max_pfn > max_low_pfn) {
+		/* can we preseve max_low_pfn ?*/
+		max_low_pfn = max_pfn;
+	}
+#else
 	/*
 	 * If the allocation is in bottom-up direction, we setup direct mapping
 	 * in bottom-up, otherwise we setup direct mapping in top-down.
@@ -692,13 +577,6 @@ void __init init_mem_mapping(void)
 	} else {
 		memory_map_top_down(ISA_END_ADDRESS, end);
 	}
-
-#ifdef CONFIG_X86_64
-	if (max_pfn > max_low_pfn) {
-		/* can we preseve max_low_pfn ?*/
-		max_low_pfn = max_pfn;
-	}
-#else
 	early_ioremap_page_table_range_init();
 #endif
 
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 85c94f9..ecf7243 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -58,6 +58,8 @@ unsigned long highstart_pfn, highend_pfn;
 
 bool __read_mostly __vmalloc_start_set = false;
 
+static unsigned long min_pfn_mapped;
+
 /*
  * Creates a middle page table and puts a pointer to it in the
  * given global directory entry. This only returns the gd entry
@@ -516,6 +518,127 @@ void __init native_pagetable_init(void)
 	paging_init();
 }
 
+static unsigned long __init get_new_step_size(unsigned long step_size)
+{
+	/*
+	 * Initial mapped size is PMD_SIZE (2M).
+	 * We can not set step_size to be PUD_SIZE (1G) yet.
+	 * In worse case, when we cross the 1G boundary, and
+	 * PG_LEVEL_2M is not set, we will need 1+1+512 pages (2M + 8k)
+	 * to map 1G range with PTE. Hence we use one less than the
+	 * difference of page table level shifts.
+	 *
+	 * Don't need to worry about overflow in the top-down case, on 32bit,
+	 * when step_size is 0, round_down() returns 0 for start, and that
+	 * turns it into 0x100000000ULL.
+	 * In the bottom-up case, round_up(x, 0) returns 0 though too, which
+	 * needs to be taken into consideration by the code below.
+	 */
+	return step_size << (PMD_SHIFT - PAGE_SHIFT - 1);
+}
+
+/**
+ * memory_map_top_down - Map [map_start, map_end) top down
+ * @map_start: start address of the target memory range
+ * @map_end: end address of the target memory range
+ *
+ * This function will setup direct mapping for memory range
+ * [map_start, map_end) in top-down. That said, the page tables
+ * will be allocated at the end of the memory, and we map the
+ * memory in top-down.
+ */
+void __init memory_map_top_down(unsigned long map_start,
+				       unsigned long map_end)
+{
+	unsigned long real_end, start, last_start;
+	unsigned long step_size;
+	unsigned long addr;
+	unsigned long mapped_ram_size = 0;
+
+	/* xen has big range in reserved near end of ram, skip it at first.*/
+	addr = memblock_find_in_range(map_start, map_end, PMD_SIZE, PMD_SIZE);
+	real_end = addr + PMD_SIZE;
+
+	/* step_size need to be small so pgt_buf from BRK could cover it */
+	step_size = PMD_SIZE;
+	max_pfn_mapped = 0; /* will get exact value next */
+	min_pfn_mapped = real_end >> PAGE_SHIFT;
+	last_start = start = real_end;
+
+	/*
+	 * We start from the top (end of memory) and go to the bottom.
+	 * The memblock_find_in_range() gets us a block of RAM from the
+	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
+	 * for page table.
+	 */
+	while (last_start > map_start) {
+		if (last_start > step_size) {
+			start = round_down(last_start - 1, step_size);
+			if (start < map_start)
+				start = map_start;
+		} else
+			start = map_start;
+		mapped_ram_size += init_range_memory_mapping(start,
+							last_start);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+		last_start = start;
+		min_pfn_mapped = last_start >> PAGE_SHIFT;
+		if (mapped_ram_size >= step_size)
+			step_size = get_new_step_size(step_size);
+	}
+
+	if (real_end < map_end) {
+		init_range_memory_mapping(real_end, map_end);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+	}
+}
+
+/**
+ * memory_map_bottom_up - Map [map_start, map_end) bottom up
+ * @map_start: start address of the target memory range
+ * @map_end: end address of the target memory range
+ *
+ * This function will setup direct mapping for memory range
+ * [map_start, map_end) in bottom-up. Since we have limited the
+ * bottom-up allocation above the kernel, the page tables will
+ * be allocated just above the kernel and we map the memory
+ * in [map_start, map_end) in bottom-up.
+ */
+void __init memory_map_bottom_up(unsigned long map_start,
+					unsigned long map_end)
+{
+	unsigned long next, start;
+	unsigned long mapped_ram_size = 0;
+	/* step_size need to be small so pgt_buf from BRK could cover it */
+	unsigned long step_size = PMD_SIZE;
+
+	start = map_start;
+	min_pfn_mapped = start >> PAGE_SHIFT;
+
+	/*
+	 * We start from the bottom (@map_start) and go to the top (@map_end).
+	 * The memblock_find_in_range() gets us a block of RAM from the
+	 * end of RAM in [min_pfn_mapped, max_pfn_mapped) used as new pages
+	 * for page table.
+	 */
+	while (start < map_end) {
+		if (step_size && map_end - start > step_size) {
+			next = round_up(start + 1, step_size);
+			if (next > map_end)
+				next = map_end;
+		} else {
+			next = map_end;
+		}
+
+		mapped_ram_size += init_range_memory_mapping(start, next);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+		start = next;
+
+		if (mapped_ram_size >= step_size)
+			step_size = get_new_step_size(step_size);
+	}
+}
+
 /*
  * Build a proper pagetable for the kernel mappings.  Up until this
  * point, we've been running on some set of pagetables constructed by
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 319bde3..28006de 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -8,6 +8,13 @@ static inline void *alloc_low_page(void)
 	return alloc_low_pages(1);
 }
 
+unsigned long __init init_range_memory_mapping(unsigned long r_start,
+	unsigned long r_end);
+void set_alloc_range(unsigned long low, unsigned long high);
+void __init memory_map_top_down(unsigned long map_start,
+				       unsigned long map_end);
+void __init memory_map_bottom_up(unsigned long map_start,
+					unsigned long map_end);
 void early_ioremap_page_table_range_init(void);
 
 unsigned long kernel_physical_mapping_init(unsigned long start,
-- 
2.7.4
