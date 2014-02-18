From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v4 4/5] ACPI: Move BAD_MADT_ENTRY() to linux/acpi.h
Date: Tue, 18 Feb 2014 21:54:59 +0800
Message-ID: <1392731700-10992-5-git-send-email-hanjun.guo@linaro.org>
References: <1392731700-10992-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48445 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbaBRN41 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Feb 2014 08:56:27 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so15949984pdb.10
        for <linux-acpi@vger.kernel.org>; Tue, 18 Feb 2014 05:56:26 -0800 (PST)
In-Reply-To: <1392731700-10992-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

BAD_MADT_ENTRY() is arch independent and will be used for all
archs which parsing MADT table, so move it to linux/acpi.h to
simply the code.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/ia64/kernel/acpi.c     |    4 ----
 arch/x86/kernel/acpi/boot.c |    4 ----
 include/linux/acpi.h        |    4 ++++
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
index af9d9e4..f7bd074 100644
--- a/arch/ia64/kernel/acpi.c
+++ b/arch/ia64/kernel/acpi.c
@@ -54,10 +54,6 @@
 #include <asm/sal.h>
 #include <asm/cyclone.h>
 
-#define BAD_MADT_ENTRY(entry, end) (                                        \
-		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
-
 #define PREFIX			"ACPI: "
 
 unsigned int acpi_cpei_override;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 1dac942..123f9e3 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -53,10 +53,6 @@ EXPORT_SYMBOL(acpi_disabled);
 # include <asm/proto.h>
 #endif				/* X86 */
 
-#define BAD_MADT_ENTRY(entry, end) (					    \
-		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
-		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
-
 #define PREFIX			"ACPI: "
 
 int acpi_noirq;				/* skip ACPI IRQ initialization */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1151a1d..6a15ddd 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -108,6 +108,10 @@ static inline void acpi_initrd_override(void *data, size_t size)
 }
 #endif
 
+#define BAD_MADT_ENTRY(entry, end) (					    \
+		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
+		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
+
 char * __acpi_map_table (unsigned long phys_addr, unsigned long size);
 void __acpi_unmap_table(char *map, unsigned long size);
 int early_acpi_boot_init(void);
-- 
1.7.9.5

