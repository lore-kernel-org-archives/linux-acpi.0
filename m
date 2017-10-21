From: Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v7] acpi: apei: remove the unused dead-code for SEA/NMI notification type
Date: Sat, 21 Oct 2017 18:35:03 +0800
Message-ID: <20171021103503.23598-1-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8969 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752605AbdJUCoO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Oct 2017 22:44:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tbaicar@codeaurora.org, will.deacon@arm.com, bp@suse.de, prarit@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gengdongjiu@huawei.com

For the SEA notification, the two functions ghes_sea_add() and
ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
is defined. If not, it will return errors in the ghes_probe()
and not continue. If the probe is failed, the ghes_sea_remove()
also has no chance to be called. Hence, remove the unnecessary
handling when CONFIG_ACPI_APEI_SEA is not defined.

For the NMI notification, it has the same issue as SEA notification,
so also remove the unused dead-code for it.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/acpi/apei/ghes.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..3eee30a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -849,17 +849,8 @@ static void ghes_sea_remove(struct ghes *ghes)
 	synchronize_rcu();
 }
 #else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
-
-static inline void ghes_sea_remove(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
+static inline void ghes_sea_add(struct ghes *ghes) { }
+static inline void ghes_sea_remove(struct ghes *ghes) { }
 #endif /* CONFIG_ACPI_APEI_SEA */
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
@@ -1061,23 +1052,9 @@ static void ghes_nmi_init_cxt(void)
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
-	       ghes->generic->header.source_id);
-	BUG();
-}
-
-static inline void ghes_nmi_remove(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
-	       ghes->generic->header.source_id);
-	BUG();
-}
-
-static inline void ghes_nmi_init_cxt(void)
-{
-}
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+static inline void ghes_nmi_init_cxt(void) { }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static int ghes_probe(struct platform_device *ghes_dev)
-- 
2.10.1

