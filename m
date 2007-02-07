From: Len Brown <lenb@kernel.org>
Subject: [PATCH 113/140] ACPICA: Removed all 16-bit support.
Date: Wed,  7 Feb 2007 13:52:07 -0500
Message-ID: <11708745284015-git-send-email-lenb@kernel.org>
References: <11708743541314-git-send-email-lenb@kernel.org> <11708743561383-git-send-email-lenb@kernel.org> <117087435785-git-send-email-lenb@kernel.org> <11708743582090-git-send-email-lenb@kernel.org> <11708743611662-git-send-email-lenb@kernel.org> <11708743653073-git-send-email-lenb@kernel.org> <11708743674006-git-send-email-lenb@kernel.org> <11708743693386-git-send-email-lenb@kernel.org> <11708743702194-git-send-email-lenb@kernel.org> <11708743723353-git-send-email-lenb@kernel.org> <11708743783727-git-send-email-lenb@kernel.org> <11708743802558-git-send-email-lenb@kernel.org> <11708743821259-git-send-email-lenb@kernel.org> <11708743853573-git-send-email-lenb@kernel.org> <11708743871468-git-send-email-lenb@kernel.org> <1170874390715-git-send-email-lenb@kernel.org> <1170874393736-git-send-email-lenb@kernel.org> <11708743943108-git-send-email-lenb@kernel.org> <11708743962377-git-send-ema
 il-lenb@kernel.org> <11708743972593-git-send-email-lenb@kernel.org> <1170874398386-git-send-email-lenb@kernel.org> <11708743993414-git-send-email-lenb@kernel.org> <11708744003959-git-send-email-lenb@kernel.org> <11708744023872-git-send-email-lenb@kernel.org> <11708744032427-git-send-email-lenb@kernel.org> <11708744053556-git-send-email-lenb@kernel.org> <11708744062538-git-send-email-lenb@kernel.org> <11708744071019-git-send-email-lenb@kernel.org> <11708744093818-git-send-email-lenb@kernel.org> <11708744101300-git-send-email-lenb@kernel.org> <1170874412494-git-send-email-lenb@kernel.org> <11708744142658-git-send-email-lenb@kernel.org> <1170874415464-git-send-email-lenb@kernel.org> <1170874417392-git-send-email-lenb@kernel.org> <1170874418134-git-send-email-lenb@kernel.org> <11708744191642-git-send-email-lenb@kernel.org> <11708744203492-git-send-email-lenb@kernel.org> <1170874421658-git-
 send-email-lenb@kernel.org> <1170874422581-git-send-email-lenb@kernel.org> <117087442385-git-send-email-lenb@kernel.org> <1170874424332-git-send-email-lenb@kernel.org> <11708744253790-git-send-email-lenb@kernel.org> <11708744263395-git-send-email-lenb@kernel.org> <11708744273028-git-send-email-lenb@kernel.org> <11708744272354-git-send-email-lenb@kernel.org> <11708744311281-git-send-email-lenb@kernel.org> <11708744322360-git-send-email-lenb@kernel.org> <1170874433382-git-send-email-lenb@kernel.org> <11708744353864-git-send-email-lenb@kernel.org> <11708744352790-git-send-email-lenb@kernel.org> <1170874437973-git-send-email-lenb@kernel.org> <11708744382626-git-send-email-lenb@kernel.org> <11708744402139-git-send-email-lenb@kernel.org> <11708744413743-git-send-email-lenb@kernel.org> <117087444256-git-send-email-lenb@kernel.org> <11708744461131-git-send-email-lenb@kernel.org> <1170874451354
 1-git-send-email-lenb@kernel.org> <11708744522444-git-send-email-lenb@kernel.org> <1170874453363-git-send-email-lenb@kernel.org> <11708744542419-git-send-email-lenb@kernel.org> <11708744562243-git-send-email-lenb@kernel.org> <1170874458256-git-send-email-lenb@kernel.org> <11708744603317-git-send-email-lenb@kernel.org> <11708744612314-git-send-email-lenb@kernel.org> <117087446376-git-send-email-lenb@kernel.org> <11708744642267-git-send-email-lenb@kernel.org> <11708744674050-git-send-email-lenb@kernel.org> <11708744692041-git-send-email-lenb@kernel.org> <11708744712690-git-send-email-lenb@kernel.org> <11708744732351-git-send-email-lenb@kernel.org> <11708744752537-git-send-email-lenb@kernel.org> <11708744772462-git-send-email-lenb@kernel.org> <11708744803527-git-send-email-lenb@kernel.org> <11708744813011-git-send-email-lenb@kernel.org> <11708744852095-git-send-email-lenb@kernel.org> <117
 08744874154-git-send-email-lenb@kernel.org> <11708744878-git-send-email-lenb@kernel.org> <1170874488430-git-send-email-lenb@kernel.org> <11708744903381-git-send-email-lenb@kernel.org> <11708744911989-git-send-email-lenb@kernel.org> <11708744922677-git-send-email-lenb@kernel.org> <11708744934033-git-send-email-lenb@kernel.org> <1170874494939-git-send-email-lenb@kernel.org> <11708744951308-git-send-emailMessage-Id: <59fa85057e12ff135df54266722b2064c418fc05.1170873818.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:7723 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1422855AbXBGSzc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 13:55:32 -0500
In-Reply-To: <1170874527943-git-send-email-lenb@kernel.org>
In-Reply-To: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
References: <9e89dde2b063ca73fcdc9244fe68e2dea32c5088.1170873816.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Support for 16-bit ACPICA has been completely removed since it is
no longer necessary and it clutters the code. All 16-bit macros,
types, and conditional compiles have been removed, cleaning up
and simplifying the code across the entire subsystem.
DOS support is no longer needed since the Linux firmware kit
is now available.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpeblk.c   |   10 +++---
 drivers/acpi/executer/exoparg1.c |    2 -
 drivers/acpi/executer/exregion.c |    5 +--
 drivers/acpi/hardware/hwregs.c   |   14 +++----
 drivers/acpi/tables/tbxfroot.c   |    4 --
 include/acpi/acmacros.h          |   68 +-------------------------------------
 include/acpi/actypes.h           |   40 +---------------------
 7 files changed, 14 insertions(+), 129 deletions(-)

diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 8a6f01a..a23634c 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -796,12 +796,12 @@ acpi_ev_create_gpe_info_blocks(struct acpi_gpe_block_info *gpe_block)
 		    (u8) (gpe_block->block_base_number +
 			  (i * ACPI_GPE_REGISTER_WIDTH));
 
-		ACPI_STORE_ADDRESS(this_register->status_address.address,
-				   (gpe_block->block_address.address + i));
+		this_register->status_address.address =
+		    gpe_block->block_address.address + i;
 
-		ACPI_STORE_ADDRESS(this_register->enable_address.address,
-				   (gpe_block->block_address.address
-				    + i + gpe_block->register_count));
+		this_register->enable_address.address =
+		    gpe_block->block_address.address + i +
+		    gpe_block->register_count;
 
 		this_register->status_address.space_id =
 		    gpe_block->block_address.space_id;
diff --git a/drivers/acpi/executer/exoparg1.c b/drivers/acpi/executer/exoparg1.c
index 6374d8b..6f2e69c 100644
--- a/drivers/acpi/executer/exoparg1.c
+++ b/drivers/acpi/executer/exoparg1.c
@@ -104,9 +104,7 @@ acpi_status acpi_ex_opcode_0A_0T_1R(struct acpi_walk_state *walk_state)
 			status = AE_NO_MEMORY;
 			goto cleanup;
 		}
-#if ACPI_MACHINE_WIDTH != 16
 		return_desc->integer.value = acpi_os_get_timer();
-#endif
 		break;
 
 	default:		/*  Unknown opcode  */
diff --git a/drivers/acpi/executer/exregion.c b/drivers/acpi/executer/exregion.c
index 4967447..c6819e0 100644
--- a/drivers/acpi/executer/exregion.c
+++ b/drivers/acpi/executer/exregion.c
@@ -209,11 +209,10 @@ acpi_ex_system_memory_space_handler(u32 function,
 			*value = (acpi_integer) ACPI_GET32(logical_addr_ptr);
 			break;
 
-#if ACPI_MACHINE_WIDTH != 16
 		case 64:
 			*value = (acpi_integer) ACPI_GET64(logical_addr_ptr);
 			break;
-#endif
+
 		default:
 			/* bit_width was already validated */
 			break;
@@ -235,11 +234,9 @@ acpi_ex_system_memory_space_handler(u32 function,
 			ACPI_SET32(logical_addr_ptr) = (u32) * value;
 			break;
 
-#if ACPI_MACHINE_WIDTH != 16
 		case 64:
 			ACPI_SET64(logical_addr_ptr) = (u64) * value;
 			break;
-#endif
 
 		default:
 			/* bit_width was already validated */
diff --git a/drivers/acpi/hardware/hwregs.c b/drivers/acpi/hardware/hwregs.c
index 716e4ae..5b19fc7 100644
--- a/drivers/acpi/hardware/hwregs.c
+++ b/drivers/acpi/hardware/hwregs.c
@@ -788,8 +788,8 @@ acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
 
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 
-		status = acpi_os_read_port((acpi_io_address) address,
-					   value, width);
+		status =
+		    acpi_os_read_port((acpi_io_address) address, value, width);
 		break;
 
 	default:
@@ -800,8 +800,7 @@ acpi_hw_low_level_read(u32 width, u32 * value, struct acpi_generic_address *reg)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Read:  %8.8X width %2d from %8.8X%8.8X (%s)\n",
-			  *value, width,
-			  ACPI_FORMAT_UINT64(address),
+			  *value, width, ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
 	return (status);
@@ -858,8 +857,8 @@ acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address * reg)
 
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 
-		status = acpi_os_write_port((acpi_io_address) address,
-					    value, width);
+		status = acpi_os_write_port((acpi_io_address) address, value,
+					    width);
 		break;
 
 	default:
@@ -870,8 +869,7 @@ acpi_hw_low_level_write(u32 width, u32 value, struct acpi_generic_address * reg)
 
 	ACPI_DEBUG_PRINT((ACPI_DB_IO,
 			  "Wrote: %8.8X width %2d   to %8.8X%8.8X (%s)\n",
-			  value, width,
-			  ACPI_FORMAT_UINT64(address),
+			  value, width, ACPI_FORMAT_UINT64(address),
 			  acpi_ut_get_region_name(reg->space_id)));
 
 	return (status);
diff --git a/drivers/acpi/tables/tbxfroot.c b/drivers/acpi/tables/tbxfroot.c
index 5c6e882..82c0b66 100644
--- a/drivers/acpi/tables/tbxfroot.c
+++ b/drivers/acpi/tables/tbxfroot.c
@@ -98,8 +98,6 @@ static acpi_status acpi_tb_validate_rsdp(struct acpi_table_rsdp *rsdp)
 	return (AE_OK);
 }
 
-#if ACPI_MACHINE_WIDTH != 16
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_find_rsdp
@@ -275,5 +273,3 @@ static u8 *acpi_tb_scan_memory_for_rsdp(u8 * start_address, u32 length)
 			  start_address));
 	return_PTR(NULL);
 }
-
-#endif
diff --git a/include/acpi/acmacros.h b/include/acpi/acmacros.h
index 9b2e4d7..549e533 100644
--- a/include/acpi/acmacros.h
+++ b/include/acpi/acmacros.h
@@ -61,20 +61,6 @@
 
 #define ACPI_ARRAY_LENGTH(x)            (sizeof(x) / sizeof((x)[0]))
 
-#if ACPI_MACHINE_WIDTH == 16
-
-/*
- * For 16-bit addresses, we have to assume that the upper 32 bits
- * (out of 64) are zero.
- */
-#define ACPI_LODWORD(l)                 ((u32)(l))
-#define ACPI_HIDWORD(l)                 ((u32)(0))
-
-#define ACPI_GET_ADDRESS(a)             ((a).lo)
-#define ACPI_STORE_ADDRESS(a,b)         {(a).hi=0;(a).lo=(u32)(b);}
-#define ACPI_VALID_ADDRESS(a)           ((a).hi | (a).lo)
-
-#else
 #ifdef ACPI_NO_INTEGER64_SUPPORT
 /*
  * acpi_integer is 32-bits, no 64-bit support on this platform
@@ -82,10 +68,6 @@
 #define ACPI_LODWORD(l)                 ((u32)(l))
 #define ACPI_HIDWORD(l)                 ((u32)(0))
 
-#define ACPI_GET_ADDRESS(a)             (a)
-#define ACPI_STORE_ADDRESS(a,b)         ((a)=(b))
-#define ACPI_VALID_ADDRESS(a)           (a)
-
 #else
 
 /*
@@ -93,11 +75,6 @@
  */
 #define ACPI_LODWORD(l)                 ((u32)(u64)(l))
 #define ACPI_HIDWORD(l)                 ((u32)(((*(struct uint64_struct *)(void *)(&l))).hi))
-
-#define ACPI_GET_ADDRESS(a)             (a)
-#define ACPI_STORE_ADDRESS(a,b)         ((a)=(acpi_physical_address)(b))
-#define ACPI_VALID_ADDRESS(a)           (a)
-#endif
 #endif
 
 /*
@@ -135,15 +112,8 @@
 #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void,(void *) NULL,(acpi_native_uint) i)
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p,(void *) NULL)
 #define ACPI_OFFSET(d,f)                (acpi_size) ACPI_PTR_DIFF (&(((d *)0)->f),(void *) NULL)
-
-#if ACPI_MACHINE_WIDTH == 16
-#define ACPI_STORE_POINTER(d,s)         ACPI_MOVE_32_TO_32(d,s)
-#define ACPI_PHYSADDR_TO_PTR(i)         (void *)(i)
-#define ACPI_PTR_TO_PHYSADDR(i)         (u32) ACPI_CAST_PTR (u8,(i))
-#else
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
-#endif
 
 #ifndef ACPI_MISALIGNMENT_NOT_SUPPORTED
 #define ACPI_COMPARE_NAME(a,b)          (*ACPI_CAST_PTR (u32,(a)) == *ACPI_CAST_PTR (u32,(b)))
@@ -224,28 +194,6 @@
 
 /* The hardware supports unaligned transfers, just do the little-endian move */
 
-#if ACPI_MACHINE_WIDTH == 16
-
-/* No 64-bit integers */
-/* 16-bit source, 16/32/64 destination */
-
-#define ACPI_MOVE_16_TO_16(d,s)         *(u16 *)(void *)(d) = *(u16 *)(void *)(s)
-#define ACPI_MOVE_16_TO_32(d,s)         *(u32 *)(void *)(d) = *(u16 *)(void *)(s)
-#define ACPI_MOVE_16_TO_64(d,s)         ACPI_MOVE_16_TO_32(d,s)
-
-/* 32-bit source, 16/32/64 destination */
-
-#define ACPI_MOVE_32_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
-#define ACPI_MOVE_32_TO_32(d,s)         *(u32 *)(void *)(d) = *(u32 *)(void *)(s)
-#define ACPI_MOVE_32_TO_64(d,s)         ACPI_MOVE_32_TO_32(d,s)
-
-/* 64-bit source, 16/32/64 destination */
-
-#define ACPI_MOVE_64_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
-#define ACPI_MOVE_64_TO_32(d,s)         ACPI_MOVE_32_TO_32(d,s)	/* Truncate to 32 */
-#define ACPI_MOVE_64_TO_64(d,s)         ACPI_MOVE_32_TO_32(d,s)
-
-#else
 /* 16-bit source, 16/32/64 destination */
 
 #define ACPI_MOVE_16_TO_16(d,s)         *(u16 *)(void *)(d) = *(u16 *)(void *)(s)
@@ -263,7 +211,6 @@
 #define ACPI_MOVE_64_TO_16(d,s)         ACPI_MOVE_16_TO_16(d,s)	/* Truncate to 16 */
 #define ACPI_MOVE_64_TO_32(d,s)         ACPI_MOVE_32_TO_32(d,s)	/* Truncate to 32 */
 #define ACPI_MOVE_64_TO_64(d,s)         *(u64 *)(void *)(d) = *(u64 *)(void *)(s)
-#endif
 
 #else
 /*
@@ -308,10 +255,7 @@
 
 /* Macros based on machine integer width */
 
-#if ACPI_MACHINE_WIDTH == 16
-#define ACPI_MOVE_SIZE_TO_16(d,s)       ACPI_MOVE_16_TO_16(d,s)
-
-#elif ACPI_MACHINE_WIDTH == 32
+#if ACPI_MACHINE_WIDTH == 32
 #define ACPI_MOVE_SIZE_TO_16(d,s)       ACPI_MOVE_32_TO_16(d,s)
 
 #elif ACPI_MACHINE_WIDTH == 64
@@ -696,16 +640,6 @@
 #define ACPI_DEBUGGER_EXEC(a)
 #endif
 
-/*
- * For 16-bit code, we want to shrink some things even though
- * we are using ACPI_DEBUG_OUTPUT to get the debug output
- */
-#if ACPI_MACHINE_WIDTH == 16
-#undef ACPI_DEBUG_ONLY_MEMBERS
-#undef _VERBOSE_STRUCTURES
-#define ACPI_DEBUG_ONLY_MEMBERS(a)
-#endif
-
 #ifdef ACPI_DEBUG_OUTPUT
 /*
  * 1) Set name to blanks
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d213f97..fff2d24 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -149,14 +149,12 @@ typedef int INT32;
 typedef u64 acpi_native_uint;
 typedef s64 acpi_native_int;
 
-typedef u64 acpi_table_ptr;
 typedef u64 acpi_io_address;
 typedef u64 acpi_physical_address;
 
 #define ACPI_MAX_PTR                    ACPI_UINT64_MAX
 #define ACPI_SIZE_MAX                   ACPI_UINT64_MAX
 
-#define ACPI_NATIVE_BOUNDARY            8
 #define ACPI_USE_NATIVE_DIVIDE	/* Has native 64-bit integer support */
 
 /*
@@ -190,51 +188,15 @@ typedef int INT32;
 typedef u32 acpi_native_uint;
 typedef s32 acpi_native_int;
 
-typedef u64 acpi_table_ptr;
 typedef u32 acpi_io_address;
 typedef u32 acpi_physical_address;
 
 #define ACPI_MAX_PTR                    ACPI_UINT32_MAX
 #define ACPI_SIZE_MAX                   ACPI_UINT32_MAX
 
-#define ACPI_NATIVE_BOUNDARY            4
-
-/*******************************************************************************
- *
- * Types specific to 16-bit targets
- *
- ******************************************************************************/
-
-#elif ACPI_MACHINE_WIDTH == 16
-
-/*! [Begin] no source code translation (keep the typedefs as-is) */
-
-typedef unsigned long UINT32;
-typedef short INT16;
-typedef long INT32;
-
-/*! [End] no source code translation !*/
-
-typedef u16 acpi_native_uint;
-typedef s16 acpi_native_int;
-
-typedef u32 acpi_table_ptr;
-typedef u32 acpi_io_address;
-typedef char *acpi_physical_address;
-
-#define ACPI_MAX_PTR                    ACPI_UINT16_MAX
-#define ACPI_SIZE_MAX                   ACPI_UINT16_MAX
-
-#define ACPI_NATIVE_BOUNDARY            2
-#define ACPI_USE_NATIVE_DIVIDE	/* No 64-bit integers, ok to use native divide */
-
-/* 64-bit integers cannot be supported */
-
-#define ACPI_NO_INTEGER64_SUPPORT
-
 #else
 
-/* ACPI_MACHINE_WIDTH must be either 64, 32, or 16 */
+/* ACPI_MACHINE_WIDTH must be either 64 or 32 */
 
 #error unknown ACPI_MACHINE_WIDTH
 #endif
-- 
1.5.0.rc3.39.gec804
