From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 07/19] ACPICA: Fix broken call depth tracing logic.
Date: Wed, 19 Dec 2012 13:37:29 +0800
Message-ID: <55228998cae844ed25fec44b58b6c4f7ed2eb21d.1355810294.git.lv.zheng@intel.com>
References: <cover.1353491652.git.lv.zheng@intel.com> <cover.1355810292.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:2467 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab2LSFhp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Dec 2012 00:37:45 -0500
In-Reply-To: <cover.1355810292.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

This patch does not affect the generation of the Linux binary.
This patch decreases 26 lines of 20121018 divergence.diff.

The ACPICA uses a call depth tracing mechanism by wrapping the return
statements with return macros and marking the entrance with
ACPI_FUNCTION_TRACE_ macros. There are other ACPI_FUNCTION_ macros used
to mark the functions not using this tracing mechanism.

This patch fixes broken call depth tracing logic.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
Binary comparision result:
  Changes can be found are caused by the line folding:
  -    7f64:	68 5e 01 00 00       	push   $0x15e
  +    7f64:	68 5d 01 00 00       	push   $0x15d
  exfldio.c(349-3): acpi_ex_field_datum_io
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    7fa2:	68 23 02 00 00       	push   $0x223
  +    7fa2:	68 22 02 00 00       	push   $0x222
  exfldio.c(546-1): acpi_ex_field_datum_io
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    801d:	68 c8 02 00 00       	push   $0x2c8
  +    801d:	68 c7 02 00 00       	push   $0x2c7
  exfldio.c(711-2): acpi_ex_extract_from_field
  ACPI_ERROR -> AE_INFO -> __LINE__
  -    82d9:	68 8e 02 00 00       	push   $0x28e
  +    82d9:	68 8d 02 00 00       	push   $0x28d
  exfldio.c(653-4): acpi_ex_write_with_update_rule
  ACPI_ERROR -> AE_INFO -> __LINE__
---
Divergences fixing result:
  Before applying: 2037 Lines, 72.3 Kbytes
  After applying: 2011 Lines, 71.6 Kbytes
---
 drivers/acpi/acpica/exfldio.c  |    1 -
 drivers/acpi/acpica/nsxfeval.c |    4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index aa2ccfb..2c2146c 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -329,7 +329,6 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 static u8
 acpi_ex_register_overflow(union acpi_operand_object *obj_desc, u64 value)
 {
-	ACPI_FUNCTION_NAME(ex_register_overflow);
 
 	if (obj_desc->common_field.bit_length >= ACPI_INTEGER_BIT_SIZE) {
 		/*
diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index a5d8ccc..ef29925 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -492,7 +492,7 @@ acpi_walk_namespace(acpi_object_type type,
 	 */
 	status = acpi_ut_acquire_read_lock(&acpi_gbl_namespace_rw_lock);
 	if (ACPI_FAILURE(status)) {
-		return status;
+		return_ACPI_STATUS(status);
 	}
 
 	/*
@@ -550,7 +550,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 
 	status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
+		return (status);
 	}
 
 	node = acpi_ns_validate_handle(obj_handle);
-- 
1.7.10

