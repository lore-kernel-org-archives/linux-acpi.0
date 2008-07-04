From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20080701 linuxized patch set
Date: Fri, 04 Jul 2008 13:10:34 +0800
Message-ID: <1215148234.12780.10.camel@minggr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tx5/t7+0D6909IRHfDPq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47764 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203AbYGDFN3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jul 2008 01:13:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>


--=-tx5/t7+0D6909IRHfDPq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attachment is the linuxized patch set of ACPICA Release 20080701.

Anyone interested may apply the patch set on top of Len's tree (branch
release-2.6.27).

1. git-clone
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
release-2.6.27

2. git-am R07_01_08.mbox

This patch set include:
---
ACPICA: Cleanup macro definition file
ACPICA: Copy dynamically loaded tables to local buffer
ACPICA: Fix warning for 64-bit build
ACPICA: Add check for invalid handle in acpi_get_object_info
ACPICA: Fix memory leak when deleting thermal/processor objects
ACPICA: Allow same ACPI table to be loaded/unloaded more than once
ACPICA: Fix possible memory leak in Unload() operator
ACPICA: Return method arg count from acpi_get_object_info
ACPICA: Fix wrong resource descriptor length for 64-bit build
ACPICA: Fix table compare code, length then data
ACPICA: Update version to 20080701

Lin Ming

--=-tx5/t7+0D6909IRHfDPq
Content-Disposition: attachment; filename=R07_01_08.mbox
Content-Type: application/mbox; name=R07_01_08.mbox
Content-Transfer-Encoding: 7bit

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 1/15] ACPICA: Cleanup macro definition file
From: Bob Moore <robert.moore@intel.com>
Date: Tue Jun 10 14:24:15 2008 -0700

Removed unused macros. Ensure that multiple parameters always
have a space after a comma. Cleanup some comments.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 acmacros.h |  311 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 137 insertions(+), 174 deletions(-)

diff -Nurp original.linux/include/acpi/acmacros.h new.linux/include/acpi/acmacros.h
--- original.linux/include/acpi/acmacros.h	2008-07-04 09:22:54.000000000 +0800
+++ new.linux/include/acpi/acmacros.h	2008-07-04 09:23:00.000000000 +0800
@@ -62,7 +62,7 @@
 #define ACPI_ARRAY_LENGTH(x)            (sizeof(x) / sizeof((x)[0]))
 
 /*
- * Extract data using a pointer.  Any more than a byte and we
+ * Extract data using a pointer. Any more than a byte and we
  * get into potential aligment issues -- see the STORE macros below.
  * Use with care.
  */
@@ -80,21 +80,21 @@
  */
 #define ACPI_CAST_PTR(t, p)             ((t *) (acpi_uintptr_t) (p))
 #define ACPI_CAST_INDIRECT_PTR(t, p)    ((t **) (acpi_uintptr_t) (p))
-#define ACPI_ADD_PTR(t,a,b)             ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8,(a)) + (acpi_size)(b)))
-#define ACPI_PTR_DIFF(a,b)              (acpi_size) (ACPI_CAST_PTR (u8,(a)) - ACPI_CAST_PTR (u8,(b)))
+#define ACPI_ADD_PTR(t, a, b)           ACPI_CAST_PTR (t, (ACPI_CAST_PTR (u8, (a)) + (acpi_size)(b)))
+#define ACPI_PTR_DIFF(a, b)             (acpi_size) (ACPI_CAST_PTR (u8, (a)) - ACPI_CAST_PTR (u8, (b)))
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void,(void *) NULL,(acpi_size) i)
-#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p,(void *) NULL)
-#define ACPI_OFFSET(d,f)                (acpi_size) ACPI_PTR_DIFF (&(((d *)0)->f),(void *) NULL)
+#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL,(acpi_size) i)
+#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) NULL)
+#define ACPI_OFFSET(d, f)               (acpi_size) ACPI_PTR_DIFF (&(((d *)0)->f), (void *) NULL)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
-#define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32,(a)) == *ACPI_CAST_PTR (u32,(b)))
+#define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32, (a)) == *ACPI_CAST_PTR (u32, (b)))
 #else
-#define ACPI_COMPARE_NAME(a,b)          (!ACPI_STRNCMP (ACPI_CAST_PTR (char,(a)), ACPI_CAST_PTR (char,(b)), ACPI_NAME_SIZE))
+#define ACPI_COMPARE_NAME(a,b)          (!ACPI_STRNCMP (ACPI_CAST_PTR (char, (a)), ACPI_CAST_PTR (char, (b)), ACPI_NAME_SIZE))
 #endif
 
 /*
@@ -114,7 +114,7 @@ struct acpi_integer_overlay {
 
 /* Split 64-bit integer into two 32-bit values. Use with %8.8_x%8.8_x */
 
-#define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i),ACPI_LODWORD(i)
+#define ACPI_FORMAT_UINT64(i)           ACPI_HIDWORD(i), ACPI_LODWORD(i)
 
 #if ACPI_MACHINE_WIDTH == 64
 #define ACPI_FORMAT_NATIVE_UINT(i)      ACPI_FORMAT_UINT64(i)
@@ -132,37 +132,33 @@ struct acpi_integer_overlay {
  * Macros for big-endian machines
  */
 
-/* This macro sets a buffer index, starting from the end of the buffer */
-
-#define ACPI_BUFFER_INDEX(buf_len,buf_offset,byte_gran) ((buf_len) - (((buf_offset)+1) * (byte_gran)))
-
 /* These macros reverse the bytes during the move, converting little-endian to big endian */
 
 			  /* Big Endian      <==        Little Endian */
 			  /*  Hi...Lo                     Lo...Hi     */
 /* 16-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_16_TO_16(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
+#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
 					   ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
 
-#define ACPI_MOVE_16_TO_32(d,s)         {(*(u32 *)(void *)(d))=0;\
+#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d))=0;\
 							   ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
 							   ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
-#define ACPI_MOVE_16_TO_64(d,s)         {(*(u64 *)(void *)(d))=0;\
+#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
 									 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
 									 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
 
 /* 32-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_32_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
+#define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
-#define ACPI_MOVE_32_TO_32(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
+#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
 										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
 										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
 										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
-#define ACPI_MOVE_32_TO_64(d,s)         {(*(u64 *)(void *)(d))=0;\
+#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
 										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
 										   ((u8 *)(void *)(d))[5] = ((u8 *)(void *)(s))[2];\
 										   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
@@ -170,11 +166,11 @@ struct acpi_integer_overlay {
 
 /* 64-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_64_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
+#define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
-#define ACPI_MOVE_64_TO_32(d,s)         ACPI_MOVE_32_TO_32(d,s)	/* Truncate to 32 */
+#define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
 
-#define ACPI_MOVE_64_TO_64(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
+#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[7];\
 										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[6];\
 										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[5];\
 										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[4];\
@@ -187,63 +183,59 @@ struct acpi_integer_overlay {
  * Macros for little-endian machines
  */
 
-/* This macro sets a buffer index, starting from the beginning of the buffer */
-
-#define ACPI_BUFFER_INDEX(buf_len,buf_offset,byte_gran) (buf_offset)
-
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
 
 /* The hardware supports unaligned transfers, just do the little-endian move */
 
 /* 16-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_16_TO_16(d,s)         *(u16 *)(void *)(d) = *(u16 *)(void *)(s)
-#define ACPI_MOVE_16_TO_32(d,s)         *(u32 *)(void *)(d) = *(u16 *)(void *)(s)
-#define ACPI_MOVE_16_TO_64(d,s)         *(u64 *)(void *)(d) = *(u16 *)(void *)(s)
+#define ACPI_MOVE_16_TO_16(d, s)        *(u16 *)(void *)(d) = *(u16 *)(void *)(s)
+#define ACPI_MOVE_16_TO_32(d, s)        *(u32 *)(void *)(d) = *(u16 *)(void *)(s)
+#define ACPI_MOVE_16_TO_64(d, s)        *(u64 *)(void *)(d) = *(u16 *)(void *)(s)
 
 /* 32-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_32_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
-#define ACPI_MOVE_32_TO_32(d,s)         *(u32 *)(void *)(d) = *(u32 *)(void *)(s)
-#define ACPI_MOVE_32_TO_64(d,s)         *(u64 *)(void *)(d) = *(u32 *)(void *)(s)
+#define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
+#define ACPI_MOVE_32_TO_32(d, s)        *(u32 *)(void *)(d) = *(u32 *)(void *)(s)
+#define ACPI_MOVE_32_TO_64(d, s)        *(u64 *)(void *)(d) = *(u32 *)(void *)(s)
 
 /* 64-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_64_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
-#define ACPI_MOVE_64_TO_32(d,s)         ACPI_MOVE_32_TO_32(d,s)	/* Truncate to 32 */
-#define ACPI_MOVE_64_TO_64(d,s)         *(u64 *)(void *)(d) = *(u64 *)(void *)(s)
+#define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
+#define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
+#define ACPI_MOVE_64_TO_64(d, s)        *(u64 *)(void *)(d) = *(u64 *)(void *)(s)
 
 #else
 /*
- * The hardware does not support unaligned transfers.  We must move the
- * data one byte at a time.  These macros work whether the source or
+ * The hardware does not support unaligned transfers. We must move the
+ * data one byte at a time. These macros work whether the source or
  * the destination (or both) is/are unaligned.  (Little-endian move)
  */
 
 /* 16-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_16_TO_16(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+#define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
 										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];}
 
-#define ACPI_MOVE_16_TO_32(d,s)         {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d,s);}
-#define ACPI_MOVE_16_TO_64(d,s)         {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d,s);}
+#define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
+#define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_16_TO_16(d, s);}
 
 /* 32-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_32_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
+#define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
-#define ACPI_MOVE_32_TO_32(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+#define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
 										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
 										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
 										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];}
 
-#define ACPI_MOVE_32_TO_64(d,s)         {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d,s);}
+#define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d)) = 0; ACPI_MOVE_32_TO_32(d, s);}
 
 /* 64-bit source, 16/32/64 destination */
 
-#define ACPI_MOVE_64_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
-#define ACPI_MOVE_64_TO_32(d,s)         ACPI_MOVE_32_TO_32(d,s)	/* Truncate to 32 */
-#define ACPI_MOVE_64_TO_64(d,s)         {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
+#define ACPI_MOVE_64_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
+#define ACPI_MOVE_64_TO_32(d, s)        ACPI_MOVE_32_TO_32(d, s)	/* Truncate to 32 */
+#define ACPI_MOVE_64_TO_64(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[0];\
 										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[1];\
 										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[2];\
 										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[3];\
@@ -254,64 +246,52 @@ struct acpi_integer_overlay {
 #endif
 #endif
 
-/* Macros based on machine integer width */
-
-#if ACPI_MACHINE_WIDTH == 32
-#define ACPI_MOVE_SIZE_TO_16(d,s)       ACPI_MOVE_32_TO_16(d,s)
-
-#elif ACPI_MACHINE_WIDTH == 64
-#define ACPI_MOVE_SIZE_TO_16(d,s)       ACPI_MOVE_64_TO_16(d,s)
-
-#else
-#error unknown ACPI_MACHINE_WIDTH
-#endif
-
 /*
  * Fast power-of-two math macros for non-optimized compilers
  */
-#define _ACPI_DIV(value,power_of2)      ((u32) ((value) >> (power_of2)))
-#define _ACPI_MUL(value,power_of2)      ((u32) ((value) << (power_of2)))
-#define _ACPI_MOD(value,divisor)        ((u32) ((value) & ((divisor) -1)))
-
-#define ACPI_DIV_2(a)                   _ACPI_DIV(a,1)
-#define ACPI_MUL_2(a)                   _ACPI_MUL(a,1)
-#define ACPI_MOD_2(a)                   _ACPI_MOD(a,2)
-
-#define ACPI_DIV_4(a)                   _ACPI_DIV(a,2)
-#define ACPI_MUL_4(a)                   _ACPI_MUL(a,2)
-#define ACPI_MOD_4(a)                   _ACPI_MOD(a,4)
-
-#define ACPI_DIV_8(a)                   _ACPI_DIV(a,3)
-#define ACPI_MUL_8(a)                   _ACPI_MUL(a,3)
-#define ACPI_MOD_8(a)                   _ACPI_MOD(a,8)
-
-#define ACPI_DIV_16(a)                  _ACPI_DIV(a,4)
-#define ACPI_MUL_16(a)                  _ACPI_MUL(a,4)
-#define ACPI_MOD_16(a)                  _ACPI_MOD(a,16)
-
-#define ACPI_DIV_32(a)                  _ACPI_DIV(a,5)
-#define ACPI_MUL_32(a)                  _ACPI_MUL(a,5)
-#define ACPI_MOD_32(a)                  _ACPI_MOD(a,32)
+#define _ACPI_DIV(value, power_of2)     ((u32) ((value) >> (power_of2)))
+#define _ACPI_MUL(value, power_of2)     ((u32) ((value) << (power_of2)))
+#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) -1)))
+
+#define ACPI_DIV_2(a)                   _ACPI_DIV(a, 1)
+#define ACPI_MUL_2(a)                   _ACPI_MUL(a, 1)
+#define ACPI_MOD_2(a)                   _ACPI_MOD(a, 2)
+
+#define ACPI_DIV_4(a)                   _ACPI_DIV(a, 2)
+#define ACPI_MUL_4(a)                   _ACPI_MUL(a, 2)
+#define ACPI_MOD_4(a)                   _ACPI_MOD(a, 4)
+
+#define ACPI_DIV_8(a)                   _ACPI_DIV(a, 3)
+#define ACPI_MUL_8(a)                   _ACPI_MUL(a, 3)
+#define ACPI_MOD_8(a)                   _ACPI_MOD(a, 8)
+
+#define ACPI_DIV_16(a)                  _ACPI_DIV(a, 4)
+#define ACPI_MUL_16(a)                  _ACPI_MUL(a, 4)
+#define ACPI_MOD_16(a)                  _ACPI_MOD(a, 16)
+
+#define ACPI_DIV_32(a)                  _ACPI_DIV(a, 5)
+#define ACPI_MUL_32(a)                  _ACPI_MUL(a, 5)
+#define ACPI_MOD_32(a)                  _ACPI_MOD(a, 32)
 
 /*
  * Rounding macros (Power of two boundaries only)
  */
-#define ACPI_ROUND_DOWN(value,boundary)     (((acpi_size)(value)) & \
+#define ACPI_ROUND_DOWN(value, boundary)    (((acpi_size)(value)) & \
 												(~(((acpi_size) boundary)-1)))
 
-#define ACPI_ROUND_UP(value,boundary)       ((((acpi_size)(value)) + \
+#define ACPI_ROUND_UP(value, boundary)      ((((acpi_size)(value)) + \
 												(((acpi_size) boundary)-1)) & \
 												(~(((acpi_size) boundary)-1)))
 
 /* Note: sizeof(acpi_size) evaluates to either 4 or 8 (32- vs 64-bit mode) */
 
-#define ACPI_ROUND_DOWN_TO_32BIT(a)         ACPI_ROUND_DOWN(a,4)
-#define ACPI_ROUND_DOWN_TO_64BIT(a)         ACPI_ROUND_DOWN(a,8)
-#define ACPI_ROUND_DOWN_TO_NATIVE_WORD(a)   ACPI_ROUND_DOWN(a,sizeof(acpi_size))
-
-#define ACPI_ROUND_UP_TO_32BIT(a)           ACPI_ROUND_UP(a,4)
-#define ACPI_ROUND_UP_TO_64BIT(a)           ACPI_ROUND_UP(a,8)
-#define ACPI_ROUND_UP_TO_NATIVE_WORD(a)     ACPI_ROUND_UP(a,sizeof(acpi_size))
+#define ACPI_ROUND_DOWN_TO_32BIT(a)         ACPI_ROUND_DOWN(a, 4)
+#define ACPI_ROUND_DOWN_TO_64BIT(a)         ACPI_ROUND_DOWN(a, 8)
+#define ACPI_ROUND_DOWN_TO_NATIVE_WORD(a)   ACPI_ROUND_DOWN(a, sizeof(acpi_size))
+
+#define ACPI_ROUND_UP_TO_32BIT(a)           ACPI_ROUND_UP(a, 4)
+#define ACPI_ROUND_UP_TO_64BIT(a)           ACPI_ROUND_UP(a, 8)
+#define ACPI_ROUND_UP_TO_NATIVE_WORD(a)     ACPI_ROUND_UP(a, sizeof(acpi_size))
 
 #define ACPI_ROUND_BITS_UP_TO_BYTES(a)      ACPI_DIV_8((a) + 7)
 #define ACPI_ROUND_BITS_DOWN_TO_BYTES(a)    ACPI_DIV_8((a))
@@ -320,9 +300,9 @@ struct acpi_integer_overlay {
 
 /* Generic (non-power-of-two) rounding */
 
-#define ACPI_ROUND_UP_TO(value,boundary)    (((value) + ((boundary)-1)) / (boundary))
+#define ACPI_ROUND_UP_TO(value, boundary)   (((value) + ((boundary)-1)) / (boundary))
 
-#define ACPI_IS_MISALIGNED(value)           (((acpi_size)value) & (sizeof(acpi_size)-1))
+#define ACPI_IS_MISALIGNED(value)           (((acpi_size) value) & (sizeof(acpi_size)-1))
 
 /*
  * Bitmask creation
@@ -333,8 +313,6 @@ struct acpi_integer_overlay {
 #define ACPI_MASK_BITS_ABOVE(position)      (~((ACPI_INTEGER_MAX) << ((u32) (position))))
 #define ACPI_MASK_BITS_BELOW(position)      ((ACPI_INTEGER_MAX) << ((u32) (position)))
 
-#define ACPI_IS_OCTAL_DIGIT(d)              (((char)(d) >= '0') && ((char)(d) <= '7'))
-
 /* Bitfields within ACPI registers */
 
 #define ACPI_REGISTER_PREPARE_BITS(val, pos, mask)      ((val << pos) & mask)
@@ -342,39 +320,29 @@ struct acpi_integer_overlay {
 
 #define ACPI_INSERT_BITS(target, mask, source)          target = ((target & (~(mask))) | (source & mask))
 
-/* Generate a UUID */
-
-#define ACPI_INIT_UUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
-	(a) & 0xFF, ((a) >> 8) & 0xFF, ((a) >> 16) & 0xFF, ((a) >> 24) & 0xFF, \
-	(b) & 0xFF, ((b) >> 8) & 0xFF, \
-	(c) & 0xFF, ((c) >> 8) & 0xFF, \
-	(d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7)
-
 /*
- * An struct acpi_namespace_node * can appear in some contexts,
- * where a pointer to an union acpi_operand_object    can also
- * appear.  This macro is used to distinguish them.
+ * An struct acpi_namespace_node can appear in some contexts
+ * where a pointer to an union acpi_operand_object can also
+ * appear. This macro is used to distinguish them.
  *
  * The "Descriptor" field is the first field in both structures.
  */
 #define ACPI_GET_DESCRIPTOR_TYPE(d)     (((union acpi_descriptor *)(void *)(d))->common.descriptor_type)
-#define ACPI_SET_DESCRIPTOR_TYPE(d,t)   (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = t)
+#define ACPI_SET_DESCRIPTOR_TYPE(d, t)  (((union acpi_descriptor *)(void *)(d))->common.descriptor_type = t)
 
 /* Macro to test the object type */
 
 #define ACPI_GET_OBJECT_TYPE(d)         (((union acpi_operand_object *)(void *)(d))->common.type)
 
-/* Macro to check the table flags for SINGLE or MULTIPLE tables are allowed */
-
-#define ACPI_IS_SINGLE_TABLE(x)         (((x) & 0x01) == ACPI_TABLE_SINGLE ? 1 : 0)
-
 /*
  * Macros for the master AML opcode table
  */
-#if defined(ACPI_DISASSEMBLER) || defined (ACPI_DEBUG_OUTPUT)
-#define ACPI_OP(name,Pargs,Iargs,obj_type,class,type,flags)    {name,(u32)(Pargs),(u32)(Iargs),(u32)(flags),obj_type,class,type}
+#if defined (ACPI_DISASSEMBLER) || defined (ACPI_DEBUG_OUTPUT)
+#define ACPI_OP(name, Pargs, Iargs, obj_type, class, type, flags) \
+	{name, (u32)(Pargs), (u32)(Iargs), (u32)(flags), obj_type, class, type}
 #else
-#define ACPI_OP(name,Pargs,Iargs,obj_type,class,type,flags)    {(u32)(Pargs),(u32)(Iargs),(u32)(flags),obj_type,class,type}
+#define ACPI_OP(name, Pargs, Iargs, obj_type, class, type, flags) \
+	{(u32)(Pargs), (u32)(Iargs), (u32)(flags), obj_type, class, type}
 #endif
 
 #ifdef ACPI_DISASSEMBLER
@@ -392,18 +360,18 @@ struct acpi_integer_overlay {
 #define ARG_6(x)                        ((u32)(x) << (5 * ARG_TYPE_WIDTH))
 
 #define ARGI_LIST1(a)                   (ARG_1(a))
-#define ARGI_LIST2(a,b)                 (ARG_1(b)|ARG_2(a))
-#define ARGI_LIST3(a,b,c)               (ARG_1(c)|ARG_2(b)|ARG_3(a))
-#define ARGI_LIST4(a,b,c,d)             (ARG_1(d)|ARG_2(c)|ARG_3(b)|ARG_4(a))
-#define ARGI_LIST5(a,b,c,d,e)           (ARG_1(e)|ARG_2(d)|ARG_3(c)|ARG_4(b)|ARG_5(a))
-#define ARGI_LIST6(a,b,c,d,e,f)         (ARG_1(f)|ARG_2(e)|ARG_3(d)|ARG_4(c)|ARG_5(b)|ARG_6(a))
+#define ARGI_LIST2(a, b)                (ARG_1(b)|ARG_2(a))
+#define ARGI_LIST3(a, b, c)             (ARG_1(c)|ARG_2(b)|ARG_3(a))
+#define ARGI_LIST4(a, b, c, d)          (ARG_1(d)|ARG_2(c)|ARG_3(b)|ARG_4(a))
+#define ARGI_LIST5(a, b, c, d, e)       (ARG_1(e)|ARG_2(d)|ARG_3(c)|ARG_4(b)|ARG_5(a))
+#define ARGI_LIST6(a, b, c, d, e, f)    (ARG_1(f)|ARG_2(e)|ARG_3(d)|ARG_4(c)|ARG_5(b)|ARG_6(a))
 
 #define ARGP_LIST1(a)                   (ARG_1(a))
-#define ARGP_LIST2(a,b)                 (ARG_1(a)|ARG_2(b))
-#define ARGP_LIST3(a,b,c)               (ARG_1(a)|ARG_2(b)|ARG_3(c))
-#define ARGP_LIST4(a,b,c,d)             (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d))
-#define ARGP_LIST5(a,b,c,d,e)           (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d)|ARG_5(e))
-#define ARGP_LIST6(a,b,c,d,e,f)         (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d)|ARG_5(e)|ARG_6(f))
+#define ARGP_LIST2(a, b)                (ARG_1(a)|ARG_2(b))
+#define ARGP_LIST3(a, b, c)             (ARG_1(a)|ARG_2(b)|ARG_3(c))
+#define ARGP_LIST4(a, b, c, d)          (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d))
+#define ARGP_LIST5(a, b, c, d, e)       (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d)|ARG_5(e))
+#define ARGP_LIST6(a, b, c, d, e, f)    (ARG_1(a)|ARG_2(b)|ARG_3(c)|ARG_4(d)|ARG_5(e)|ARG_6(f))
 
 #define GET_CURRENT_ARG_TYPE(list)      (list & ((u32) 0x1F))
 #define INCREMENT_ARG_LIST(list)        (list >>= ((u32) ARG_TYPE_WIDTH))
@@ -434,8 +402,8 @@ struct acpi_integer_overlay {
 #define ACPI_WARNING(plist)             acpi_ut_warning plist
 #define ACPI_EXCEPTION(plist)           acpi_ut_exception plist
 #define ACPI_ERROR(plist)               acpi_ut_error plist
-#define ACPI_ERROR_NAMESPACE(s,e)       acpi_ns_report_error (AE_INFO, s, e);
-#define ACPI_ERROR_METHOD(s,n,p,e)      acpi_ns_report_method_error (AE_INFO, s, n, p, e);
+#define ACPI_ERROR_NAMESPACE(s, e)      acpi_ns_report_error (AE_INFO, s, e);
+#define ACPI_ERROR_METHOD(s, n, p, e)   acpi_ns_report_method_error (AE_INFO, s, n, p, e);
 
 #else
 
@@ -445,8 +413,8 @@ struct acpi_integer_overlay {
 #define ACPI_WARNING(plist)
 #define ACPI_EXCEPTION(plist)
 #define ACPI_ERROR(plist)
-#define ACPI_ERROR_NAMESPACE(s,e)
-#define ACPI_ERROR_METHOD(s,n,p,e)
+#define ACPI_ERROR_NAMESPACE(s, e)
+#define ACPI_ERROR_METHOD(s, n, p, e)
 #endif
 
 /*
@@ -487,18 +455,18 @@ struct acpi_integer_overlay {
 
 #define ACPI_FUNCTION_TRACE(a)          ACPI_FUNCTION_NAME(a) \
 			  acpi_ut_trace(ACPI_DEBUG_PARAMETERS)
-#define ACPI_FUNCTION_TRACE_PTR(a,b)    ACPI_FUNCTION_NAME(a) \
-					   acpi_ut_trace_ptr(ACPI_DEBUG_PARAMETERS,(void *)b)
-#define ACPI_FUNCTION_TRACE_U32(a,b)    ACPI_FUNCTION_NAME(a) \
-							 acpi_ut_trace_u32(ACPI_DEBUG_PARAMETERS,(u32)b)
-#define ACPI_FUNCTION_TRACE_STR(a,b)    ACPI_FUNCTION_NAME(a) \
-									  acpi_ut_trace_str(ACPI_DEBUG_PARAMETERS,(char *)b)
+#define ACPI_FUNCTION_TRACE_PTR(a, b)   ACPI_FUNCTION_NAME(a) \
+					   acpi_ut_trace_ptr(ACPI_DEBUG_PARAMETERS, (void *)b)
+#define ACPI_FUNCTION_TRACE_U32(a, b)   ACPI_FUNCTION_NAME(a) \
+							 acpi_ut_trace_u32(ACPI_DEBUG_PARAMETERS, (u32)b)
+#define ACPI_FUNCTION_TRACE_STR(a, b)   ACPI_FUNCTION_NAME(a) \
+									  acpi_ut_trace_str(ACPI_DEBUG_PARAMETERS, (char *)b)
 
 #define ACPI_FUNCTION_ENTRY()           acpi_ut_track_stack_ptr()
 
 /*
  * Function exit tracing.
- * WARNING: These macros include a return statement.  This is usually considered
+ * WARNING: These macros include a return statement. This is usually considered
  * bad form, but having a separate exit macro is very ugly and difficult to maintain.
  * One of the FUNCTION_TRACE macros above must be used in conjunction with these macros
  * so that "_AcpiFunctionName" is defined.
@@ -565,21 +533,16 @@ struct acpi_integer_overlay {
 /* Conditional execution */
 
 #define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_NORMAL_EXEC(a)
-
-#define ACPI_DEBUG_DEFINE(a)            a;
 #define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
 #define _VERBOSE_STRUCTURES
 
-/* Stack and buffer dumping */
+/* Various object display routines for debug */
 
-#define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a),0)
-#define ACPI_DUMP_OPERANDS(a,b,c)       acpi_ex_dump_operands(a,b,c)
-
-#define ACPI_DUMP_ENTRY(a,b)            acpi_ns_dump_entry (a,b)
-#define ACPI_DUMP_PATHNAME(a,b,c,d)     acpi_ns_dump_pathname(a,b,c,d)
-#define ACPI_DUMP_RESOURCE_LIST(a)      acpi_rs_dump_resource_list(a)
-#define ACPI_DUMP_BUFFER(a,b)           acpi_ut_dump_buffer((u8 *)a,b,DB_BYTE_DISPLAY,_COMPONENT)
+#define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a), 0)
+#define ACPI_DUMP_OPERANDS(a, b ,c)     acpi_ex_dump_operands(a, b, c)
+#define ACPI_DUMP_ENTRY(a, b)           acpi_ns_dump_entry (a, b)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)  acpi_ns_dump_pathname(a, b, c, d)
+#define ACPI_DUMP_BUFFER(a, b)          acpi_ut_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
 
 /*
  * Master debug print macros
@@ -596,26 +559,22 @@ struct acpi_integer_overlay {
  * leaving no executable debug code!
  */
 #define ACPI_DEBUG_EXEC(a)
-#define ACPI_NORMAL_EXEC(a)             a;
-
-#define ACPI_DEBUG_DEFINE(a)
 #define ACPI_DEBUG_ONLY_MEMBERS(a)
 #define ACPI_FUNCTION_NAME(a)
 #define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a,b)
-#define ACPI_FUNCTION_TRACE_U32(a,b)
-#define ACPI_FUNCTION_TRACE_STR(a,b)
+#define ACPI_FUNCTION_TRACE_PTR(a, b)
+#define ACPI_FUNCTION_TRACE_U32(a, b)
+#define ACPI_FUNCTION_TRACE_STR(a, b)
 #define ACPI_FUNCTION_EXIT
 #define ACPI_FUNCTION_STATUS_EXIT(s)
 #define ACPI_FUNCTION_VALUE_EXIT(s)
 #define ACPI_FUNCTION_ENTRY()
 #define ACPI_DUMP_STACK_ENTRY(a)
-#define ACPI_DUMP_OPERANDS(a,b,c)
-#define ACPI_DUMP_ENTRY(a,b)
-#define ACPI_DUMP_TABLES(a,b)
-#define ACPI_DUMP_PATHNAME(a,b,c,d)
-#define ACPI_DUMP_RESOURCE_LIST(a)
-#define ACPI_DUMP_BUFFER(a,b)
+#define ACPI_DUMP_OPERANDS(a, b, c)
+#define ACPI_DUMP_ENTRY(a, b)
+#define ACPI_DUMP_TABLES(a, b)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)
+#define ACPI_DUMP_BUFFER(a, b)
 #define ACPI_DEBUG_PRINT(pl)
 #define ACPI_DEBUG_PRINT_RAW(pl)
 
@@ -639,27 +598,17 @@ struct acpi_integer_overlay {
 #define ACPI_DEBUGGER_EXEC(a)
 #endif
 
-#ifdef ACPI_DEBUG_OUTPUT
-/*
- * 1) Set name to blanks
- * 2) Copy the object name
- */
-#define ACPI_ADD_OBJECT_NAME(a,b)       ACPI_MEMSET (a->common.name, ' ', sizeof (a->common.name));\
-										ACPI_STRNCPY (a->common.name, acpi_gbl_ns_type_names[b], sizeof (a->common.name))
-#else
-
-#define ACPI_ADD_OBJECT_NAME(a,b)
-#endif
-
 /*
  * Memory allocation tracking (DEBUG ONLY)
  */
+#define ACPI_MEM_PARAMETERS         _COMPONENT, _acpi_module_name, __LINE__
+
 #ifndef ACPI_DBG_TRACK_ALLOCATIONS
 
 /* Memory allocation */
 
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size)(a),_COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size)(a), _COMPONENT,_acpi_module_name,__LINE__)
+#define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size) (a), ACPI_MEM_PARAMETERS)
 #define ACPI_FREE(a)                acpi_os_free(a)
 #define ACPI_MEM_TRACKING(a)
 
@@ -667,11 +616,25 @@ struct acpi_integer_overlay {
 
 /* Memory allocation */
 
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate_and_track((acpi_size)(a),_COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed_and_track((acpi_size)(a), _COMPONENT,_acpi_module_name,__LINE__)
-#define ACPI_FREE(a)                acpi_ut_free_and_track(a,_COMPONENT,_acpi_module_name,__LINE__)
+#define ACPI_ALLOCATE(a)            acpi_ut_allocate_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_FREE(a)                acpi_ut_free_and_track(a, ACPI_MEM_PARAMETERS)
 #define ACPI_MEM_TRACKING(a)        a
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
+/*
+ * Macros used for ACPICA utilities only
+ */
+
+/* Generate a UUID */
+
+#define ACPI_INIT_UUID(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7) \
+	(a) & 0xFF, ((a) >> 8) & 0xFF, ((a) >> 16) & 0xFF, ((a) >> 24) & 0xFF, \
+	(b) & 0xFF, ((b) >> 8) & 0xFF, \
+	(c) & 0xFF, ((c) >> 8) & 0xFF, \
+	(d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7)
+
+#define ACPI_IS_OCTAL_DIGIT(d)              (((char)(d) >= '0') && ((char)(d) <= '7'))
+
 #endif				/* ACMACROS_H */

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 2/15] ACPICA: Copy dynamically loaded tables to local buffer
From: Bob Moore <robert.moore@intel.com>
Date: Wed Jun 11 15:23:20 2008 -0700

Previously, dynamically loaded tables were simply mapped, but
on some machines this memory is corrupted after suspend. Now
copy the table to a local buffer. For OpRegion case, added
checksum verify. Use the table length from the table header,
not the region length. For Buffer case, use the table length
also. Dennis Noordsij, Bob Moore. BZ 10734

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 exconfig.c |  112 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 31 deletions(-)

diff -Nurp original.linux/drivers/acpi/executer/exconfig.c new.linux/drivers/acpi/executer/exconfig.c
--- original.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:23:00.000000000 +0800
+++ new.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:23:07.000000000 +0800
@@ -279,6 +279,7 @@ acpi_ex_load_op(union acpi_operand_objec
 		struct acpi_walk_state *walk_state)
 {
 	union acpi_operand_object *ddb_handle;
+	struct acpi_table_header *table;
 	struct acpi_table_desc table_desc;
 	u32 table_index;
 	acpi_status status;
@@ -293,9 +294,8 @@ acpi_ex_load_op(union acpi_operand_objec
 	switch (ACPI_GET_OBJECT_TYPE(obj_desc)) {
 	case ACPI_TYPE_REGION:
 
-		ACPI_DEBUG_PRINT((ACPI_DB_EXEC, "Load from Region %p %s\n",
-				  obj_desc,
-				  acpi_ut_get_object_type_name(obj_desc)));
+		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
+				  "Load table from Region %p\n", obj_desc));
 
 		/* Region must be system_memory (from ACPI spec) */
 
@@ -315,61 +315,111 @@ acpi_ex_load_op(union acpi_operand_objec
 		}
 
 		/*
-		 * We will simply map the memory region for the table. However, the
-		 * memory region is technically not guaranteed to remain stable and
-		 * we may eventually have to copy the table to a local buffer.
+		 * Map the table header and get the actual table length. The region
+		 * length is not guaranteed to be the same as the table length.
+		 */
+		table = acpi_os_map_memory(obj_desc->region.address,
+					   sizeof(struct acpi_table_header));
+		if (!table) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
+
+		length = table->length;
+		acpi_os_unmap_memory(table, sizeof(struct acpi_table_header));
+
+		/* Must have at least an ACPI table header */
+
+		if (length < sizeof(struct acpi_table_header)) {
+			return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
+		}
+
+		/*
+		 * The memory region is not guaranteed to remain stable and we must
+		 * copy the table to a local buffer. For example, the memory region
+		 * is corrupted after suspend on some machines. Dynamically loaded
+		 * tables are usually small, so this overhead is minimal.
 		 */
+
+		/* Allocate a buffer for the table */
+
+		table_desc.pointer = ACPI_ALLOCATE(length);
+		if (!table_desc.pointer) {
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
+
+		/* Map the entire table and copy it */
+
+		table = acpi_os_map_memory(obj_desc->region.address, length);
+		if (!table) {
+			ACPI_FREE(table_desc.pointer);
+			return_ACPI_STATUS(AE_NO_MEMORY);
+		}
+
+		ACPI_MEMCPY(table_desc.pointer, table, length);
+		acpi_os_unmap_memory(table, length);
+
 		table_desc.address = obj_desc->region.address;
-		table_desc.length = obj_desc->region.length;
-		table_desc.flags = ACPI_TABLE_ORIGIN_MAPPED;
 		break;
 
 	case ACPI_TYPE_BUFFER:	/* Buffer or resolved region_field */
 
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
-				  "Load from Buffer or Field %p %s\n", obj_desc,
-				  acpi_ut_get_object_type_name(obj_desc)));
-
-		length = obj_desc->buffer.length;
+				  "Load table from Buffer or Field %p\n",
+				  obj_desc));
 
 		/* Must have at least an ACPI table header */
 
-		if (length < sizeof(struct acpi_table_header)) {
+		if (obj_desc->buffer.length < sizeof(struct acpi_table_header)) {
 			return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
 		}
 
-		/* Validate checksum here. It won't get validated in tb_add_table */
+		/* Get the actual table length from the table header */
 
-		status =
-		    acpi_tb_verify_checksum(ACPI_CAST_PTR
-					    (struct acpi_table_header,
-					     obj_desc->buffer.pointer), length);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
+		table =
+		    ACPI_CAST_PTR(struct acpi_table_header,
+				  obj_desc->buffer.pointer);
+		length = table->length;
+
+		/* Table cannot extend beyond the buffer */
+
+		if (length > obj_desc->buffer.length) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
+		}
+		if (length < sizeof(struct acpi_table_header)) {
+			return_ACPI_STATUS(AE_INVALID_TABLE_LENGTH);
 		}
 
 		/*
-		 * We need to copy the buffer since the original buffer could be
-		 * changed or deleted in the future
+		 * Copy the table from the buffer because the buffer could be modified
+		 * or even deleted in the future
 		 */
 		table_desc.pointer = ACPI_ALLOCATE(length);
 		if (!table_desc.pointer) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
 
-		ACPI_MEMCPY(table_desc.pointer, obj_desc->buffer.pointer,
-			    length);
-		table_desc.length = length;
-		table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+		ACPI_MEMCPY(table_desc.pointer, table, length);
 		break;
 
 	default:
 		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 	}
 
-	/*
-	 * Install the new table into the local data structures
-	 */
+	/* Validate table checksum (will not get validated in tb_add_table) */
+
+	status = acpi_tb_verify_checksum(table_desc.pointer, length);
+	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(table_desc.pointer);
+		return_ACPI_STATUS(status);
+	}
+
+	/* Complete the table descriptor */
+
+	table_desc.length = length;
+	table_desc.flags = ACPI_TABLE_ORIGIN_ALLOCATED;
+
+	/* Install the new table into the local data structures */
+
 	status = acpi_tb_add_table(&table_desc, &table_index);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
@@ -378,7 +428,7 @@ acpi_ex_load_op(union acpi_operand_objec
 	/*
 	 * Add the table to the namespace.
 	 *
-	 * Note: We load the table objects relative to the root of the namespace.
+	 * Note: Load the table objects relative to the root of the namespace.
 	 * This appears to go against the ACPI specification, but we do it for
 	 * compatibility with other ACPI implementations.
 	 */
@@ -414,7 +464,7 @@ acpi_ex_load_op(union acpi_operand_objec
       cleanup:
 	if (ACPI_FAILURE(status)) {
 
-		/* Delete allocated buffer or mapping */
+		/* Delete allocated table buffer */
 
 		acpi_tb_delete_table(&table_desc);
 	}

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 3/15] ACPICA: AcpiExec: Add support for dynamic table load/unload
From: Bob Moore <robert.moore@intel.com>
Date: Fri Jun 13 13:46:31 2008 -0700

Now calls _CFG method to pass address of table to the AML. Added
option to disable opregion simulation to allow creation of
opregion with real address that was passed to _CFG. All of this
allows testing of the Load and Unload operators from AcpiExec.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 acglobal.h |    1 +
 1 file changed, 1 insertion(+)

diff -Nurp original.linux/include/acpi/acglobal.h new.linux/include/acpi/acglobal.h
--- original.linux/include/acpi/acglobal.h	2008-07-04 09:23:14.000000000 +0800
+++ new.linux/include/acpi/acglobal.h	2008-07-04 09:23:21.000000000 +0800
@@ -356,6 +356,7 @@ ACPI_EXTERN char *optarg;
 ACPI_EXTERN u8 acpi_gbl_db_opt_tables;
 ACPI_EXTERN u8 acpi_gbl_db_opt_stats;
 ACPI_EXTERN u8 acpi_gbl_db_opt_ini_methods;
+ACPI_EXTERN u8 acpi_gbl_db_opt_no_region_support;
 
 ACPI_EXTERN char *acpi_gbl_db_args[ACPI_DEBUGGER_MAX_ARGS];
 ACPI_EXTERN char acpi_gbl_db_line_buf[80];

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 4/15] ACPICA: Fix warning for 64-bit build
From: Bob Moore <robert.moore@intel.com>
Date: Fri Jun 13 13:54:15 2008 -0700

Fixes warning from exconfig.c on 64-bit build.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 exconfig.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -Nurp original.linux/drivers/acpi/executer/exconfig.c new.linux/drivers/acpi/executer/exconfig.c
--- original.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:23:21.000000000 +0800
+++ new.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:23:28.000000000 +0800
@@ -96,7 +96,7 @@ acpi_ex_add_table(u32 table_index,
 
 	/* Install the new table into the local data structures */
 
-	obj_desc->reference.object = ACPI_CAST_PTR(void, table_index);
+	obj_desc->reference.object = ACPI_TO_POINTER(table_index);
 
 	/* Add the table to the namespace */
 
@@ -399,6 +399,7 @@ acpi_ex_load_op(union acpi_operand_objec
 		}
 
 		ACPI_MEMCPY(table_desc.pointer, table, length);
+		table_desc.address = ACPI_TO_INTEGER(table_desc.pointer);
 		break;
 
 	default:

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 5/15] ACPICA: Add check for invalid handle in AcpiGetObjectInfo
From: Bob Moore <robert.moore@intel.com>
Date: Tue Jun 17 14:53:35 2008 -0700

Return AE_BAD_PARAMETER if input handle is invalid. BZ 474

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 nsxfname.c |    1 +
 1 file changed, 1 insertion(+)

diff -Nurp original.linux/drivers/acpi/namespace/nsxfname.c new.linux/drivers/acpi/namespace/nsxfname.c
--- original.linux/drivers/acpi/namespace/nsxfname.c	2008-07-04 09:23:41.000000000 +0800
+++ new.linux/drivers/acpi/namespace/nsxfname.c	2008-07-04 09:23:48.000000000 +0800
@@ -252,6 +252,7 @@ acpi_status acpi_get_object_info(acpi_ha
 	node = acpi_ns_map_handle_to_node(handle);
 	if (!node) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		status = AE_BAD_PARAMETER;
 		goto cleanup;
 	}
 

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 6/15] ACPICA: Implement careful GPE disable, only change one enable bit
From: Bob Moore <robert.moore@intel.com>
Date: Tue Jun 17 15:13:13 2008 -0700

We now perform a read-change-write of the enable register instead
of simply writing out the cached enable mask. This will prevent
inadvertent enabling of GPEs if a rogue GPE is received during
initialization (before GPE handlers are installed.)

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 drivers/acpi/events/evgpe.c    |   25 +++++++++++----------
 drivers/acpi/hardware/hwgpe.c  |   48 +++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/hardware/hwregs.c |    4 +--
 include/acpi/achware.h         |    2 +
 4 files changed, 66 insertions(+), 13 deletions(-)

diff -Nurp original.linux/drivers/acpi/events/evgpe.c new.linux/drivers/acpi/events/evgpe.c
--- original.linux/drivers/acpi/events/evgpe.c	2008-07-04 09:23:48.000000000 +0800
+++ new.linux/drivers/acpi/events/evgpe.c	2008-07-04 09:23:55.000000000 +0800
@@ -264,14 +264,16 @@ acpi_status acpi_ev_disable_gpe(struct a
 		return_ACPI_STATUS(status);
 	}
 
-	/* Mark wake-disabled or HW disable, or both */
+	/* Clear the appropriate enabled flags for this GPE */
 
 	switch (gpe_event_info->flags & ACPI_GPE_TYPE_MASK) {
 	case ACPI_GPE_TYPE_WAKE:
+
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_WAKE_ENABLED);
 		break;
 
 	case ACPI_GPE_TYPE_WAKE_RUN:
+
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_WAKE_ENABLED);
 
 		/*lint -fallthrough */
@@ -281,21 +283,22 @@ acpi_status acpi_ev_disable_gpe(struct a
 		/* Disable the requested runtime GPE */
 
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
-
-		/*lint -fallthrough */
+		break;
 
 	default:
-		/*
-		 * If we don't know the GPE type, make sure that we always
-		 * disable it. This can prevent a certain type of GPE flood, where
-		 * the GPE has no _Lxx/_Exx method, and it cannot be determined
-		 * whether the GPE is wake, run, or wake/run.
-		 */
-		status = acpi_hw_write_gpe_enable_reg(gpe_event_info);
 		break;
 	}
 
-	return_ACPI_STATUS(AE_OK);
+	/*
+	 * Always H/W disable this GPE, even if we don't know the GPE type.
+	 * Simply clear the enable bit for this particular GPE, but do not
+	 * write out the current GPE enable mask since this may inadvertently
+	 * enable GPEs too early. An example is a rogue GPE that has arrived
+	 * during ACPICA initialization - possibly because AML or other code
+	 * has enabled the GPE.
+	 */
+	status = acpi_hw_low_disable_gpe(gpe_event_info);
+	return_ACPI_STATUS(status);
 }
 
 /*******************************************************************************
diff -Nurp original.linux/drivers/acpi/hardware/hwgpe.c new.linux/drivers/acpi/hardware/hwgpe.c
--- original.linux/drivers/acpi/hardware/hwgpe.c	2008-07-04 09:23:48.000000000 +0800
+++ new.linux/drivers/acpi/hardware/hwgpe.c	2008-07-04 09:23:55.000000000 +0800
@@ -55,6 +55,54 @@ acpi_hw_enable_wakeup_gpe_block(struct a
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_low_disable_gpe
+ *
+ * PARAMETERS:  gpe_event_info      - Info block for the GPE to be disabled
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Disable a single GPE in the enable register.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_status status;
+	u32 enable_mask;
+
+	/* Get the info block for the entire GPE register */
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		return (AE_NOT_EXIST);
+	}
+
+	/* Get current value of the enable register that contains this GPE */
+
+	status = acpi_hw_low_level_read(ACPI_GPE_REGISTER_WIDTH, &enable_mask,
+					&gpe_register_info->enable_address);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Clear just the bit that corresponds to this GPE */
+
+	ACPI_CLEAR_BIT(enable_mask,
+		       ((u32) 1 <<
+			(gpe_event_info->gpe_number -
+			 gpe_register_info->base_gpe_number)));
+
+	/* Write the updated enable mask */
+
+	status = acpi_hw_low_level_write(ACPI_GPE_REGISTER_WIDTH, enable_mask,
+					 &gpe_register_info->enable_address);
+
+	return (status);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_write_gpe_enable_reg
  *
  * PARAMETERS:  gpe_event_info      - Info block for the GPE to be enabled
diff -Nurp original.linux/drivers/acpi/hardware/hwregs.c new.linux/drivers/acpi/hardware/hwregs.c
--- original.linux/drivers/acpi/hardware/hwregs.c	2008-07-04 09:23:48.000000000 +0800
+++ new.linux/drivers/acpi/hardware/hwregs.c	2008-07-04 09:23:55.000000000 +0800
@@ -254,7 +254,7 @@ struct acpi_bit_register_info *acpi_hw_g
  * RETURN:      Status and the value read from specified Register. Value
  *              returned is normalized to bit0 (is shifted all the way right)
  *
- * DESCRIPTION: ACPI bit_register read function.
+ * DESCRIPTION: ACPI bit_register read function. Does not acquire the HW lock.
  *
  ******************************************************************************/
 
@@ -319,7 +319,7 @@ acpi_status acpi_get_register(u32 regist
 	status = acpi_get_register_unlocked(register_id, return_value);
 	acpi_os_release_lock(acpi_gbl_hardware_lock, flags);
 
-	return status;
+	return (status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_register)
diff -Nurp original.linux/include/acpi/achware.h new.linux/include/acpi/achware.h
--- original.linux/include/acpi/achware.h	2008-07-04 09:23:48.000000000 +0800
+++ new.linux/include/acpi/achware.h	2008-07-04 09:23:55.000000000 +0800
@@ -86,6 +86,8 @@ acpi_status acpi_hw_clear_acpi_status(vo
 /*
  * hwgpe - GPE support
  */
+acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
 

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 7/15] ACPICA: Update FreeBSD-specific header
From: Bob Moore <robert.moore@intel.com>
Date: Tue Jun 17 15:37:41 2008 -0700

Changes received from FreeBSD team.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 acfreebsd.h |    2 --
 1 file changed, 2 deletions(-)

diff -Nurp original.linux/include/acpi/platform/acfreebsd.h new.linux/include/acpi/platform/acfreebsd.h
--- original.linux/include/acpi/platform/acfreebsd.h	2008-07-04 09:23:55.000000000 +0800
+++ new.linux/include/acpi/platform/acfreebsd.h	2008-07-04 09:24:02.000000000 +0800
@@ -50,7 +50,6 @@
 #include <sys/types.h>
 #include <machine/acpica_machdep.h>
 
-#define acpi_thread_id                          uintptr_t
 #define acpi_uintptr_t                          uintptr_t
 #define ACPI_USE_LOCAL_CACHE
 #define __cdecl
@@ -102,7 +101,6 @@
 /* Always use free_bSD code over our local versions */
 #define ACPI_USE_SYSTEM_CLIBRARY
 
-+
 #if defined(_KERNEL) && (__free_bSD_version < 700020)
 /* Or strstr (used in debugging mode, also move to libkern) */
 static __inline char *strstr(char *s, char *find)

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 8/15] ACPICA: Fix memory leak when deleting thermal/processor objects
From: Bob Moore <robert.moore@intel.com>
Date: Wed Jun 18 13:16:33 2008 -0700

Fixes a possible memory leak when thermal and processor objects
are deleted. Any associated notify handlers (and objects) were
not being deleted. Fiodor Suietov. BZ 506

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 utdelete.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff -Nurp original.linux/drivers/acpi/utilities/utdelete.c new.linux/drivers/acpi/utilities/utdelete.c
--- original.linux/drivers/acpi/utilities/utdelete.c	2008-07-04 09:24:02.000000000 +0800
+++ new.linux/drivers/acpi/utilities/utdelete.c	2008-07-04 09:24:08.000000000 +0800
@@ -135,6 +135,10 @@ static void acpi_ut_delete_internal_obj(
 		obj_pointer = object->package.elements;
 		break;
 
+		/*
+		 * These objects have a possible list of notify handlers.
+		 * Device object also may have a GPE block.
+		 */
 	case ACPI_TYPE_DEVICE:
 
 		if (object->device.gpe_block) {
@@ -142,9 +146,14 @@ static void acpi_ut_delete_internal_obj(
 						       gpe_block);
 		}
 
-		/* Walk the handler list for this device */
+		/*lint -fallthrough */
+
+	case ACPI_TYPE_PROCESSOR:
+	case ACPI_TYPE_THERMAL:
+
+		/* Walk the notify handler list for this object */
 
-		handler_desc = object->device.handler;
+		handler_desc = object->common_notify.handler;
 		while (handler_desc) {
 			next_desc = handler_desc->address_space.next;
 			acpi_ut_remove_reference(handler_desc);

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 9/15] ACPICA: Fix order of names in global mutex table (debug only)
From: Bob Moore <robert.moore@intel.com>
Date: Thu Jun 26 13:21:25 2008 -0700

Fix the ordering of the ASCII names in the table to match the
actual mutex IDs. Used by AcpiUtGetMutexName, a function used
for debug only.  Vegard Nossum. BZ 726

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 aclocal.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Nurp original.linux/include/acpi/aclocal.h new.linux/include/acpi/aclocal.h
--- original.linux/include/acpi/aclocal.h	2008-07-04 09:24:15.000000000 +0800
+++ new.linux/include/acpi/aclocal.h	2008-07-04 09:24:22.000000000 +0800
@@ -98,8 +98,8 @@ union acpi_parse_object;
 
 static char *acpi_gbl_mutex_names[ACPI_NUM_MUTEX] = {
 	"ACPI_MTX_Interpreter",
-	"ACPI_MTX_Tables",
 	"ACPI_MTX_Namespace",
+	"ACPI_MTX_Tables",
 	"ACPI_MTX_Events",
 	"ACPI_MTX_Caches",
 	"ACPI_MTX_Memory",

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 10/15] ACPICA: Allow same ACPI table to be loaded/unloaded more than once
From: Bob Moore <robert.moore@intel.com>
Date: Thu Jun 26 14:33:44 2008 -0700

Without this change, a table cannot be loaded again once it has
been loaded/unloaded one time. The current mechanism does not
unregister a table upon an unload. During a load, if the same
table is found, this no longer returns an exception. BZ 722

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 tbinstal.c |   49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff -Nurp original.linux/drivers/acpi/tables/tbinstal.c new.linux/drivers/acpi/tables/tbinstal.c
--- original.linux/drivers/acpi/tables/tbinstal.c	2008-07-04 09:24:22.000000000 +0800
+++ new.linux/drivers/acpi/tables/tbinstal.c	2008-07-04 09:24:29.000000000 +0800
@@ -146,6 +146,8 @@ acpi_tb_add_table(struct acpi_table_desc
 			}
 		}
 
+		/* Check for a table match on the entire table length */
+
 		length = ACPI_MIN(table_desc->length,
 				  acpi_gbl_root_table_list.tables[i].length);
 		if (ACPI_MEMCMP(table_desc->pointer,
@@ -154,17 +156,49 @@ acpi_tb_add_table(struct acpi_table_desc
 			continue;
 		}
 
-		/* Table is already registered */
-
+		/*
+		 * Note: the current mechanism does not unregister a table if it is
+		 * dynamically unloaded. The related namespace entries are deleted,
+		 * but the table remains in the root table list.
+		 *
+		 * The assumption here is that the number of different tables that
+		 * will be loaded is actually small, and there is minimal overhead
+		 * in just keeping the table in case it is needed again.
+		 *
+		 * If this assumption changes in the future (perhaps on large
+		 * machines with many table load/unload operations), tables will
+		 * need to be unregistered when they are unloaded, and slots in the
+		 * root table list should be reused when empty.
+		 */
+
+		/*
+		 * Table is already registered.
+		 * We can delete the table that was passed as a parameter.
+		 */
 		acpi_tb_delete_table(table_desc);
 		*table_index = i;
-		status = AE_ALREADY_EXISTS;
-		goto release;
+
+		if (acpi_gbl_root_table_list.tables[i].
+		    flags & ACPI_TABLE_IS_LOADED) {
+
+			/* Table is still loaded, this is an error */
+
+			status = AE_ALREADY_EXISTS;
+			goto release;
+		} else {
+			/* Table was unloaded, allow it to be reloaded */
+
+			table_desc->pointer =
+			    acpi_gbl_root_table_list.tables[i].pointer;
+			table_desc->address =
+			    acpi_gbl_root_table_list.tables[i].address;
+			status = AE_OK;
+			goto print_header;
+		}
 	}
 
-	/*
-	 * Add the table to the global table list
-	 */
+	/* Add the table to the global root table list */
+
 	status = acpi_tb_store_table(table_desc->address, table_desc->pointer,
 				     table_desc->length, table_desc->flags,
 				     table_index);
@@ -172,6 +206,7 @@ acpi_tb_add_table(struct acpi_table_desc
 		goto release;
 	}
 
+      print_header:
 	acpi_tb_print_table_header(table_desc->address, table_desc->pointer);
 
       release:

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 11/15] ACPICA: Fix possible memory leak in Unload() operator
From: Bob Moore <robert.moore@intel.com>
Date: Thu Jun 26 14:49:41 2008 -0700

The DdbHandle returned by Load() does not have its reference count
decremented during unload, leading to a memory leak. Lin Ming.
BZ 72

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 exconfig.c |    3 +++
 1 file changed, 3 insertions(+)

diff -Nurp original.linux/drivers/acpi/executer/exconfig.c new.linux/drivers/acpi/executer/exconfig.c
--- original.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:24:29.000000000 +0800
+++ new.linux/drivers/acpi/executer/exconfig.c	2008-07-04 09:24:36.000000000 +0800
@@ -529,5 +529,8 @@ acpi_status acpi_ex_unload_table(union a
 
 	acpi_tb_set_table_loaded_flag(table_index, FALSE);
 
+	/* Table unloaded, remove a reference to the ddb_handle object */
+
+	acpi_ut_remove_reference(ddb_handle);
 	return_ACPI_STATUS(AE_OK);
 }

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 12/15] ACPICA: Return method arg count from AcpiGetObjectInfo
From: Bob Moore <robert.moore@intel.com>
Date: Thu Jun 26 15:40:24 2008 -0700

Also update the debugger so that the correct number of arguments is
passed to the method. Prevents a warning message from the debugger.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 drivers/acpi/namespace/nsxfname.c |    4 ++++
 include/acpi/actypes.h            |    1 +
 2 files changed, 5 insertions(+)

diff -Nurp original.linux/drivers/acpi/namespace/nsxfname.c new.linux/drivers/acpi/namespace/nsxfname.c
--- original.linux/drivers/acpi/namespace/nsxfname.c	2008-07-04 09:24:35.000000000 +0800
+++ new.linux/drivers/acpi/namespace/nsxfname.c	2008-07-04 09:24:42.000000000 +0800
@@ -264,6 +264,10 @@ acpi_status acpi_get_object_info(acpi_ha
 	info->name = node->name.integer;
 	info->valid = 0;
 
+	if (node->type == ACPI_TYPE_METHOD) {
+		info->param_count = node->object->method.param_count;
+	}
+
 	status = acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	if (ACPI_FAILURE(status)) {
 		goto cleanup;
diff -Nurp original.linux/include/acpi/actypes.h new.linux/include/acpi/actypes.h
--- original.linux/include/acpi/actypes.h	2008-07-04 09:24:35.000000000 +0800
+++ new.linux/include/acpi/actypes.h	2008-07-04 09:24:42.000000000 +0800
@@ -874,6 +874,7 @@ struct acpi_obj_info_header {
 struct acpi_device_info {
 	ACPI_COMMON_OBJ_INFO;
 
+	u32 param_count;	/* If a method, required parameter count */
 	u32 valid;		/* Indicates which fields below are valid */
 	u32 current_status;	/* _STA value */
 	acpi_integer address;	/* _ADR value if any */

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 13/15] ACPICA: Fix wrong resource descriptor length for 64-bit build
From: Bob Moore <robert.moore@intel.com>
Date: Thu Jun 26 15:42:22 2008 -0700

The "minimal" descriptors such as EndTag are calculated as 12
bytes long, but the actual length in the internal descriptor is
16 because of the round-up to 8 on 64-bit build. BZ 728

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 actypes.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Nurp original.linux/include/acpi/actypes.h new.linux/include/acpi/actypes.h
--- original.linux/include/acpi/actypes.h	2008-07-04 09:24:42.000000000 +0800
+++ new.linux/include/acpi/actypes.h	2008-07-04 09:24:49.000000000 +0800
@@ -1241,8 +1241,8 @@ struct acpi_resource {
 
 #pragma pack()
 
-#define ACPI_RS_SIZE_MIN                    12
 #define ACPI_RS_SIZE_NO_DATA                8	/* Id + Length fields */
+#define ACPI_RS_SIZE_MIN                    (u32) ACPI_ROUND_UP_TO_NATIVE_WORD (12)
 #define ACPI_RS_SIZE(type)                  (u32) (ACPI_RS_SIZE_NO_DATA + sizeof (type))
 
 #define ACPI_NEXT_RESOURCE(res)             (struct acpi_resource *)((u8 *) res + res->length)

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 14/15] ACPICA: Fix table compare code, length then data
From: Bob Moore <robert.moore@intel.com>
Date: Fri Jun 27 15:10:31 2008 -0700

Split the ACPI table compare. First check that the lengths match
exactly. Then compare the data.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 tbinstal.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff -Nurp original.linux/drivers/acpi/tables/tbinstal.c new.linux/drivers/acpi/tables/tbinstal.c
--- original.linux/drivers/acpi/tables/tbinstal.c	2008-07-04 09:24:49.000000000 +0800
+++ new.linux/drivers/acpi/tables/tbinstal.c	2008-07-04 09:24:56.000000000 +0800
@@ -111,7 +111,6 @@ acpi_status
 acpi_tb_add_table(struct acpi_table_desc *table_desc, u32 * table_index)
 {
 	u32 i;
-	u32 length;
 	acpi_status status = AE_OK;
 
 	ACPI_FUNCTION_TRACE(tb_add_table);
@@ -146,13 +145,18 @@ acpi_tb_add_table(struct acpi_table_desc
 			}
 		}
 
-		/* Check for a table match on the entire table length */
+		/*
+		 * Check for a table match on the entire table length,
+		 * not just the header.
+		 */
+		if (table_desc->length !=
+		    acpi_gbl_root_table_list.tables[i].length) {
+			continue;
+		}
 
-		length = ACPI_MIN(table_desc->length,
-				  acpi_gbl_root_table_list.tables[i].length);
 		if (ACPI_MEMCMP(table_desc->pointer,
 				acpi_gbl_root_table_list.tables[i].pointer,
-				length)) {
+				acpi_gbl_root_table_list.tables[i].length)) {
 			continue;
 		}
 

>From nobody Fri Jul  4 09:22:43 CST 2008

Subject: [Patch 15/15] ACPICA: Update version to 20080701
From: Bob Moore <robert.moore@intel.com>
Date: Tue Jul 1 09:35:32 2008 -0700

Update version to 20080701.

Signed-off-by: Bob Moore <robert.moore@intel.com>
---

 acconfig.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -Nurp original.linux/include/acpi/acconfig.h new.linux/include/acpi/acconfig.h
--- original.linux/include/acpi/acconfig.h	2008-07-04 09:25:16.000000000 +0800
+++ new.linux/include/acpi/acconfig.h	2008-07-04 09:25:23.000000000 +0800
@@ -63,7 +63,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20080609
+#define ACPI_CA_VERSION                 0x20080701
 
 /*
  * OS name, used for the _OS object.  The _OS object is essentially obsolete,


--=-tx5/t7+0D6909IRHfDPq--

