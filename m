From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 3/3] x86, mm: Move max_pfn_mapped definition to init.c.
Date: Fri, 23 Aug 2013 14:31:20 +0800
Message-ID: <1377239480-32532-4-git-send-email-tangchen@cn.fujitsu.com>
References: <1377239480-32532-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377239480-32532-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com, hpa@zytor.com, yinghai@kernel.org, penberg@kernel.org, jacob.shin@amd.com, tglx@linutronix.de, lenb@kernel.org, rjw@sisk.pl
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
List-Id: linux-acpi@vger.kernel.org

min_pfn_mapped is defined in init.c, we can also define max_pfn_mapped here.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 arch/x86/kernel/setup.c |    8 --------
 arch/x86/mm/init.c      |    9 +++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f13df7b..382e20b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -111,14 +111,6 @@
 #include <asm/alternative.h>
 #include <asm/prom.h>
 
-/*
- * max_pfn_mapped:     highest direct mapped pfn
- *
- * The direct mapping only covers E820_RAM regions, so the ranges and gaps are
- * represented by pfn_mapped
- */
-unsigned long max_pfn_mapped;
-
 #ifdef CONFIG_DMI
 RESERVE_BRK(dmi_alloc, 65536);
 #endif
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index a97749f..793204b 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -24,6 +24,15 @@ static unsigned long __initdata pgt_buf_start;
 static unsigned long __initdata pgt_buf_end;
 static unsigned long __initdata pgt_buf_top;
 
+/*
+ * max_pfn_mapped:     highest direct mapped pfn
+ * min_pfn_mapped:     lowest direct mapped pfn
+ *
+ * The direct mapping only covers E820_RAM regions, so the ranges and gaps are
+ * represented by pfn_mapped
+ */
+
+unsigned long max_pfn_mapped;
 static unsigned long min_pfn_mapped;
 
 static bool __initdata can_use_brk_pgt = true;
-- 
1.7.1
