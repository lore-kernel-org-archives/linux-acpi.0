From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory error handling
Date: Mon, 25 Nov 2013 02:15:00 -0500
Message-ID: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7847 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454Ab3KYHcT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 02:32:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Usually SCI is employed to handle corrected error, especially
for memory corrected error but in fact SCI still can be used
to handle any error like memory uncorrected error even fatal
error if BIOS enable it. For this kind of situation, it
should be logged, too.

v2 -> v1: make the event record more precisely

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c | 10 +++++++---
 drivers/acpi/apei/ghes.c              |  3 +--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index de8b60a..d137ab8 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -33,6 +33,7 @@
 #include <linux/acpi.h>
 #include <linux/cper.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #include <asm/mce.h>
 
 #include "mce-internal.h"
@@ -41,14 +42,17 @@ void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
 
-	/* Only corrected MC is reported */
-	if (!corrected || !(mem_err->validation_bits & CPER_MEM_VALID_PA))
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
 	mce_setup(&m);
 	m.bank = 1;
-	/* Fake a memory read corrected error with unknown channel */
+	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
+	if (corrected >= GHES_SEV_RECOVERABLE)
+		m.status |= MCI_STATUS_UC;
+	if (corrected >= GHES_SEV_PANIC)
+		m.status |= MCI_STATUS_PCC;
 	m.addr = mem_err->physical_addr;
 	mce_log(&m);
 	mce_notify_irq();
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a30bc31..ce3683d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -453,8 +453,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
 #ifdef CONFIG_X86_MCE
-			apei_mce_report_mem_error(sev == GHES_SEV_CORRECTED,
-						  mem_err);
+			apei_mce_report_mem_error(sev, mem_err);
 #endif
 			ghes_handle_memory_failure(gdata, sev);
 		}
-- 
1.8.4.3

