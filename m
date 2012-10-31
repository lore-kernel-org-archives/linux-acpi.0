From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/26] ACPICA: Fix unmerged acmacros.h divergences.
Date: Wed, 31 Oct 2012 10:25:52 +0800
Message-ID: <ad1469576d6435c852a628ec090eea4fee1edc7f.1351649951.git.lv.zheng@intel.com>
References: <cover.1351649949.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57713 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2JaCZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2012 22:25:58 -0400
In-Reply-To: <cover.1351649949.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

The 20121018 release depends on some unmerged acmaros.h fixes.
This patch includes the fixes made on acmaros.h that will not affect
the generated vmlinux binary.

This patch will not affect the generated vmlinux binary.
This will decrease 157 lines of 20120913 divergence.diff.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acmacros.h |  161 ++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 104 deletions(-)

diff --git a/drivers/acpi/acpica/acmacros.h b/drivers/acpi/acpica/acmacros.h
index a7f68c4..da8062d 100644
--- a/drivers/acpi/acpica/acmacros.h
+++ b/drivers/acpi/acpica/acmacros.h
@@ -84,29 +84,29 @@
 
 /* These macros reverse the bytes during the move, converting little-endian to big endian */
 
-			  /* Big Endian      <==        Little Endian */
-			  /*  Hi...Lo                     Lo...Hi     */
+	 /* Big Endian      <==        Little Endian */
+	 /*  Hi...Lo                     Lo...Hi     */
 /* 16-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_16_TO_16(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[1];\
-					   ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
+			  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_16_TO_32(d, s)        {(*(u32 *)(void *)(d))=0;\
-							   ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-							   ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+					  ((u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
+					  ((u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_16_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
-									 ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
-									 ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
+							   ((u8 *)(void *)(d))[6] = ((u8 *)(void *)(s))[1];\
+							   ((u8 *)(void *)(d))[7] = ((u8 *)(void *)(s))[0];}
 
 /* 32-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_32_TO_16(d, s)        ACPI_MOVE_16_TO_16(d, s)	/* Truncate to 16 */
 
 #define ACPI_MOVE_32_TO_32(d, s)        {((  u8 *)(void *)(d))[0] = ((u8 *)(void *)(s))[3];\
-										 ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
-										 ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
-										 ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
+									  ((  u8 *)(void *)(d))[1] = ((u8 *)(void *)(s))[2];\
+									  ((  u8 *)(void *)(d))[2] = ((u8 *)(void *)(s))[1];\
+									  ((  u8 *)(void *)(d))[3] = ((u8 *)(void *)(s))[0];}
 
 #define ACPI_MOVE_32_TO_64(d, s)        {(*(u64 *)(void *)(d))=0;\
 										   ((u8 *)(void *)(d))[4] = ((u8 *)(void *)(s))[3];\
@@ -196,24 +196,12 @@
 #endif
 #endif
 
-/* Macros based on machine integer width */
-
-#if ACPI_MACHINE_WIDTH == 32
-#define ACPI_MOVE_SIZE_TO_16(d, s)       ACPI_MOVE_32_TO_16(d, s)
-
-#elif ACPI_MACHINE_WIDTH == 64
-#define ACPI_MOVE_SIZE_TO_16(d, s)       ACPI_MOVE_64_TO_16(d, s)
-
-#else
-#error unknown ACPI_MACHINE_WIDTH
-#endif
-
 /*
  * Fast power-of-two math macros for non-optimized compilers
  */
-#define _ACPI_DIV(value, power_of2)      ((u32) ((value) >> (power_of2)))
-#define _ACPI_MUL(value, power_of2)      ((u32) ((value) << (power_of2)))
-#define _ACPI_MOD(value, divisor)        ((u32) ((value) & ((divisor) -1)))
+#define _ACPI_DIV(value, power_of2)     ((u32) ((value) >> (power_of2)))
+#define _ACPI_MUL(value, power_of2)     ((u32) ((value) << (power_of2)))
+#define _ACPI_MOD(value, divisor)       ((u32) ((value) & ((divisor) -1)))
 
 #define ACPI_DIV_2(a)                   _ACPI_DIV(a, 1)
 #define ACPI_MUL_2(a)                   _ACPI_MUL(a, 1)
@@ -238,12 +226,12 @@
 /*
  * Rounding macros (Power of two boundaries only)
  */
-#define ACPI_ROUND_DOWN(value, boundary)     (((acpi_size)(value)) & \
-						(~(((acpi_size) boundary)-1)))
+#define ACPI_ROUND_DOWN(value, boundary)    (((acpi_size)(value)) & \
+												(~(((acpi_size) boundary)-1)))
 
-#define ACPI_ROUND_UP(value, boundary)	     ((((acpi_size)(value)) + \
-						(((acpi_size) boundary)-1)) & \
-						(~(((acpi_size) boundary)-1)))
+#define ACPI_ROUND_UP(value, boundary)      ((((acpi_size)(value)) + \
+												(((acpi_size) boundary)-1)) & \
+												(~(((acpi_size) boundary)-1)))
 
 /* Note: sizeof(acpi_size) evaluates to either 4 or 8 (32- vs 64-bit mode) */
 
@@ -264,7 +252,7 @@
 
 #define ACPI_ROUND_UP_TO(value, boundary)   (((value) + ((boundary)-1)) / (boundary))
 
-#define ACPI_IS_MISALIGNED(value)	    (((acpi_size) value) & (sizeof(acpi_size)-1))
+#define ACPI_IS_MISALIGNED(value)           (((acpi_size) value) & (sizeof(acpi_size)-1))
 
 /*
  * Bitmask creation
@@ -355,7 +343,6 @@
  * Ascii error messages can be configured out
  */
 #ifndef ACPI_NO_ERROR_MESSAGES
-
 /*
  * Error reporting. Callers module and line number are inserted by AE_INFO,
  * the plist contains a set of parens to allow variable-length lists.
@@ -375,18 +362,15 @@
 #define ACPI_WARN_PREDEFINED(plist)
 #define ACPI_INFO_PREDEFINED(plist)
 
-#endif		/* ACPI_NO_ERROR_MESSAGES */
+#endif				/* ACPI_NO_ERROR_MESSAGES */
 
 /*
  * Debug macros that are conditionally compiled
  */
 #ifdef ACPI_DEBUG_OUTPUT
-
 /*
  * Function entry tracing
  */
-#ifdef CONFIG_ACPI_DEBUG_FUNC_TRACE
-
 #define ACPI_FUNCTION_TRACE(a)          ACPI_FUNCTION_NAME(a) \
 			  acpi_ut_trace(ACPI_DEBUG_PARAMETERS)
 #define ACPI_FUNCTION_TRACE_PTR(a, b)   ACPI_FUNCTION_NAME(a) \
@@ -464,44 +448,18 @@
 
 #endif				/* ACPI_SIMPLE_RETURN_MACROS */
 
-#else /* !CONFIG_ACPI_DEBUG_FUNC_TRACE */
-
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_TRACE_PTR(a,b)
-#define ACPI_FUNCTION_TRACE_U32(a,b)
-#define ACPI_FUNCTION_TRACE_STR(a,b)
-#define ACPI_FUNCTION_EXIT
-#define ACPI_FUNCTION_STATUS_EXIT(s)
-#define ACPI_FUNCTION_VALUE_EXIT(s)
-#define ACPI_FUNCTION_TRACE(a)
-#define ACPI_FUNCTION_ENTRY()
-
-#define return_VOID                     return
-#define return_ACPI_STATUS(s)           return(s)
-#define return_VALUE(s)                 return(s)
-#define return_UINT8(s)                 return(s)
-#define return_UINT32(s)                return(s)
-#define return_PTR(s)                   return(s)
-
-#endif /* CONFIG_ACPI_DEBUG_FUNC_TRACE */
-
 /* Conditional execution */
 
 #define ACPI_DEBUG_EXEC(a)              a
-#define ACPI_NORMAL_EXEC(a)
-
-#define ACPI_DEBUG_DEFINE(a)            a;
 #define ACPI_DEBUG_ONLY_MEMBERS(a)      a;
 #define _VERBOSE_STRUCTURES
 
-/* Stack and buffer dumping */
+/* Various object display routines for debug */
 
 #define ACPI_DUMP_STACK_ENTRY(a)        acpi_ex_dump_operand((a), 0)
-#define ACPI_DUMP_OPERANDS(a, b, c)	acpi_ex_dump_operands(a, b, c)
-
+#define ACPI_DUMP_OPERANDS(a, b ,c)     acpi_ex_dump_operands(a, b, c)
 #define ACPI_DUMP_ENTRY(a, b)           acpi_ns_dump_entry (a, b)
 #define ACPI_DUMP_PATHNAME(a, b, c, d)  acpi_ns_dump_pathname(a, b, c, d)
-#define ACPI_DUMP_RESOURCE_LIST(a)      acpi_rs_dump_resource_list(a)
 #define ACPI_DUMP_BUFFER(a, b)          acpi_ut_dump_buffer((u8 *) a, b, DB_BYTE_DISPLAY, _COMPONENT)
 
 #else
@@ -510,25 +468,23 @@
  * leaving no executable debug code!
  */
 #define ACPI_DEBUG_EXEC(a)
-#define ACPI_NORMAL_EXEC(a)             a;
-
-#define ACPI_DEBUG_DEFINE(a)		do { } while(0)
-#define ACPI_DEBUG_ONLY_MEMBERS(a)	do { } while(0)
-#define ACPI_FUNCTION_TRACE(a)		do { } while(0)
-#define ACPI_FUNCTION_TRACE_PTR(a, b)	do { } while(0)
-#define ACPI_FUNCTION_TRACE_U32(a, b)	do { } while(0)
-#define ACPI_FUNCTION_TRACE_STR(a, b)	do { } while(0)
-#define ACPI_FUNCTION_EXIT		do { } while(0)
-#define ACPI_FUNCTION_STATUS_EXIT(s)	do { } while(0)
-#define ACPI_FUNCTION_VALUE_EXIT(s)	do { } while(0)
-#define ACPI_FUNCTION_ENTRY()		do { } while(0)
-#define ACPI_DUMP_STACK_ENTRY(a)	do { } while(0)
-#define ACPI_DUMP_OPERANDS(a, b, c)     do { } while(0)
-#define ACPI_DUMP_ENTRY(a, b)		do { } while(0)
-#define ACPI_DUMP_TABLES(a, b)		do { } while(0)
-#define ACPI_DUMP_PATHNAME(a, b, c, d)	do { } while(0)
-#define ACPI_DUMP_RESOURCE_LIST(a)	do { } while(0)
-#define ACPI_DUMP_BUFFER(a, b)		do { } while(0)
+#define ACPI_DEBUG_ONLY_MEMBERS(a)
+#define ACPI_FUNCTION_TRACE(a)
+#define ACPI_FUNCTION_TRACE_PTR(a, b)
+#define ACPI_FUNCTION_TRACE_U32(a, b)
+#define ACPI_FUNCTION_TRACE_STR(a, b)
+#define ACPI_FUNCTION_EXIT
+#define ACPI_FUNCTION_STATUS_EXIT(s)
+#define ACPI_FUNCTION_VALUE_EXIT(s)
+#define ACPI_FUNCTION_ENTRY()
+#define ACPI_DUMP_STACK_ENTRY(a)
+#define ACPI_DUMP_OPERANDS(a, b, c)
+#define ACPI_DUMP_ENTRY(a, b)
+#define ACPI_DUMP_TABLES(a, b)
+#define ACPI_DUMP_PATHNAME(a, b, c, d)
+#define ACPI_DUMP_BUFFER(a, b)
+#define ACPI_DEBUG_PRINT(pl)
+#define ACPI_DEBUG_PRINT_RAW(pl)
 
 #define return_VOID                     return
 #define return_ACPI_STATUS(s)           return(s)
@@ -556,18 +512,6 @@
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
@@ -578,13 +522,13 @@
 /* Memory allocation */
 
 #ifndef ACPI_ALLOCATE
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size)(a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE(a)            acpi_ut_allocate((acpi_size) (a), ACPI_MEM_PARAMETERS)
 #endif
 #ifndef ACPI_ALLOCATE_ZEROED
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size)(a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed((acpi_size) (a), ACPI_MEM_PARAMETERS)
 #endif
 #ifndef ACPI_FREE
-#define ACPI_FREE(a)                acpio_os_free(a)
+#define ACPI_FREE(a)                acpi_os_free(a)
 #endif
 #define ACPI_MEM_TRACKING(a)
 
@@ -592,16 +536,25 @@
 
 /* Memory allocation */
 
-#define ACPI_ALLOCATE(a)            acpi_ut_allocate_and_track((acpi_size)(a), ACPI_MEM_PARAMETERS)
-#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed_and_track((acpi_size)(a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE(a)            acpi_ut_allocate_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
+#define ACPI_ALLOCATE_ZEROED(a)     acpi_ut_allocate_zeroed_and_track((acpi_size) (a), ACPI_MEM_PARAMETERS)
 #define ACPI_FREE(a)                acpi_ut_free_and_track(a, ACPI_MEM_PARAMETERS)
 #define ACPI_MEM_TRACKING(a)        a
 
 #endif				/* ACPI_DBG_TRACK_ALLOCATIONS */
 
-/* Preemption point */
-#ifndef ACPI_PREEMPTION_POINT
-#define ACPI_PREEMPTION_POINT() /* no preemption */
-#endif
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
 
 #endif				/* ACMACROS_H */
-- 
1.7.10

