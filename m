From: Loc Ho <lho@apm.com>
Subject: [PATCH v3 2/2] acpi: apei: Enable APEI multiple GHES source to share an single external IRQ
Date: Fri,  6 Nov 2015 17:51:59 -0700
Message-ID: <1446857519-5908-3-git-send-email-lho@apm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33846 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbbKGAwY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Nov 2015 19:52:24 -0500
Received: by padhx2 with SMTP id hx2so129880646pad.1
        for <linux-acpi@vger.kernel.org>; Fri, 06 Nov 2015 16:52:23 -0800 (PST)
In-Reply-To: <1446857519-5908-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dougthompson@xmission.com, bp@alien8.de, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>

This patch allows APEI generic error source table with external
IRQ to share an single IRQ.

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/apei/ghes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3dd9c46..edc8a39 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1011,7 +1011,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			       generic->header.source_id);
 			goto err_edac_unreg;
 		}
-		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
+		rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED, "GHES IRQ", ghes);
 		if (rc) {
 			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
-- 
1.7.1

