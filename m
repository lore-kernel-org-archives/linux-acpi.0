From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 6/6] ACPI/IBFT: Fix wrong <acpi/acpi.h> inclusion in iSCSI boot firmware module.
Date: Fri,  6 Dec 2013 16:52:19 +0800
Message-ID: <7d10180ca652b4a20a07517946fc0fed6a591650.1386316208.git.lv.zheng@intel.com>
References: <cover.1385094640.git.lv.zheng@intel.com> <cover.1386316208.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23825 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab3LFIxY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Dec 2013 03:53:24 -0500
In-Reply-To: <cover.1386316208.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Konrad Rzeszutek Wilk <konrad@kernel.org>, Peter Jones <pjones@redhat.com>

In Linux kernel, ACPICA is wrapped and safely exported by CONFIG_ACPI.  So
all external modules should depend on CONFIG_ACPI rather than using ACPICA
header directly for stubbing.  But if we moves <acpi/acpi.h> inclusions
into "#ifdef CONFIG_ACPI", build breakge can help to detect wrong ACPICA
dependent modules.

One of the build breakage is:
drivers/firmware/iscsi_ibft_find.c: In function 'find_ibft_region':
drivers/firmware/iscsi_ibft_find.c:106:12: error: dereferencing pointer to incomplete type
drivers/firmware/iscsi_ibft_find.c:106:12: error: dereferencing pointer to incomplete type
drivers/firmware/iscsi_ibft_find.c:106:12: error: dereferencing pointer to incomplete type

The root cause of this breakage is:
1. iBFT locating is implemented by looking up it in the memory.  This is
   based on the specification.  Specification doesn't mention if it can
   appear on a non-ACPI platforms but mentions it is defined in ACPI 3.0b.
   The current CONFIG_ISCSI_IBFT_FIND doesn't use ACPI table APIs to locate
   the table, thus it doesn't rely on CONFIG_ACPI.

Since ACPI iSCSI Boot Firmware is an ACPI-based mechanism (please refer to
the Doclink below), we can make CONFIG_ISCSI_IBFT_FIND dependent on
CONFIG_ACPI though the locating mechanism can be implemented without using
ACPI table APIs.  But please let me know if this is wrong.

Doclink: http://www.microsoft.com/whdc/system/platform/firmware/ibft.mspx
Cc: Konrad Rzeszutek Wilk <konrad@kernel.org>
Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/firmware/Kconfig   |    2 +-
 include/linux/iscsi_ibft.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 0747872..a6ef6ac 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -110,7 +110,7 @@ config DMI_SYSFS
 
 config ISCSI_IBFT_FIND
 	bool "iSCSI Boot Firmware Table Attributes"
-	depends on X86
+	depends on X86 && ACPI
 	default n
 	help
 	  This option enables the kernel to find the region of memory
diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
index 82f9673..605cc5c 100644
--- a/include/linux/iscsi_ibft.h
+++ b/include/linux/iscsi_ibft.h
@@ -21,7 +21,7 @@
 #ifndef ISCSI_IBFT_H
 #define ISCSI_IBFT_H
 
-#include <acpi/acpi.h>	/* FIXME: inclusion should be removed */
+#include <linux/acpi.h>
 
 /*
  * Logical location of iSCSI Boot Format Table.
-- 
1.7.10

