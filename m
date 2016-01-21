From: Loc Ho <lho@apm.com>
Subject: [PATCH v4 2/2] acpi: apei: Enable APEI multiple GHES source to share an single external IRQ
Date: Wed, 20 Jan 2016 17:17:39 -0700
Message-ID: <1453335459-3617-3-git-send-email-lho@apm.com>
References: <1453335459-3617-1-git-send-email-lho@apm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36294 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbcAUARw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jan 2016 19:17:52 -0500
Received: by mail-pf0-f182.google.com with SMTP id n128so12942674pfn.3
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jan 2016 16:17:52 -0800 (PST)
In-Reply-To: <1453335459-3617-1-git-send-email-lho@apm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bp@alien8.de, dougthompson@xmission.com, mchehab@osg.samsung.com, tomasz.nowicki@linaro.org, fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, patches@apm.com, Loc Ho <lho@apm.com>, Tuan Phan <tphan@apm.com>

This patch allows APEI generic error source table with external
IRQ to share an single IRQ.

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/apei/ghes.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3dd9c46..76146c8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1011,7 +1011,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
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
1.7.1

