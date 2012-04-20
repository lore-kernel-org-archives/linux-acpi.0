From: Chen Gong <gong.chen@linux.intel.com>
Subject: [RESEND PATCH V2] ACPI, APEI: Add validation check before GHES error is recorded
Date: Fri, 20 Apr 2012 17:24:20 +0800
Message-ID: <1334913860-24651-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2DTJXI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Apr 2012 05:23:08 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: tony.luck@intel.com, ying.huang@intel.com, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

When GHES error record is logged into mcelog kernel buffer,
a validation check for physical address is necessary, which prevents
invalid physical address is happened in error record.

v2->v1:
  Only report error to mcelog kernel buffer when physical address is valid.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index 507ea58..cd8b166 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -42,7 +42,8 @@ void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err *mem_err)
 	struct mce m;
 
 	/* Only corrected MC is reported */
-	if (!corrected)
+	if (!corrected || !(mem_err->validation_bits &
+				CPER_MEM_VALID_PHYSICAL_ADDRESS))
 		return;
 
 	mce_setup(&m);
-- 
1.7.10.rc2.27.g59012

