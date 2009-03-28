From: Len Brown <lenb@kernel.org>
Subject: [PATCH 45/98] ACPICA: New: I/O port protection
Date: Sat, 28 Mar 2009 00:31:20 -0400
Message-ID: <7f0719039085cc40114abce84cf29fe57da226f4.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:38046 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbZC1Ec4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700AFS8MNC8SW@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:49 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Protect certain I/O ports from reads/writes. Provides MS
compatibility. New module, hwvalid.c

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/Makefile   |    2 +-
 drivers/acpi/acpica/acglobal.h |    1 +
 drivers/acpi/acpica/achware.h  |    7 +
 drivers/acpi/acpica/aclocal.h  |   24 ++++
 drivers/acpi/acpica/exregion.c |    4 +-
 drivers/acpi/acpica/hwacpi.c   |    4 +-
 drivers/acpi/acpica/hwregs.c   |    4 +-
 drivers/acpi/acpica/hwsleep.c  |    2 +-
 drivers/acpi/acpica/hwvalid.c  |  240 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwxface.c  |    4 +-
 drivers/acpi/acpica/uteval.c   |   55 ++++++---
 drivers/acpi/acpica/utglobal.c |    1 +
 12 files changed, 319 insertions(+), 29 deletions(-)
 create mode 100644 drivers/acpi/acpica/hwvalid.c

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 290be74..17e5082 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -18,7 +18,7 @@ obj-y += exconfig.o  exfield.o  exnames.o   exoparg6.o  exresolv.o  exstorob.o\
 	 excreate.o  exmisc.o   exoparg2.o  exregion.o  exstore.o   exutils.o \
 	 exdump.o    exmutex.o  exoparg3.o  exresnte.o  exstoren.o
 
-obj-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o
+obj-y += hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o hwxface.o hwvalid.o
 
 obj-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index f431b99..16e5210 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -252,6 +252,7 @@ ACPI_EXTERN u8 acpi_gbl_step_to_next_call;
 ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
+ACPI_EXTERN u8 acpi_gbl_osi_data;
 
 #ifndef DEFINE_ACPI_GLOBALS
 
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 4fa6ee6..4afa3d8 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -73,6 +73,13 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value);
 acpi_status acpi_hw_clear_acpi_status(void);
 
 /*
+ * hwvalid - Port I/O with validation
+ */
+acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width);
+
+acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width);
+
+/*
  * hwgpe - GPE support
  */
 acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index f01e155..42ef0cb 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -863,6 +863,30 @@ struct acpi_bit_register_info {
 
 #define ACPI_BITPOSITION_ARB_DISABLE            0x00
 
+/* Structs and definitions for _OSI support and I/O port validation */
+
+#define ACPI_OSI_WIN_2000               0x01
+#define ACPI_OSI_WIN_XP                 0x02
+#define ACPI_OSI_WIN_XP_SP1             0x03
+#define ACPI_OSI_WINSRV_2003            0x04
+#define ACPI_OSI_WIN_XP_SP2             0x05
+#define ACPI_OSI_WINSRV_2003_SP1        0x06
+#define ACPI_OSI_WIN_VISTA              0x07
+
+#define ACPI_ALWAYS_ILLEGAL             0x00
+
+struct acpi_interface_info {
+	char *name;
+	u8 value;
+};
+
+struct acpi_port_info {
+	char *name;
+	u16 start;
+	u16 end;
+	u8 osi_dependency;
+};
+
 /*****************************************************************************
  *
  * Resource descriptors
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 76ec8ff..3a54b73 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -294,14 +294,14 @@ acpi_ex_system_io_space_handler(u32 function,
 	switch (function) {
 	case ACPI_READ:
 
-		status = acpi_os_read_port((acpi_io_address) address,
+		status = acpi_hw_read_port((acpi_io_address) address,
 					   &value32, bit_width);
 		*value = value32;
 		break;
 
 	case ACPI_WRITE:
 
-		status = acpi_os_write_port((acpi_io_address) address,
+		status = acpi_hw_write_port((acpi_io_address) address,
 					    (u32) * value, bit_width);
 		break;
 
diff --git a/drivers/acpi/acpica/hwacpi.c b/drivers/acpi/acpica/hwacpi.c
index e7949b1..9af361a 100644
--- a/drivers/acpi/acpica/hwacpi.c
+++ b/drivers/acpi/acpica/hwacpi.c
@@ -96,7 +96,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 
 		/* BIOS should have disabled ALL fixed and GP events */
 
-		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
+		status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 					    (u32) acpi_gbl_FADT.acpi_enable, 8);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Attempting to enable ACPI mode\n"));
@@ -108,7 +108,7 @@ acpi_status acpi_hw_set_mode(u32 mode)
 		 * BIOS should clear all fixed status bits and restore fixed event
 		 * enable bits to default
 		 */
-		status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
+		status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 					    (u32) acpi_gbl_FADT.acpi_disable,
 					    8);
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 6117362..f8ee0a7 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -222,7 +222,7 @@ acpi_hw_register_read(u32 register_id, u32 * return_value)
 	case ACPI_REGISTER_SMI_COMMAND_BLOCK:	/* 8-bit access */
 
 		status =
-		    acpi_os_read_port(acpi_gbl_FADT.smi_command, &value, 8);
+		    acpi_hw_read_port(acpi_gbl_FADT.smi_command, &value, 8);
 		break;
 
 	default:
@@ -356,7 +356,7 @@ acpi_status acpi_hw_register_write(u32 register_id, u32 value)
 		/* SMI_CMD is currently always in IO space */
 
 		status =
-		    acpi_os_write_port(acpi_gbl_FADT.smi_command, value, 8);
+		    acpi_hw_write_port(acpi_gbl_FADT.smi_command, value, 8);
 		break;
 
 	default:
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 2ea4c59..baa5fc0 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -430,7 +430,7 @@ acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
+	status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 				    (u32) acpi_gbl_FADT.S4bios_request, 8);
 
 	do {
diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
new file mode 100644
index 0000000..e0b562f
--- /dev/null
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -0,0 +1,240 @@
+
+/******************************************************************************
+ *
+ * Module Name: hwvalid - I/O request validation
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2009, Intel Corp.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions, and the following disclaimer,
+ *    without modification.
+ * 2. Redistributions in binary form must reproduce at minimum a disclaimer
+ *    substantially similar to the "NO WARRANTY" disclaimer below
+ *    ("Disclaimer") and any redistribution must be conditioned upon
+ *    including a substantially similar Disclaimer requirement for further
+ *    binary redistribution.
+ * 3. Neither the names of the above-listed copyright holders nor the names
+ *    of any contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * Alternatively, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") version 2 as published by the Free
+ * Software Foundation.
+ *
+ * NO WARRANTY
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDERS OR CONTRIBUTORS BE LIABLE FOR SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
+ * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGES.
+ */
+
+#include <acpi/acpi.h>
+#include "accommon.h"
+
+#define _COMPONENT          ACPI_HARDWARE
+ACPI_MODULE_NAME("hwvalid")
+
+/* Local prototypes */
+static acpi_status
+acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width);
+
+/*
+ * Protected I/O ports. Some ports are always illegal, and some are
+ * conditionally illegal. This table must remain ordered by port address.
+ *
+ * The table is used to implement the Microsoft port access rules that
+ * first appeared in Windows XP. Some ports are always illegal, and some
+ * ports are only illegal if the BIOS calls _OSI with a win_xP string or
+ * later (meaning that the BIOS itelf is post-XP.)
+ *
+ * This provides ACPICA with the desired port protections and
+ * Microsoft compatibility.
+ */
+static const struct acpi_port_info acpi_protected_ports[] = {
+	{"DMA1", 0x0000, 0x000F, ACPI_OSI_WIN_XP},
+	{"PIC0", 0x0020, 0x0021, ACPI_ALWAYS_ILLEGAL},
+	{"PIT1", 0x0040, 0x0043, ACPI_OSI_WIN_XP},
+	{"PIT2", 0x0048, 0x004B, ACPI_OSI_WIN_XP},
+	{"RTC", 0x0070, 0x0071, ACPI_OSI_WIN_XP},
+	{"CMOS", 0x0074, 0x0076, ACPI_OSI_WIN_XP},
+	{"DMA1", 0x0081, 0x0083, ACPI_OSI_WIN_XP},
+	{"DMA1", 0x0087, 0x0087, ACPI_OSI_WIN_XP},
+	{"DMA2", 0x0089, 0x0089, ACPI_OSI_WIN_XP},
+	{"DMA2", 0x008A, 0x008B, ACPI_OSI_WIN_XP},
+	{"DMA2", 0x008F, 0x008F, ACPI_OSI_WIN_XP},
+	{"Arb", 0x0090, 0x0091, ACPI_OSI_WIN_XP},
+	{"Setup", 0x0093, 0x0094, ACPI_OSI_WIN_XP},
+	{"POS", 0x0096, 0x0097, ACPI_OSI_WIN_XP},
+	{"PIC1", 0x00A0, 0x00A1, ACPI_ALWAYS_ILLEGAL},
+	{"DMA", 0x00C0, 0x00DF, ACPI_OSI_WIN_XP},
+	{"ELCR", 0x04D0, 0x04D1, ACPI_ALWAYS_ILLEGAL},
+	{"PCI", 0x0CF8, 0x0D00, ACPI_OSI_WIN_XP}
+};
+
+#define ACPI_PORT_INFO_ENTRIES  ACPI_ARRAY_LENGTH (acpi_protected_ports)
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_validate_io_request
+ *
+ * PARAMETERS:  Address             Address of I/O port/register
+ *              bit_width           Number of bits (8,16,32)
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Validates an I/O request (address/length). Certain ports are
+ *              always illegal and some ports are only illegal depending on
+ *              the requests the BIOS AML code makes to the predefined
+ *              _OSI method.
+ *
+ ******************************************************************************/
+
+static acpi_status
+acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
+{
+	u32 i;
+	u32 byte_width;
+	acpi_io_address last_address;
+	const struct acpi_port_info *port_info;
+
+	ACPI_FUNCTION_TRACE(hw_validate_io_request);
+
+	/* Supported widths are 8/16/32 */
+
+	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
+		return AE_BAD_PARAMETER;
+	}
+
+	port_info = acpi_protected_ports;
+	byte_width = ACPI_DIV_8(bit_width);
+	last_address = address + byte_width - 1;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_IO, "Address %p LastAddress %p Length %X",
+			  ACPI_CAST_PTR(void, address), ACPI_CAST_PTR(void,
+								      last_address),
+			  byte_width));
+
+	/* Maximum 16-bit address in I/O space */
+
+	if (last_address > ACPI_UINT16_MAX) {
+		ACPI_ERROR((AE_INFO,
+			    "Illegal I/O port address/length above 64K: 0x%p/%X",
+			    ACPI_CAST_PTR(void, address), byte_width));
+		return_ACPI_STATUS(AE_AML_ILLEGAL_ADDRESS);
+	}
+
+	/* Exit if requested address is not within the protected port table */
+
+	if (address > acpi_protected_ports[ACPI_PORT_INFO_ENTRIES - 1].end) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* Check request against the list of protected I/O ports */
+
+	for (i = 0; i < ACPI_PORT_INFO_ENTRIES; i++, port_info++) {
+		/*
+		 * Check if the requested address range will write to a reserved
+		 * port. Four cases to consider:
+		 *
+		 * 1) Address range is contained completely in the port address range
+		 * 2) Address range overlaps port range at the port range start
+		 * 3) Address range overlaps port range at the port range end
+		 * 4) Address range completely encompasses the port range
+		 */
+		if ((address <= port_info->end)
+		    && (last_address >= port_info->start)) {
+
+			/* Port illegality may depend on the _OSI calls made by the BIOS */
+
+			if (acpi_gbl_osi_data >= port_info->osi_dependency) {
+				ACPI_ERROR((AE_INFO,
+					    "Denied AML access to port 0x%p/%X (%s 0x%.4X-0x%.4X)",
+					    ACPI_CAST_PTR(void, address),
+					    byte_width, port_info->name,
+					    port_info->start, port_info->end));
+
+				return_ACPI_STATUS(AE_AML_ILLEGAL_ADDRESS);
+			}
+		}
+
+		/* Finished if address range ends before the end of this port */
+
+		if (last_address <= port_info->end) {
+			break;
+		}
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_read_port
+ *
+ * PARAMETERS:  Address             Address of I/O port/register to read
+ *              Value               Where value is placed
+ *              Width               Number of bits
+ *
+ * RETURN:      Value read from port
+ *
+ * DESCRIPTION: Read data from an I/O port or register. This is a front-end
+ *              to acpi_os_read_port that performs validation on both the port
+ *              address and the length.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_hw_read_port(acpi_io_address address, u32 *value, u32 width)
+{
+	acpi_status status;
+
+	status = acpi_hw_validate_io_request(address, width);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	status = acpi_os_read_port(address, value, width);
+	return status;
+}
+
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_write_port
+ *
+ * PARAMETERS:  Address             Address of I/O port/register to write
+ *              Value               Value to write
+ *              Width               Number of bits
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Write data to an I/O port or register. This is a front-end
+ *              to acpi_os_write_port that performs validation on both the port
+ *              address and the length.
+ *
+ *****************************************************************************/
+
+acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width)
+{
+	acpi_status status;
+
+	status = acpi_hw_validate_io_request(address, width);
+	if (ACPI_FAILURE(status)) {
+		return status;
+	}
+
+	status = acpi_os_write_port(address, value, width);
+	return status;
+}
diff --git a/drivers/acpi/acpica/hwxface.c b/drivers/acpi/acpica/hwxface.c
index 26e6642..9829979 100644
--- a/drivers/acpi/acpica/hwxface.c
+++ b/drivers/acpi/acpica/hwxface.c
@@ -146,7 +146,7 @@ acpi_status acpi_read(u32 *value, struct acpi_generic_address *reg)
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 
 		status =
-		    acpi_os_read_port((acpi_io_address) address, value, width);
+		    acpi_hw_read_port((acpi_io_address) address, value, width);
 		break;
 
 	default:
@@ -220,7 +220,7 @@ acpi_status acpi_write(u32 value, struct acpi_generic_address *reg)
 
 	case ACPI_ADR_SPACE_SYSTEM_IO:
 
-		status = acpi_os_write_port((acpi_io_address) address, value,
+		status = acpi_hw_write_port((acpi_io_address) address, value,
 					    width);
 		break;
 
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 3b91525..006b16c 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -59,26 +59,35 @@ acpi_ut_translate_one_cid(union acpi_operand_object *obj_desc,
 
 /*
  * Strings supported by the _OSI predefined (internal) method.
+ *
+ * March 2009: Removed "Linux" as this host no longer wants to respond true
+ * for this string. Basically, the only safe OS strings are windows-related
+ * and in many or most cases represent the only test path within the
+ * BIOS-provided ASL code.
+ *
+ * The second element of each entry is used to track the newest version of
+ * Windows that the BIOS has requested.
  */
-static char *acpi_interfaces_supported[] = {
+static struct acpi_interface_info acpi_interfaces_supported[] = {
 	/* Operating System Vendor Strings */
 
-	"Windows 2000",		/* Windows 2000 */
-	"Windows 2001",		/* Windows XP */
-	"Windows 2001 SP1",	/* Windows XP SP1 */
-	"Windows 2001 SP2",	/* Windows XP SP2 */
-	"Windows 2001.1",	/* Windows Server 2003 */
-	"Windows 2001.1 SP1",	/* Windows Server 2003 SP1 - Added 03/2006 */
-	"Windows 2006",		/* Windows Vista - Added 03/2006 */
+	{"Windows 2000", ACPI_OSI_WIN_2000},	/* Windows 2000 */
+	{"Windows 2001", ACPI_OSI_WIN_XP},	/* Windows XP */
+	{"Windows 2001 SP1", ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
+	{"Windows 2001.1", ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
+	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
+	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
+	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
 
 	/* Feature Group Strings */
 
-	"Extended Address Space Descriptor"
-	    /*
-	     * All "optional" feature group strings (features that are implemented
-	     * by the host) should be implemented in the host version of
-	     * acpi_os_validate_interface and should not be added here.
-	     */
+	{"Extended Address Space Descriptor", 0}
+
+	/*
+	 * All "optional" feature group strings (features that are implemented
+	 * by the host) should be implemented in the host version of
+	 * acpi_os_validate_interface and should not be added here.
+	 */
 };
 
 /*******************************************************************************
@@ -125,9 +134,17 @@ acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
 
 	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
 		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 acpi_interfaces_supported[i])) {
-
-			/* The interface is supported */
+				 acpi_interfaces_supported[i].name)) {
+			/*
+			 * The interface is supported.
+			 * Update the osi_data if necessary. We keep track of the latest
+			 * version of Windows that has been requested by the BIOS.
+			 */
+			if (acpi_interfaces_supported[i].value >
+			    acpi_gbl_osi_data) {
+				acpi_gbl_osi_data =
+				    acpi_interfaces_supported[i].value;
+			}
 
 			return_value = ACPI_UINT32_MAX;
 			goto exit;
@@ -176,8 +193,8 @@ acpi_status acpi_osi_invalidate(char *interface)
 	int i;
 
 	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i])) {
-			*acpi_interfaces_supported[i] = '\0';
+		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
+			*acpi_interfaces_supported[i].name = '\0';
 			return AE_OK;
 		}
 	}
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 256ce77..59e46f2 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -789,6 +789,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_trace_dbg_layer = 0;
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
+	acpi_gbl_osi_data = 0;
 
 	/* Hardware oriented */
 
-- 
1.6.0.6

