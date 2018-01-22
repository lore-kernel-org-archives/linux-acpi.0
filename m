From: James Morse <james.morse@arm.com>
Subject: [RFC 7/7] ACPI / APEI: Split fixmap pages for arm64 NMI-like notifications
Date: Mon, 22 Jan 2018 19:29:42 +0000
Message-ID: <20180122192942.30487-8-james.morse@arm.com>
References: <20180122192942.30487-1-james.morse@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751071AbeAVTcV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 14:32:21 -0500
In-Reply-To: <20180122192942.30487-1-james.morse@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: linux-acpi@vger.kernel.org, huangshaoyu@huawei.com, Tyler Baicar <tbaicar@codeaurora.org>, James Morse <james.morse@arm.com>

Now that ghes uses the fixmap addresses and locks via some indirection
we can support multiple NMI-like notifications on arm64.

These should be named after their notification method. x86's
NOTIFY_NMI is unchanged, change the SEA fixmap entry to use
FIX_APEI_GHES_SEA.

Future patches can add support for FIX_APEI_GHES_SEI and
FIX_APEI_GHES_SDEI_{NORMAL,CRITICAL}.

Not-signed-off: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/fixmap.h | 4 +++-
 drivers/acpi/apei/ghes.c        | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index ec1e6d6fa14c..c3974517c2cb 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -55,7 +55,9 @@ enum fixed_addresses {
 #ifdef CONFIG_ACPI_APEI_GHES
 	/* Used for GHES mapping from assorted contexts */
 	FIX_APEI_GHES_IRQ,
-	FIX_APEI_GHES_NMI,
+#ifdef CONFIG_ACPI_APEI_SEA
+	FIX_APEI_GHES_SEA,
+#endif
 #endif /* CONFIG_ACPI_APEI_GHES */
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6c2391fd00f8..225e546d1081 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -119,7 +119,6 @@ static DEFINE_MUTEX(ghes_list_mutex);
  * handler, but general ioremap can not be used in atomic context, so
  * the fixmap is used instead.
  */
-static DEFINE_RAW_SPINLOCK(ghes_fixmap_lock_nmi);
 static DEFINE_SPINLOCK(ghes_fixmap_lock_irq);
 
 static struct gen_pool *ghes_estatus_pool;
@@ -931,6 +930,7 @@ static struct notifier_block ghes_notifier_hed = {
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
+static DEFINE_RAW_SPINLOCK(ghes_fixmap_lock_sea);
 
 /*
  * Return 0 only if one of the SEA error sources successfully reported an error
@@ -943,8 +943,8 @@ int ghes_notify_sea(void)
 
 static void ghes_sea_add(struct ghes *ghes)
 {
-	ghes->nmi_fixmap_lock = &ghes_fixmap_lock_nmi;
-	ghes->fixmap_idx = FIX_APEI_GHES_NMI;
+	ghes->nmi_fixmap_lock = &ghes_fixmap_lock_sea;
+	ghes->fixmap_idx = FIX_APEI_GHES_SEA;
 	ghes_estatus_queue_grow_pool(ghes);
 
 	mutex_lock(&ghes_list_mutex);
@@ -974,6 +974,7 @@ static inline void ghes_sea_remove(struct ghes *ghes) { }
 static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
+static DEFINE_RAW_SPINLOCK(ghes_fixmap_lock_nmi);
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
-- 
2.15.1

