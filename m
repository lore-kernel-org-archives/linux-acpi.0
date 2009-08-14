From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/11] ACPI: Handle CONFIG_ACPI=n better from linux/acpi.h
Date: Fri, 14 Aug 2009 16:38:08 -0400
Message-ID: <f5279001313a8763cabc9d22d5297da8525fd2b8.1250281826.git.len.brown@intel.com>
References: <1250282295-25216-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:58535 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbZHNUkk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 16:40:40 -0400
In-reply-to: <1250282295-25216-1-git-send-email-lenb@kernel.org>
In-reply-to: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
References: <0763223ab0ef5c0016b7a179c1acccaabbefea02.1250281826.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: x86@kernel.org, sfi-devel@simplefirmware.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>

From: Feng Tang <feng.tang@intel.com>

linux/acpi.h is the top level header for interfacing
with the ACPI sub-system, so acpi_disabled should be
up there instead of down in asm/acpi.h -- particularly
since asm/acpi.h doesn't exist for all architectures.

Same story for acpi_table_parse(), which is a top-level
API to Linux/ACPI.

This is necessary for building some code that
used to always depend on CONFIG_ACPI=y, but will soon
also need to build with CONFIG_ACPI=n.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/include/asm/acpi.h |    1 -
 include/linux/acpi.h        |   11 ++++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 20d1465..4518dc5 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -144,7 +144,6 @@ static inline unsigned int acpi_processor_cstate_check(unsigned int max_cstate)
 
 #else /* !CONFIG_ACPI */
 
-#define acpi_disabled 1
 #define acpi_lapic 0
 #define acpi_ioapic 0
 static inline void acpi_noirq_set(void) { }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34321cf..3fce811 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -292,7 +292,10 @@ void __init acpi_s4_no_nvs(void);
 extern acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 flags);
 extern void acpi_early_init(void);
 
-#else	/* CONFIG_ACPI */
+#else	/* !CONFIG_ACPI */
+
+#define acpi_disabled 1
+
 static inline void acpi_early_init(void) { }
 
 static inline int early_acpi_boot_init(void)
@@ -331,5 +334,11 @@ static inline int acpi_check_mem_region(resource_size_t start,
 	return 0;
 }
 
+struct acpi_table_header;
+static inline int acpi_table_parse(char *id,
+				int (*handler)(struct acpi_table_header *))
+{
+	return -1;
+}
 #endif	/* !CONFIG_ACPI */
 #endif	/*_LINUX_ACPI_H*/
-- 
1.6.0.6

