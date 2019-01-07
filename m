From: Pingfan Liu <kernelfans@gmail.com>
Subject: [RFC PATCH 3/4] x86/mm: set allowed range for memblock allocator
Date: Mon,  7 Jan 2019 16:24:44 +0800
Message-ID: <1546849485-27933-4-git-send-email-kernelfans@gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Due to the incoming divergence of x86_32 and x86_64, there is requirement
to set the allowed allocating range at the early boot stage.
This patch also includes minor change to remove redundat cond check, refer
to memblock_find_in_range_node(), memblock_find_in_range() has already
protect itself from the case: start > end.

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
 arch/x86/mm/init.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index f905a23..84baa66 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -76,6 +76,14 @@ static unsigned long min_pfn_mapped;
 
 static bool __initdata can_use_brk_pgt = true;
 
+static unsigned long min_pfn_allowed;
+static unsigned long max_pfn_allowed;
+void set_alloc_range(unsigned long low, unsigned long high)
+{
+	min_pfn_allowed = low;
+	max_pfn_allowed = high;
+}
+
 /*
  * Pages returned are already directly mapped.
  *
@@ -100,12 +108,10 @@ __ref void *alloc_low_pages(unsigned int num)
 	if ((pgt_buf_end + num) > pgt_buf_top || !can_use_brk_pgt) {
 		unsigned long ret = 0;
 
-		if (min_pfn_mapped < max_pfn_mapped) {
-			ret = memblock_find_in_range(
-					min_pfn_mapped << PAGE_SHIFT,
-					max_pfn_mapped << PAGE_SHIFT,
-					PAGE_SIZE * num , PAGE_SIZE);
-		}
+		ret = memblock_find_in_range(
+			min_pfn_allowed << PAGE_SHIFT,
+			max_pfn_allowed << PAGE_SHIFT,
+			PAGE_SIZE * num, PAGE_SIZE);
 		if (ret)
 			memblock_reserve(ret, PAGE_SIZE * num);
 		else if (can_use_brk_pgt)
@@ -588,14 +594,17 @@ static void __init memory_map_top_down(unsigned long map_start,
 			start = map_start;
 		mapped_ram_size += init_range_memory_mapping(start,
 							last_start);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		last_start = start;
 		min_pfn_mapped = last_start >> PAGE_SHIFT;
 		if (mapped_ram_size >= step_size)
 			step_size = get_new_step_size(step_size);
 	}
 
-	if (real_end < map_end)
+	if (real_end < map_end) {
 		init_range_memory_mapping(real_end, map_end);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
+	}
 }
 
 /**
@@ -636,6 +645,7 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 		}
 
 		mapped_ram_size += init_range_memory_mapping(start, next);
+		set_alloc_range(min_pfn_mapped, max_pfn_mapped);
 		start = next;
 
 		if (mapped_ram_size >= step_size)
-- 
2.7.4
