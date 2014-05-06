From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ACPI / PCI: Stub out pci_acpi_crs_quirks() and make it x86 specific
Date: Tue,  6 May 2014 11:24:30 +0800
Message-ID: <1399346670-6525-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33735 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933794AbaEFDZb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 May 2014 23:25:31 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so6578023pdi.21
        for <linux-acpi@vger.kernel.org>; Mon, 05 May 2014 20:25:30 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Lv Zheng <lv.zheng@intel.com>, Tony Luck <tony.luck@intel.com>, Yijing Wang <wangyijing@huawei.com>, linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

For pci_acpi_crs_quirks(), ia64 already doesn't use it, and we can
not foresee it should be used in ARM64, so stub out pci_acpi_crs_quirks()
to avoid introducing platform specific dummy stub function.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/ia64/include/asm/acpi.h |    1 -
 include/acpi/acpi_drivers.h  |    5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/acpi.h
index d651102..97cb160 100644
--- a/arch/ia64/include/asm/acpi.h
+++ b/arch/ia64/include/asm/acpi.h
@@ -92,7 +92,6 @@ ia64_acpi_release_global_lock (unsigned int *lock)
 #endif
 #define acpi_processor_cstate_check(x) (x) /* no idle limits on IA64 :) */
 static inline void disable_acpi(void) { }
-static inline void pci_acpi_crs_quirks(void) { }
 
 #ifdef CONFIG_IA64_GENERIC
 const char *acpi_get_sysname (void);
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index d504613..ea6428b 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -96,7 +96,12 @@ struct pci_dev *acpi_get_pci_dev(acpi_handle);
 /* Arch-defined function to add a bus to the system */
 
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root);
+
+#ifdef CONFIG_X86
 void pci_acpi_crs_quirks(void);
+#else
+static inline void pci_acpi_crs_quirks(void) { }
+#endif
 
 /* --------------------------------------------------------------------------
                                     Processor
-- 
1.7.9.5

