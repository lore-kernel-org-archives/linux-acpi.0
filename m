From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 11/14] ACPICA: Tables: Cleanup RSDP signature codes.
Date: Mon, 23 Sep 2013 09:52:34 +0800
Message-ID: <c5762a96c8735780fb5ab517adbf0b1abe93698c.1379900697.git.lv.zheng@intel.com>
References: <cover.1377844863.git.lv.zheng@intel.com> <cover.1379900697.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37997 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186Ab3IWBwi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Sep 2013 21:52:38 -0400
In-Reply-To: <cover.1379900697.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This patch introduces new macors to handle RSDP signature and cleans up the
affected codes.  Lv Zheng.
Some updates are only used for ACPICA utilities which are not shipped in
the kernel yet.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbprint.c  |    2 +-
 drivers/acpi/acpica/tbxfroot.c |    3 +--
 include/acpi/actypes.h         |    5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/tbprint.c b/drivers/acpi/acpica/tbprint.c
index 499759a..9a47715 100644
--- a/drivers/acpi/acpica/tbprint.c
+++ b/drivers/acpi/acpica/tbprint.c
@@ -138,7 +138,7 @@ acpi_tb_print_table_header(acpi_physical_address address,
 		ACPI_INFO((AE_INFO, "%4.4s %p %05X",
 			   header->signature, ACPI_CAST_PTR(void, address),
 			   header->length));
-	} else if (ACPI_COMPARE_NAME(header->signature, ACPI_SIG_RSDP)) {
+	} else if (ACPI_VALIDATE_RSDP_SIG(header->signature)) {
 
 		/* RSDP has no common fields */
 
diff --git a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
index 948c95e..1c95fab 100644
--- a/drivers/acpi/acpica/tbxfroot.c
+++ b/drivers/acpi/acpica/tbxfroot.c
@@ -68,8 +68,7 @@ acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 	 * Note: Sometimes there exists more than one RSDP in memory; the valid
 	 * RSDP has a valid checksum, all others have an invalid checksum.
 	 */
-	if (ACPI_STRNCMP((char *)rsdp->signature, ACPI_SIG_RSDP,
-			 sizeof(ACPI_SIG_RSDP) - 1) != 0) {
+	if (!ACPI_VALIDATE_RSDP_SIG(rsdp->signature)) {
 
 		/* Nope, BAD Signature */
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 850f750..5400672 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -474,6 +474,11 @@ typedef u64 acpi_integer;
 #define ACPI_MOVE_NAME(dest,src)        (ACPI_STRNCPY (ACPI_CAST_PTR (char, (dest)), ACPI_CAST_PTR (char, (src)), ACPI_NAME_SIZE))
 #endif
 
+/* Support for the special RSDP signature (8 characters) */
+
+#define ACPI_VALIDATE_RSDP_SIG(a)       (!ACPI_STRNCMP (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
+#define ACPI_MAKE_RSDP_SIG(dest)        (ACPI_MEMCPY (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
+
 /*******************************************************************************
  *
  * Miscellaneous constants
-- 
1.7.10

