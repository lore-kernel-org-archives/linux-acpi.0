From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Mon, 16 Dec 2013 15:51:29 +0100
Message-ID: <20131216145129.GA9683@pd.tnic>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <529463BD.3070305@linux.vnet.ibm.com>
 <20131126093136.GA27271@gchen.bj.intel.com>
 <20131214134256.GC2823@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:45532 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753685Ab3LPOvb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 09:51:31 -0500
Content-Disposition: inline
In-Reply-To: <20131214134256.GC2823@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, linux-acpi@vger.kernel.org

On Sat, Dec 14, 2013 at 08:42:56AM -0500, Chen, Gong wrote:
> Will you pick up this patch in your RAS request pull?

Applied, with commit message massaging and s/corrected/severity/
automatic variable change, version below:

--
From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI, APEI, GHES: Do not report only correctable errors with SCI

Currently SCI is employed to handle corrected errors, and memory
corrected errors, more specifically but in fact SCI still can be used to
handle any errors, e.g. uncorrected or even fatal ones if enabled by the
BIOS. Enable logging for those kinds of errors too.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Link: http://lkml.kernel.org/r/1385363701-12387-1-git-send-email-gong.chen@linux.intel.com
[ Boris: massage commit message, rename automatic variable. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c | 14 ++++++++++----
 drivers/acpi/apei/ghes.c              |  3 +--
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index de8b60a53f69..a1aef9533154 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -33,22 +33,28 @@
 #include <linux/acpi.h>
 #include <linux/cper.h>
 #include <acpi/apei.h>
+#include <acpi/ghes.h>
 #include <asm/mce.h>
 
 #include "mce-internal.h"
 
-void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
+void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
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
+
+	if (severity >= GHES_SEV_RECOVERABLE)
+		m.status |= MCI_STATUS_UC;
+	if (severity >= GHES_SEV_PANIC)
+		m.status |= MCI_STATUS_PCC;
+
 	m.addr = mem_err->physical_addr;
 	mce_log(&m);
 	mce_notify_irq();
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a30bc313787b..ce3683d93a13 100644
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
1.8.4

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
