From: Dmitry Krivenok <krivenok.dmitry@gmail.com>
Subject: [PATCH 1/1] Fix nfit_test compilation error
Date: Fri, 13 Nov 2015 16:51:42 +0300
Message-ID: <CAJN_NGZMaOUwdrWKRLZw9dLFwDihczCgP=Qey8_1BJuVfS0Org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:32794 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754838AbbKMNvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2015 08:51:42 -0500
Received: by ykdv3 with SMTP id v3so146579657ykd.0
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2015 05:51:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Cc: Bob Moore <robert.moore@intel.com>

nfit_test wasn't changed in commit ca321d1c where "ARMED" was
renamed to "NOT_ARMED". Adding one more change to fix the build.

Signed-off-by: Dmitry V. Krivenok <krivenok.dmitry@gmail.com>
---
 tools/testing/nvdimm/test/nfit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index dce346a..40ab447 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1135,7 +1135,7 @@ static void nfit_test1_setup(struct nfit_test *t)
        memdev->interleave_ways = 1;
        memdev->flags = ACPI_NFIT_MEM_SAVE_FAILED | ACPI_NFIT_MEM_RESTORE_FAILED
                | ACPI_NFIT_MEM_FLUSH_FAILED | ACPI_NFIT_MEM_HEALTH_OBSERVED
-               | ACPI_NFIT_MEM_ARMED;
+               | ACPI_NFIT_MEM_NOT_ARMED;

        offset += sizeof(*memdev);
        /* dcr-descriptor0 */
-- 
1.8.5.2
