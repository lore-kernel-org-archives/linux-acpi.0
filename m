From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/94] ACPICA: Fix several warnings under gcc 4 compiler
Date: Fri, 09 Jan 2009 04:26:21 -0500
Message-ID: <6de4048a416d46eb2ac6597d03d2b58806a6b800.1231492608.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:40934 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbZAIJ2B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:01 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD7007OP6AJ27RA@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:56 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

New compiler is pickier than older versions.
Joerg Sonnenberger. From ACPICA BZ 732.

http://www.acpica.org/bugzilla/show_bug.cgi?id=732

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables/tbfadt.c |    4 ++--
 include/acpi/actypes.h       |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 2817158..d2e60a8 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -48,7 +48,7 @@
 ACPI_MODULE_NAME("tbfadt")
 
 /* Local prototypes */
-static void inline
+static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 byte_width, u64 address);
 
@@ -122,7 +122,7 @@ static struct acpi_fadt_info fadt_info_table[] = {
  *
  ******************************************************************************/
 
-static void inline
+static inline void
 acpi_tb_init_generic_address(struct acpi_generic_address *generic_address,
 			     u8 byte_width, u64 address)
 {
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 7220361..a9719d6 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -291,7 +291,7 @@ typedef u32 acpi_physical_address;
 #endif
 
 /*
- * Mescellaneous types
+ * Miscellaneous types
  */
 typedef u32 acpi_status;	/* All ACPI Exceptions */
 typedef u32 acpi_name;		/* 4-byte ACPI name */
@@ -319,7 +319,7 @@ struct uint32_struct {
 #define acpi_semaphore                  void *
 
 /*
- * Acpi integer width. In ACPI version 1, integers are 32 bits.  In ACPI
+ * Acpi integer width. In ACPI version 1, integers are 32 bits. In ACPI
  * version 2, integers are 64 bits. Note that this pertains to the ACPI integer
  * type only, not other integers used in the implementation of the ACPI CA
  * subsystem.
@@ -414,7 +414,7 @@ typedef unsigned long long acpi_integer;
 #define ACPI_NOTIFY_MAX                 0x0B
 
 /*
- * Types associated with ACPI names and objects.  The first group of
+ * Types associated with ACPI names and objects. The first group of
  * values (up to ACPI_TYPE_EXTERNAL_MAX) correspond to the definition
  * of the ACPI object_type() operator (See the ACPI Spec). Therefore,
  * only add to the first group if the spec changes.
@@ -787,7 +787,7 @@ acpi_status(*acpi_exception_handler) (acpi_status aml_status,
 				      u16 opcode,
 				      u32 aml_offset, void *context);
 
-/* Table Event handler (Load, load_table etc) and types */
+/* Table Event handler (Load, load_table, etc.) and types */
 
 typedef
 acpi_status(*acpi_tbl_handler) (u32 event, void *table, void *context);
-- 
1.5.6.6

