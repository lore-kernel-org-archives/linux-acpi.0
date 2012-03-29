From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] ACPI, APEI: Add validation check before GHES error is recorded
Date: Thu, 29 Mar 2012 15:09:12 +0800
Message-ID: <1333004952-12403-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:3616 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583Ab2C2HIJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Mar 2012 03:08:09 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

When GHES error record is logged into mcelog kernel buffer,
a validation check for physical address is necessary, which prevents
invalid physical address is happened in error record.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index 507ea58..514b77f 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -49,7 +49,8 @@ void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
 	m.bank = 1;
 	/* Fake a memory read corrected error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x9f;
-	m.addr = mem_err->physical_addr;
+	if (mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS)
+		m.addr = mem_err->physical_addr;
 	mce_log(&m);
 	mce_notify_irq();
 }
-- 
1.7.10.rc2.27.g59012

