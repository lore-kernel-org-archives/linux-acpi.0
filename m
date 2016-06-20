From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 3/5] ACPI: table upgrade: move arch-specific symbol to asm/acpi.h
Date: Mon, 20 Jun 2016 13:56:11 +0300
Message-ID: <20160620105615.15538-4-aleksey.makarov@linaro.org>
References: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35905 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbcFTK5i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2016 06:57:38 -0400
Received: by mail-lf0-f54.google.com with SMTP id q132so35051563lfe.3
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2016 03:56:38 -0700 (PDT)
In-Reply-To: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

The constant that defines max phys address where the new upgraded
ACPI table should be allocated is arch-specific.  Move it to
<asm/acpi.h>

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/include/asm/acpi.h | 2 ++
 drivers/acpi/tables.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 65f1e95..5391b0a 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -169,4 +169,6 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 }
 #endif
 
+#define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
+
 #endif /* _ASM_X86_ACPI_H */
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b05df13..9f0ad6e 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -35,6 +35,7 @@
 #include <linux/earlycpio.h>
 #include <linux/memblock.h>
 #include <linux/initrd.h>
+#include <linux/acpi.h>
 #include "internal.h"
 
 #ifdef CONFIG_ACPI_CUSTOM_DSDT
@@ -543,7 +544,7 @@ void __init acpi_table_upgrade(void)
 		return;
 
 	acpi_tables_addr =
-		memblock_find_in_range(0, max_low_pfn_mapped << PAGE_SHIFT,
+		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
 				       all_tables_size, PAGE_SIZE);
 	if (!acpi_tables_addr) {
 		WARN_ON(1);
-- 
2.8.3

