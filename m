From: Loc Ho <lho@apm.com>
Subject: [PATCH v5 1/1] acpi: apei: Enable APEI multiple GHES source to share an single external IRQ
Date: Thu, 20 Jul 2017 14:36:03 -0700
Message-ID: <1500586563-7088-2-git-send-email-lho@apm.com>
References: <1500586563-7088-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:32791 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936301AbdGTVgI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jul 2017 17:36:08 -0400
Received: by mail-pg0-f43.google.com with SMTP id k14so20048406pgr.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jul 2017 14:36:08 -0700 (PDT)
In-Reply-To: <1500586563-7088-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@suse.de, msalter@redhat.com, rafael@kernel.org, tbaicar@codeaurora.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@apm.com, Loc Ho <lho@apm.com>

This patch allows APEI generic error source table with external
IRQ to share a single IRQ.

Co-authored-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..eed09fc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1157,7 +1157,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			       generic->header.source_id);
 			goto err_edac_unreg;
 		}
-		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
+		rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
+				 "GHES IRQ", ghes);
 		if (rc) {
 			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
-- 
1.8.3.1

