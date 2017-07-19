From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 1/1] acpi: apei: Enable APEI multiple GHES source to share an single external IRQ
Date: Wed, 19 Jul 2017 13:24:27 -0400
Message-ID: <20170719172427.5478-2-msalter@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Loc Ho <lho@apm.com>

This patch allows APEI generic error source table with external
IRQ to share an single IRQ.

Signed-off-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..eed09fc664e8 100644
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
2.13.3
