From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 1/2] ACPI, APEI, GHES: Remove strict check for memory error handling
Date: Fri, 22 Nov 2013 00:57:04 -0500
Message-ID: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21282 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852Ab3KVGN6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Nov 2013 01:13:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>

Usually SCI is employed to handle corrected error, especially
for memory corrected error but in fact SCI still can be used
to handle any error like memory uncorrected error if BIOS
enable it. For this situation, memory uncorrected error
should be logged as corrected error does, too.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
---
 arch/x86/include/asm/mce.h            | 3 +--
 arch/x86/kernel/cpu/mcheck/mce-apei.c | 6 ++----
 drivers/acpi/apei/ghes.c              | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cbe6b9e..94b263f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -244,7 +244,6 @@ static inline void mcheck_intel_therm_init(void) { }
  */
 
 struct cper_sec_mem_err;
-extern void apei_mce_report_mem_error(int corrected,
-				      struct cper_sec_mem_err *mem_err);
+extern void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err);
 
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index cd8b166..f09da48 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -37,13 +37,11 @@
 
 #include "mce-internal.h"
 
-void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
+void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err)
 {
 	struct mce m;
 
-	/* Only corrected MC is reported */
-	if (!corrected || !(mem_err->validation_bits &
-				CPER_MEM_VALID_PHYSICAL_ADDRESS))
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS))
 		return;
 
 	mce_setup(&m);
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 8ec37bb..039c23c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -453,8 +453,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			ghes_edac_report_mem_error(ghes, sev, mem_err);
 
 #ifdef CONFIG_X86_MCE
-			apei_mce_report_mem_error(sev == GHES_SEV_CORRECTED,
-						  mem_err);
+			apei_mce_report_mem_error(mem_err);
 #endif
 			ghes_handle_memory_failure(gdata, sev);
 		}
-- 
1.8.4.rc3

