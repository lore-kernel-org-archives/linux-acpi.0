From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH V2] ACPI, APEI: Add validation check before GHES error is recorded
Date: Sat, 31 Mar 2012 13:54:05 +0800
Message-ID: <1333173245-22348-1-git-send-email-gong.chen@linux.intel.com>
References: <1333164263.7269.7.camel@yhuang-dev>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:64815 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2CaFxB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2012 01:53:01 -0400
In-Reply-To: <1333164263.7269.7.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

When GHES error record is logged into mcelog kernel buffer,
a validation check for physical address is necessary, which prevents
invalid physical address is happened in error record.

v2->v1:
  Only report error to mcelog kernel buffer when physical address is valid.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
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

