From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] tools/testing/nvdimm, acpica: fix flag rename build breakage
Date: Tue, 10 Nov 2015 16:00:18 -0800
Message-ID: <20151110235921.1876.27564.stgit@dwillia2-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14589 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbbKKAA5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Nov 2015 19:00:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

Commit ca321d1ca672 "ACPICA: Update NFIT table to rename a flags field"
performed a tree-wide s/ACPI_NFIT_MEM_ARMED/ACPI_NFIT_MEM_NOT_ARMED/
operation, but missed the tools/testing/nvdimm/ directory.

Cc: Bob Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

I'm working to get build regression coverage for this directory in 0day.

 tools/testing/nvdimm/test/nfit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index dce346aa94ea..40ab4476c80a 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1135,7 +1135,7 @@ static void nfit_test1_setup(struct nfit_test *t)
 	memdev->interleave_ways = 1;
 	memdev->flags = ACPI_NFIT_MEM_SAVE_FAILED | ACPI_NFIT_MEM_RESTORE_FAILED
 		| ACPI_NFIT_MEM_FLUSH_FAILED | ACPI_NFIT_MEM_HEALTH_OBSERVED
-		| ACPI_NFIT_MEM_ARMED;
+		| ACPI_NFIT_MEM_NOT_ARMED;
 
 	offset += sizeof(*memdev);
 	/* dcr-descriptor0 */

