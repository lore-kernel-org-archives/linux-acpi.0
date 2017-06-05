From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 40/53] ACPICA: Comment update: spelling/format. No functional change
Date: Mon,  5 Jun 2017 16:41:12 +0800
Message-ID: <6de8712deb146f318362ff33b1c2c8cb9c5dcb2c.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:41769 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFEIlP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:41:15 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit d9861dae21b41d48745496bac2665f14e4e28c08

Fix some spelling errors and reformat some long lines.

Link: https://github.com/acpica/acpica/commit/d9861dae
Reported-by: Cao Jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 7aa186d..2fcbaec 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -47,9 +47,9 @@
 /* acpisrc:struct_defs -- for acpisrc conversion */
 
 /*
- * ACPI_MACHINE_WIDTH must be specified in an OS- or compiler-dependent header
- * and must be either 32 or 64. 16-bit ACPICA is no longer supported, as of
- * 12/2006.
+ * ACPI_MACHINE_WIDTH must be specified in an OS- or compiler-dependent
+ * header and must be either 32 or 64. 16-bit ACPICA is no longer
+ * supported, as of 12/2006.
  */
 #ifndef ACPI_MACHINE_WIDTH
 #error ACPI_MACHINE_WIDTH not defined
@@ -87,9 +87,9 @@
  * s64          64-bit (8 byte) signed value
  *
  * COMPILER_DEPENDENT_UINT64/s64 - These types are defined in the
- * compiler-dependent header(s) and were introduced because there is no common
- * 64-bit integer type across the various compilation models, as shown in
- * the table below.
+ * compiler-dependent header(s) and were introduced because there is no
+ * common 64-bit integer type across the various compilation models, as
+ * shown in the table below.
  *
  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
  * char      8    8     8     8     8    8
@@ -106,10 +106,10 @@
  * 2) These types represent the native word size of the target mode of the
  * processor, and may be 16-bit, 32-bit, or 64-bit as required. They are
  * usually used for memory allocation, efficient loop counters, and array
- * indexes. The types are similar to the size_t type in the C library and are
- * required because there is no C type that consistently represents the native
- * data width. acpi_size is needed because there is no guarantee that a
- * kernel-level C library is present.
+ * indexes. The types are similar to the size_t type in the C library and
+ * are required because there is no C type that consistently represents the
+ * native data width. acpi_size is needed because there is no guarantee
+ * that a kernel-level C library is present.
  *
  * acpi_size        16/32/64-bit unsigned value
  * acpi_native_int  16/32/64-bit signed value
@@ -169,9 +169,10 @@ typedef u64 acpi_physical_address;
 
 /*
  * In the case of the Itanium Processor Family (IPF), the hardware does not
- * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORTED flag
- * to indicate that special precautions must be taken to avoid alignment faults.
- * (IA64 or ia64 is currently used by existing compilers to indicate IPF.)
+ * support misaligned memory transfers. Set the MISALIGNMENT_NOT_SUPPORTED
+ * flag to indicate that special precautions must be taken to avoid alignment
+ * faults. (IA64 or ia64 is currently used by existing compilers to indicate
+ * IPF.)
  *
  * Note: EM64T and other X86-64 processors support misaligned transfers,
  * so there is no need to define this flag.
@@ -309,8 +310,8 @@ typedef u64 acpi_physical_address;
 #endif
 
 /*
- * Some compilers complain about unused variables. Sometimes we don't want to
- * use all the variables (for example, _acpi_module_name). This allows us
+ * Some compilers complain about unused variables. Sometimes we don't want
+ * to use all the variables (for example, _acpi_module_name). This allows us
  * to tell the compiler in a per-variable manner that a variable
  * is unused
  */
@@ -319,8 +320,9 @@ typedef u64 acpi_physical_address;
 #endif
 
 /*
- * All ACPICA external functions that are available to the rest of the kernel
- * are tagged with thes macros which can be defined as appropriate for the host.
+ * All ACPICA external functions that are available to the rest of the
+ * kernel are tagged with these macros which can be defined as appropriate
+ * for the host.
  *
  * Notes:
  * ACPI_EXPORT_SYMBOL_INIT is used for initialization and termination
@@ -383,7 +385,8 @@ typedef u64 acpi_physical_address;
 
 /******************************************************************************
  *
- * ACPI Specification constants (Do not change unless the specification changes)
+ * ACPI Specification constants (Do not change unless the specification
+ * changes)
  *
  *****************************************************************************/
 
@@ -484,10 +487,10 @@ typedef u8 acpi_owner_id;
 #define ACPI_DO_NOT_WAIT                0
 
 /*
- * Obsolete: Acpi integer width. In ACPI version 1 (1996), integers are 32 bits.
- * In ACPI version 2 (2000) and later, integers are 64 bits. Note that this
- * pertains to the ACPI integer type only, not to other integers used in the
- * implementation of the ACPICA subsystem.
+ * Obsolete: Acpi integer width. In ACPI version 1 (1996), integers are
+ * 32 bits. In ACPI version 2 (2000) and later, integers are max 64 bits.
+ * Note that this pertains to the ACPI integer type only, not to other
+ * integers used in the implementation of the ACPICA subsystem.
  *
  * 01/2010: This type is obsolete and has been removed from the entire ACPICA
  * code base. It remains here for compatibility with device drivers that use
@@ -668,10 +671,11 @@ typedef u32 acpi_object_type;
 
 /*
  * These are object types that do not map directly to the ACPI
- * object_type() operator. They are used for various internal purposes only.
- * If new predefined ACPI_TYPEs are added (via the ACPI specification), these
- * internal types must move upwards. (There is code that depends on these
- * values being contiguous with the external types above.)
+ * object_type() operator. They are used for various internal purposes
+ * only. If new predefined ACPI_TYPEs are added (via the ACPI
+ * specification), these internal types must move upwards. (There
+ * is code that depends on these values being contiguous with the
+ * external types above.)
  */
 #define ACPI_TYPE_LOCAL_REGION_FIELD    0x11
 #define ACPI_TYPE_LOCAL_BANK_FIELD      0x12
@@ -771,7 +775,7 @@ typedef u32 acpi_event_status;
  *   |  | | |  +-- Type of dispatch:to method, handler, notify, or none
  *   |  | | +----- Interrupt type: edge or level triggered
  *   |  | +------- Is a Wake GPE
- *   |  +--------- Is GPE masked by the software GPE masking machanism
+ *   |  +--------- Is GPE masked by the software GPE masking mechanism
  *   +------------ <Reserved>
  */
 #define ACPI_GPE_DISPATCH_NONE          (u8) 0x00
@@ -909,8 +913,8 @@ struct acpi_sleep_functions {
  */
 
 /*
- * Note: Type == ACPI_TYPE_ANY (0) is used to indicate a NULL package element
- * or an unresolved named reference.
+ * Note: Type == ACPI_TYPE_ANY (0) is used to indicate a NULL package
+ * element or an unresolved named reference.
  */
 union acpi_object {
 	acpi_object_type type;	/* See definition of acpi_ns_type for values */
@@ -1167,7 +1171,7 @@ struct acpi_pnp_device_id_list {
 
 /*
  * Structure returned from acpi_get_object_info.
- * Optimized for both 32- and 64-bit builds
+ * Optimized for both 32-bit and 64-bit builds.
  */
 struct acpi_device_info {
 	u32 info_size;		/* Size of info, including ID strings */
-- 
2.7.4

