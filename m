From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] [PATCH 3/3] x86_32: mark ACPI NVS region
Date: Tue, 24 Jun 2008 15:43:05 +0800
Message-ID: <1214293385.3001.109.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50858 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbYFXHm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Jun 2008 03:42:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-power-mgmt <linux-power-mgmt@linux.intel.com>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Zhang, Rui" <rui.zhang@intel.com>, "Li, Shaohua" <shaohua.li@intel.com>


x86_32: Mark ACPI NVS memory region.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/e820_32.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

Index: linux-2.6/arch/x86/kernel/e820_32.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/e820_32.c	2008-06-19 15:09:51.000000000 +0800
+++ linux-2.6/arch/x86/kernel/e820_32.c	2008-06-19 15:13:03.000000000 +0800
@@ -10,6 +10,8 @@
 #include <linux/pfn.h>
 #include <linux/uaccess.h>
 #include <linux/suspend.h>
+#include <linux/efi.h>
+#include <linux/acpi.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -253,6 +255,30 @@
 			break;
 	}
 }
+
+/* Mark ACPI NVS region so that OS can save/restore it during hibernation */
+static int __init e820_mark_nvs_memory(void)
+{
+	int i;
+
+	if (efi_enabled)
+		return 0;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		if (ei->type != E820_NVS)
+			continue;
+		start = PFN_UP(ei->addr);
+		end = PFN_DOWN(ei->addr + ei->size);
+		if (start >= end)
+			continue;
+		acpi_mark_nvs_region(start, end - 1);
+	}
+	return 0;
+}
+core_initcall(e820_mark_nvs_memory);
 #endif
 
 void __init add_memory_region(unsigned long long start,


