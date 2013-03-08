From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/14] x86, ACPI, mm: Kill max_low_pfn_mapped
Date: Thu,  7 Mar 2013 20:58:27 -0800
Message-ID: <1362718720-27048-2-git-send-email-yinghai@kernel.org>
References: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1362718720-27048-1-git-send-email-yinghai@kernel.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Jacob Shin <jacob.shin@amd.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Now we have arch_pfn_mapped array, and max_low_pfn_mapped should not
be used anymore.

Only user is ACPI_OVERRIDE, and it should not use that, as later
accessing is using early_remap. Change to try to 4G below and
then 4G above.

Other user is in drm/i915, but it is commented out.

Should use arch_pfn_mapped or just 1<<(32-PAGE_SHIFT) instead.

Suggested-by: H. Peter Anvin <hpa@linux.intel.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Jacob Shin <jacob.shin@amd.com>
Cc: linux-acpi@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 arch/x86/include/asm/page_types.h      |    1 -
 arch/x86/kernel/setup.c                |    4 +---
 arch/x86/mm/init.c                     |    4 ----
 drivers/acpi/osl.c                     |    9 ++++++---
 drivers/gpu/drm/i915/i915_gem_stolen.c |    2 +-
 5 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 54c9787..b012b82 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -43,7 +43,6 @@
 
 extern int devmem_is_allowed(unsigned long pagenr);
 
-extern unsigned long max_low_pfn_mapped;
 extern unsigned long max_pfn_mapped;
 
 static inline phys_addr_t get_max_mapped(void)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 90d8cc9..4dcaae7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -113,13 +113,11 @@
 #include <asm/prom.h>
 
 /*
- * max_low_pfn_mapped: highest direct mapped pfn under 4GB
- * max_pfn_mapped:     highest direct mapped pfn over 4GB
+ * max_pfn_mapped:     highest direct mapped pfn
  *
  * The direct mapping only covers E820_RAM regions, so the ranges and gaps are
  * represented by pfn_mapped
  */
-unsigned long max_low_pfn_mapped;
 unsigned long max_pfn_mapped;
 
 #ifdef CONFIG_DMI
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 59b7fc4..abcc241 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -313,10 +313,6 @@ static void add_pfn_range_mapped(unsigned long start_pfn, unsigned long end_pfn)
 	nr_pfn_mapped = clean_sort_range(pfn_mapped, E820_X_MAX);
 
 	max_pfn_mapped = max(max_pfn_mapped, end_pfn);
-
-	if (start_pfn < (1UL<<(32-PAGE_SHIFT)))
-		max_low_pfn_mapped = max(max_low_pfn_mapped,
-					 min(end_pfn, 1UL<<(32-PAGE_SHIFT)));
 }
 
 bool pfn_range_is_mapped(unsigned long start_pfn, unsigned long end_pfn)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 586e7e9..c9e36d7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -624,9 +624,12 @@ void __init acpi_initrd_override(void *data, size_t size)
 	if (table_nr == 0)
 		return;
 
-	acpi_tables_addr =
-		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
-				       all_tables_size, PAGE_SIZE);
+	/* under 4G at first, then above 4G */
+	acpi_tables_addr = memblock_find_in_range(0, 1ULL<<32,
+					all_tables_size, PAGE_SIZE);
+	if (!acpi_tables_addr)
+		acpi_tables_addr = memblock_find_in_range(1ULL<<32, -1ULL,
+					all_tables_size, PAGE_SIZE);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
 		return;
diff --git a/drivers/gpu/drm/i915/i915_gem_stolen.c b/drivers/gpu/drm/i915/i915_gem_stolen.c
index 69d97cb..7f9380b 100644
--- a/drivers/gpu/drm/i915/i915_gem_stolen.c
+++ b/drivers/gpu/drm/i915/i915_gem_stolen.c
@@ -81,7 +81,7 @@ static unsigned long i915_stolen_to_physical(struct drm_device *dev)
 		base -= dev_priv->mm.gtt->stolen_size;
 	} else {
 		/* Stolen is immediately above Top of Memory */
-		base = max_low_pfn_mapped << PAGE_SHIFT;
+		base = __REMOVED_CRAZY__ << PAGE_SHIFT;
 #endif
 	}
 
-- 
1.7.10.4
