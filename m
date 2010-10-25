From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/60] ACPICA: Add ACPI_INLINE configuration parameter
Date: Mon, 25 Oct 2010 02:20:15 -0400
Message-ID: <8f40f171a29d0d2ae1ca8bd4a0c3fc9f514d1e20.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:45935 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0JYGVk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 02:21:40 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00M211NWUXR2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 01:21:35 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

The C inline keyword is not standardized, ACPI_INLINE allows this
to be configured on a per-compiler basis.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c  |    4 ++--
 include/acpi/platform/acenv.h |    6 ++++++
 include/acpi/platform/acgcc.h |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 1728cb9..d2ff432 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -49,7 +49,7 @@
 ACPI_MODULE_NAME("tbfadt")
 
 /* Local prototypes */
-static inline void
+static ACPI_INLINE void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id, u8 byte_width, u64 address);
 
@@ -181,7 +181,7 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
  *
  ******************************************************************************/
 
-static inline void
+static ACPI_INLINE void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 space_id, u8 byte_width, u64 address)
 {
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index c05aeba..a3e334a 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -193,6 +193,12 @@
 #define ACPI_MUTEX_TYPE             ACPI_BINARY_SEMAPHORE
 #endif
 
+/* "inline" keywords - configurable since inline is not standardized */
+
+#ifndef ACPI_INLINE
+#define ACPI_INLINE
+#endif
+
 /*
  * Debugger threading model
  * Use single threaded if the entire subsystem is contained in an application
diff --git a/include/acpi/platform/acgcc.h b/include/acpi/platform/acgcc.h
index 0cd53e3..5dcb953 100644
--- a/include/acpi/platform/acgcc.h
+++ b/include/acpi/platform/acgcc.h
@@ -44,6 +44,8 @@
 #ifndef __ACGCC_H__
 #define __ACGCC_H__
 
+#define ACPI_INLINE             __inline__
+
 /* Function name is used for debug output. Non-ANSI, compiler-dependent */
 
 #define ACPI_GET_FUNCTION_NAME          __func__
-- 
1.7.3.2.90.gd4c43

