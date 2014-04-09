From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH 7/7] acpi, apei, ghes: Factor out ioremap virtual memory for IRQ and NMI context.
Date: Wed,  9 Apr 2014 17:14:35 +0200
Message-ID: <1397056476-9183-8-git-send-email-tomasz.nowicki@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, bp@suse.de, m.chehab@samsung.com
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>
List-Id: linux-acpi@vger.kernel.org

GHES currently maps two pages with atomic_ioremap.  From now
on, NMI is optional so there is no need to allocate an NMI page
for platforms without NMI support.

To make it possible to not use a second page, swap the existing
page order so that the IRQ context page is first, and the optional
NMI context page is second.  Then, use CONFIG_ACPI_APEI_NMI to decide
at runtime how many pages are to be allocated.  Finally, put in
sanity checks to avoid accessing unallocated memory.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/apei/ghes.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 624878b..20377ac 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -109,12 +109,11 @@ static DEFINE_MUTEX(ghes_list_mutex);
  */
 
 /*
- * Two virtual pages are used, one for NMI context, the other for
- * IRQ/PROCESS context
+ * Two virtual pages are used, one for IRQ/PROCESS context, the other for
+ * NMI context (optionally).
  */
-#define GHES_IOREMAP_PAGES		2
-#define GHES_IOREMAP_NMI_PAGE(base)	(base)
-#define GHES_IOREMAP_IRQ_PAGE(base)	((base) + PAGE_SIZE)
+#define GHES_IOREMAP_IRQ_PAGE(base)	(base)
+#define GHES_IOREMAP_NMI_PAGE(base)	((base) + PAGE_SIZE)
 
 /* virtual memory area for atomic ioremap */
 static struct vm_struct *ghes_ioremap_area;
@@ -141,7 +140,8 @@ static struct ghes_notify_setup	ghes_notify_tab[];
 
 static int ghes_ioremap_init(void)
 {
-	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
+	ghes_ioremap_area = __get_vm_area(
+		PAGE_SIZE * (IS_ENABLED(CONFIG_ACPI_APEI_NMI) ? 2 : 1),
 		VM_IOREMAP, VMALLOC_START, VMALLOC_END);
 	if (!ghes_ioremap_area) {
 		pr_err(GHES_PFX "Failed to allocate virtual memory area for atomic ioremap.\n");
@@ -310,6 +310,8 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	u64 offset;
 	u32 trunk;
 
+	BUG_ON(in_nmi && !IS_ENABLED(CONFIG_ACPI_APEI_NMI));
+
 	while (len > 0) {
 		offset = paddr - (paddr & PAGE_MASK);
 		if (in_nmi) {
-- 
1.7.9.5
