From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 01/26] ACPICA: Linuxize: Reduce divergences for 20150619 release.
Date: Wed,  1 Jul 2015 14:42:50 +0800
Message-ID: <67ee37fbf0320ec9ba1d0c049a7ca0b3c61b3ba9.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52278 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376AbbGAGm5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:42:57 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

This patch reduces source code differences between the Linux kernel and the
ACPICA upstream so that the linuxized ACPICA 20150619 release can be
applied with reduced human intervention.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsobject.c  |    2 +-
 drivers/acpi/acpica/hwxfsleep.c |    3 +--
 drivers/acpi/acpica/rscreate.c  |    2 +-
 drivers/acpi/acpica/rsutils.c   |    2 +-
 drivers/acpi/acpica/tbxface.c   |    1 +
 include/acpi/platform/acenv.h   |    1 -
 6 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 8a7b07b..4a4b2f3 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -751,7 +751,7 @@ acpi_ds_init_object_from_op(struct acpi_walk_state *walk_state,
 
 		obj_desc->string.pointer = op->common.value.string;
 		obj_desc->string.length =
-		    (u32) ACPI_STRLEN(op->common.value.string);
+		    (u32)ACPI_STRLEN(op->common.value.string);
 
 		/*
 		 * The string is contained in the ACPI table, don't ever try
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index 3b37676..6f171c2 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -93,6 +93,7 @@ static struct acpi_sleep_functions acpi_sleep_dispatch[] = {
 
 acpi_status acpi_set_firmware_waking_vector(u32 physical_address)
 {
+
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector);
 
 
@@ -138,7 +139,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
 {
 	ACPI_FUNCTION_TRACE(acpi_set_firmware_waking_vector64);
 
-
 	/* Determine if the 64-bit vector actually exists */
 
 	if ((acpi_gbl_FACS->length <= 32) || (acpi_gbl_FACS->version < 1)) {
@@ -154,7 +154,6 @@ acpi_status acpi_set_firmware_waking_vector64(u64 physical_address)
 
 ACPI_EXPORT_SYMBOL(acpi_set_firmware_waking_vector64)
 #endif
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_s4bios
diff --git a/drivers/acpi/acpica/rscreate.c b/drivers/acpi/acpica/rscreate.c
index 15434e4..f30f35e 100644
--- a/drivers/acpi/acpica/rscreate.c
+++ b/drivers/acpi/acpica/rscreate.c
@@ -353,7 +353,7 @@ acpi_rs_create_pci_routing_table(union acpi_operand_object *package_object,
 				/* +1 to include null terminator */
 
 				user_prt->length +=
-				    (u32) ACPI_STRLEN(user_prt->source) + 1;
+				    (u32)ACPI_STRLEN(user_prt->source) + 1;
 				break;
 
 			case ACPI_TYPE_STRING:
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index ece3cd6..90417de 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -367,7 +367,7 @@ acpi_rs_get_resource_source(acpi_rs_length resource_length,
 		    (u32)
 		    ACPI_STRLEN(ACPI_CAST_PTR(char, &aml_resource_source[1])) +
 		    1;
-		total_length = (u32) ACPI_ROUND_UP_TO_NATIVE_WORD(total_length);
+		total_length = (u32)ACPI_ROUND_UP_TO_NATIVE_WORD(total_length);
 
 		ACPI_MEMSET(resource_source->string_ptr, 0, total_length);
 
diff --git a/drivers/acpi/acpica/tbxface.c b/drivers/acpi/acpica/tbxface.c
index 60e94f8..54b9f79 100644
--- a/drivers/acpi/acpica/tbxface.c
+++ b/drivers/acpi/acpica/tbxface.c
@@ -242,6 +242,7 @@ acpi_get_table_header(char *signature,
 				if (!header) {
 					return (AE_NO_MEMORY);
 				}
+
 				ACPI_MEMCPY(out_table_header, header,
 					    sizeof(struct acpi_table_header));
 				acpi_os_unmap_memory(header,
diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 073997d..1e84e62 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -359,7 +359,6 @@
 #define ACPI_MEMCMP(s1,s2,n)    memcmp((const char *)(s1), (const char *)(s2), (acpi_size)(n))
 #define ACPI_MEMCPY(d,s,n)      (void) memcpy((d), (s), (acpi_size)(n))
 #define ACPI_MEMSET(d,s,n)      (void) memset((d), (s), (acpi_size)(n))
-
 #define ACPI_TOUPPER(i)         toupper((int) (i))
 #define ACPI_TOLOWER(i)         tolower((int) (i))
 #define ACPI_IS_XDIGIT(i)       isxdigit((int) (i))
-- 
1.7.10

