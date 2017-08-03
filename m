From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 01/15] ACPICA: Divergences: reduce access size definitions
Date: Thu,  3 Aug 2017 14:26:19 +0800
Message-ID: <c344831f5fcb6a2cf645a4c297cad5b8c0d1e757.1501730699.git.lv.zheng@intel.com>
References: <cover.1501730699.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:6163 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbdHCG0X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 3 Aug 2017 02:26:23 -0400
In-Reply-To: <cover.1501730699.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Loc Ho <lho@apm.com>

ACPICA commit cf27b3c98883d2a15d932016792fcb8272ace96d

The following commit introduces definition of access width to ACPICA.
  Commit: 2bece49394872d36bbc5767fd643deac05920c55
  Subject: ACPI: SPCR: Use access width to determine mmio usage

Actually the access bit width can be calculated via access width. It
would be better to define a macro calculating bit width rather than
defining fixed values. This patch thus cleans up the definitions to
reduce divergences.

Link: https://github.com/acpica/acpica/commit/cf27b3c9
Cc: Loc Ho <lho@apm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/hwregs.c | 2 +-
 drivers/acpi/spcr.c          | 9 +++++----
 include/acpi/acrestyp.h      | 7 -------
 include/acpi/actypes.h       | 7 +++++++
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index de74a4c..acb417b 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -107,7 +107,7 @@ acpi_hw_get_access_bit_width(u64 address,
 	    ACPI_IS_ALIGNED(reg->bit_width, 8)) {
 		access_bit_width = reg->bit_width;
 	} else if (reg->access_width) {
-		access_bit_width = (1 << (reg->access_width + 2));
+		access_bit_width = ACPI_ACCESS_BIT_WIDTH(reg->access_width);
 	} else {
 		access_bit_width =
 		    ACPI_ROUND_UP_POWER_OF_TWO_8(reg->bit_offset +
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 4ac3e06..1230f96 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -95,16 +95,17 @@ int __init parse_spcr(bool earlycon)
 	}
 
 	if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
-		switch (table->serial_port.access_width) {
+		switch (ACPI_ACCESS_BIT_WIDTH((
+			table->serial_port.access_width))) {
 		default:
 			pr_err("Unexpected SPCR Access Width.  Defaulting to byte size\n");
-		case ACPI_ACCESS_SIZE_BYTE:
+		case 8:
 			iotype = "mmio";
 			break;
-		case ACPI_ACCESS_SIZE_WORD:
+		case 16:
 			iotype = "mmio16";
 			break;
-		case ACPI_ACCESS_SIZE_DWORD:
+		case 32:
 			iotype = "mmio32";
 			break;
 		}
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index 4f7f39a..343dbdc 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -377,13 +377,6 @@ struct acpi_resource_generic_register {
 	u64 address;
 };
 
-/* Generic Address Space Access Sizes */
-#define ACPI_ACCESS_SIZE_UNDEFINED		0
-#define ACPI_ACCESS_SIZE_BYTE			1
-#define ACPI_ACCESS_SIZE_WORD			2
-#define ACPI_ACCESS_SIZE_DWORD			3
-#define ACPI_ACCESS_SIZE_QWORD			4
-
 struct acpi_resource_gpio {
 	u8 revision_id;
 	u8 connection_type;
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 2fcbaec..0260be5 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -554,6 +554,13 @@ typedef u64 acpi_integer;
 #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, 8))
 #define ACPI_MAKE_RSDP_SIG(dest)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
 
+/*
+ * Algorithm to obtain access bit width.
+ * Can be used with access_width of struct acpi_generic_address and access_size of
+ * struct acpi_resource_generic_register.
+ */
+#define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
+
 /*******************************************************************************
  *
  * Miscellaneous constants
-- 
2.7.4

