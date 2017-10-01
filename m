From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?=
        <jeremy.lefaure@lse.epita.fr>
Subject: [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Sun,  1 Oct 2017 15:30:53 -0400
Message-ID: <20171001193101.8898-16-jeremy.lefaure@lse.epita.fr>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: =?UTF-8?q?J=C3=A9r=C3=A9my=20Lefaure?= <jeremy.lefaure@lse.epita.fr>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Using the ARRAY_SIZE macro improves the readability of the code. It is
useless to re-invent the ARRAY_SIZE macro so let's use it.

It is useless to re-invent the ARRAY_SIZE macro so let's use it.

Found with Coccinelle with the following semantic patch:
@r depends on (org || report)@
type T;
T[] E;
position p;
@@
(
 (sizeof(E)@p /sizeof(*E))
|
 (sizeof(E)@p /sizeof(E[...]))
|
 (sizeof(E)@p /sizeof(T))
)

Signed-off-by: Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
---
 drivers/acpi/acpica/rsdumpinfo.c | 66 ++++++++++++++++++++--------------------
 drivers/acpi/acpica/tbfadt.c     | 13 +++-----
 2 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index da150e17795b..2cc52720b705 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -41,6 +41,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/kernel.h>
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "acresrc.h"
@@ -51,7 +52,6 @@ ACPI_MODULE_NAME("rsdumpinfo")
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUGGER)
 #define ACPI_RSD_OFFSET(f)          (u8) ACPI_OFFSET (union acpi_resource_data,f)
 #define ACPI_PRT_OFFSET(f)          (u8) ACPI_OFFSET (struct acpi_pci_routing_table,f)
-#define ACPI_RSD_TABLE_SIZE(name)   (sizeof(name) / sizeof (struct acpi_rsdump_info))
 /*******************************************************************************
  *
  * Resource Descriptor info tables
@@ -61,7 +61,7 @@ ACPI_MODULE_NAME("rsdumpinfo")
  *
  ******************************************************************************/
 struct acpi_rsdump_info acpi_rs_dump_irq[7] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_irq), "IRQ", NULL},
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_irq), "IRQ", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(irq.descriptor_length),
 	 "Descriptor Length", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(irq.triggering), "Triggering",
@@ -77,7 +77,7 @@ struct acpi_rsdump_info acpi_rs_dump_irq[7] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_dma[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_dma), "DMA", NULL},
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_dma), "DMA", NULL},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(dma.type), "Speed",
 	 acpi_gbl_typ_decode},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(dma.bus_master), "Mastering",
@@ -91,7 +91,7 @@ struct acpi_rsdump_info acpi_rs_dump_dma[6] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_start_dpf[4] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_start_dpf),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_start_dpf),
 	 "Start-Dependent-Functions", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(start_dpf.descriptor_length),
 	 "Descriptor Length", NULL},
@@ -102,12 +102,12 @@ struct acpi_rsdump_info acpi_rs_dump_start_dpf[4] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_end_dpf[1] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_end_dpf),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_end_dpf),
 	 "End-Dependent-Functions", NULL}
 };
 
 struct acpi_rsdump_info acpi_rs_dump_io[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_io), "I/O", NULL},
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_io), "I/O", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(io.io_decode), "Address Decoding",
 	 acpi_gbl_io_decode},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(io.minimum), "Address Minimum", NULL},
@@ -118,7 +118,7 @@ struct acpi_rsdump_info acpi_rs_dump_io[6] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_fixed_io[3] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_io),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_fixed_io),
 	 "Fixed I/O", NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(fixed_io.address), "Address", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(fixed_io.address_length),
@@ -126,7 +126,7 @@ struct acpi_rsdump_info acpi_rs_dump_fixed_io[3] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_vendor[3] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_vendor),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_vendor),
 	 "Vendor Specific", NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(vendor.byte_length), "Length", NULL},
 	{ACPI_RSD_LONGLIST, ACPI_RSD_OFFSET(vendor.byte_data[0]), "Vendor Data",
@@ -134,12 +134,12 @@ struct acpi_rsdump_info acpi_rs_dump_vendor[3] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_end_tag[1] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_end_tag), "EndTag",
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_end_tag), "EndTag",
 	 NULL}
 };
 
 struct acpi_rsdump_info acpi_rs_dump_memory24[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory24),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_memory24),
 	 "24-Bit Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(memory24.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -154,7 +154,7 @@ struct acpi_rsdump_info acpi_rs_dump_memory24[6] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_memory32[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory32),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_memory32),
 	 "32-Bit Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(memory32.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -169,7 +169,7 @@ struct acpi_rsdump_info acpi_rs_dump_memory32[6] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_fixed_memory32[4] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_memory32),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_fixed_memory32),
 	 "32-Bit Fixed Memory Range", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(fixed_memory32.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -180,7 +180,7 @@ struct acpi_rsdump_info acpi_rs_dump_fixed_memory32[4] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_address16[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address16),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address16),
 	 "16-Bit WORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(address16.address.granularity),
@@ -197,7 +197,7 @@ struct acpi_rsdump_info acpi_rs_dump_address16[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_address32[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address32),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address32),
 	 "32-Bit DWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT32, ACPI_RSD_OFFSET(address32.address.granularity),
@@ -214,7 +214,7 @@ struct acpi_rsdump_info acpi_rs_dump_address32[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_address64[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_address64),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_address64),
 	 "64-Bit QWORD Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(address64.address.granularity),
@@ -231,7 +231,7 @@ struct acpi_rsdump_info acpi_rs_dump_address64[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_ext_address64[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_address64),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_ext_address64),
 	 "64-Bit Extended Address Space", NULL},
 	{ACPI_RSD_ADDRESS, 0, NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_RSD_OFFSET(ext_address64.address.granularity),
@@ -250,7 +250,7 @@ struct acpi_rsdump_info acpi_rs_dump_ext_address64[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_ext_irq[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_ext_irq),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_ext_irq),
 	 "Extended IRQ", NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(extended_irq.producer_consumer),
 	 "Type", acpi_gbl_consume_decode},
@@ -269,7 +269,7 @@ struct acpi_rsdump_info acpi_rs_dump_ext_irq[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_generic_reg[6] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_generic_reg),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_generic_reg),
 	 "Generic Register", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(generic_reg.space_id), "Space ID",
 	 NULL},
@@ -283,7 +283,7 @@ struct acpi_rsdump_info acpi_rs_dump_generic_reg[6] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_gpio[16] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_gpio), "GPIO", NULL},
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_gpio), "GPIO", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(gpio.revision_id), "RevisionId", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(gpio.connection_type),
 	 "ConnectionType", acpi_gbl_ct_decode},
@@ -315,7 +315,7 @@ struct acpi_rsdump_info acpi_rs_dump_gpio[16] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_pin_function[10] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_function),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_pin_function),
 	 "PinFunction", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_function.revision_id),
 	 "RevisionId", NULL},
@@ -338,7 +338,7 @@ struct acpi_rsdump_info acpi_rs_dump_pin_function[10] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_pin_config[11] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_config),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_pin_config),
 	 "PinConfig", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_config.revision_id), "RevisionId",
 	 NULL},
@@ -363,7 +363,7 @@ struct acpi_rsdump_info acpi_rs_dump_pin_config[11] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_pin_group[8] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_group),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_pin_group),
 	 "PinGroup", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_group.revision_id), "RevisionId",
 	 NULL},
@@ -382,7 +382,7 @@ struct acpi_rsdump_info acpi_rs_dump_pin_group[8] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_pin_group_function[9] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_group_function),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_pin_group_function),
 	 "PinGroupFunction", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_group_function.revision_id),
 	 "RevisionId", NULL},
@@ -405,7 +405,7 @@ struct acpi_rsdump_info acpi_rs_dump_pin_group_function[9] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_pin_group_config[10] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_group_config),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_pin_group_config),
 	 "PinGroupConfig", NULL},
 	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_group_config.revision_id),
 	 "RevisionId", NULL},
@@ -429,7 +429,7 @@ struct acpi_rsdump_info acpi_rs_dump_pin_group_config[10] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_fixed_dma[4] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_dma),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_fixed_dma),
 	 "FixedDma", NULL},
 	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(fixed_dma.request_lines),
 	 "RequestLines", NULL},
@@ -452,13 +452,13 @@ struct acpi_rsdump_info acpi_rs_dump_fixed_dma[4] = {
 	{ACPI_RSD_SHORTLISTX,ACPI_RSD_OFFSET (common_serial_bus.vendor_data),   "VendorData",               NULL},
 
 struct acpi_rsdump_info acpi_rs_dump_common_serial_bus[11] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_common_serial_bus),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_common_serial_bus),
 	 "Common Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS
 };
 
 struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[14] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_i2c_serial_bus),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_i2c_serial_bus),
 	 "I2C Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_1BITFLAG,
 					ACPI_RSD_OFFSET(i2c_serial_bus.
@@ -471,7 +471,7 @@ struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[14] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[18] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_spi_serial_bus),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_spi_serial_bus),
 	 "Spi Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_1BITFLAG,
 					ACPI_RSD_OFFSET(spi_serial_bus.
@@ -492,7 +492,7 @@ struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[18] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[20] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_uart_serial_bus),
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_uart_serial_bus),
 	 "Uart Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_2BITFLAG,
 					ACPI_RSD_OFFSET(uart_serial_bus.
@@ -520,7 +520,7 @@ struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[20] = {
  * Tables used for common address descriptor flag fields
  */
 struct acpi_rsdump_info acpi_rs_dump_general_flags[5] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_general_flags), NULL,
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_general_flags), NULL,
 	 NULL},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(address.producer_consumer),
 	 "Consumer/Producer", acpi_gbl_consume_decode},
@@ -533,7 +533,7 @@ struct acpi_rsdump_info acpi_rs_dump_general_flags[5] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_memory_flags[5] = {
-	{ACPI_RSD_LITERAL, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_memory_flags),
+	{ACPI_RSD_LITERAL, ARRAY_SIZE(acpi_rs_dump_memory_flags),
 	 "Resource Type", (void *)"Memory Range"},
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(address.info.mem.write_protect),
 	 "Write Protect", acpi_gbl_rw_decode},
@@ -546,7 +546,7 @@ struct acpi_rsdump_info acpi_rs_dump_memory_flags[5] = {
 };
 
 struct acpi_rsdump_info acpi_rs_dump_io_flags[4] = {
-	{ACPI_RSD_LITERAL, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_io_flags),
+	{ACPI_RSD_LITERAL, ARRAY_SIZE(acpi_rs_dump_io_flags),
 	 "Resource Type", (void *)"I/O Range"},
 	{ACPI_RSD_2BITFLAG, ACPI_RSD_OFFSET(address.info.io.range_type),
 	 "Range Type", acpi_gbl_rng_decode},
@@ -560,7 +560,7 @@ struct acpi_rsdump_info acpi_rs_dump_io_flags[4] = {
  * Table used to dump _PRT contents
  */
 struct acpi_rsdump_info acpi_rs_dump_prt[5] = {
-	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_prt), NULL, NULL},
+	{ACPI_RSD_TITLE, ARRAY_SIZE(acpi_rs_dump_prt), NULL, NULL},
 	{ACPI_RSD_UINT64, ACPI_PRT_OFFSET(address), "Address", NULL},
 	{ACPI_RSD_UINT32, ACPI_PRT_OFFSET(pin), "Pin", NULL},
 	{ACPI_RSD_STRING, ACPI_PRT_OFFSET(source[0]), "Source", NULL},
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 5f051d82188d..d8322e62bb22 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -44,6 +44,7 @@
 #include <acpi/acpi.h>
 #include "accommon.h"
 #include "actables.h"
+#include <linux/kernel.h>
 
 #define _COMPONENT          ACPI_TABLES
 ACPI_MODULE_NAME("tbfadt")
@@ -137,9 +138,6 @@ static struct acpi_fadt_info fadt_info_table[] = {
 	 ACPI_FADT_SEPARATE_LENGTH | ACPI_FADT_GPE_REGISTER}
 };
 
-#define ACPI_FADT_INFO_ENTRIES \
-			(sizeof (fadt_info_table) / sizeof (struct acpi_fadt_info))
-
 /* Table used to split Event Blocks into separate status/enable registers */
 
 typedef struct acpi_fadt_pm_info {
@@ -167,9 +165,6 @@ static struct acpi_fadt_pm_info fadt_pm_info_table[] = {
 	 1}
 };
 
-#define ACPI_FADT_PM_INFO_ENTRIES \
-			(sizeof (fadt_pm_info_table) / sizeof (struct acpi_fadt_pm_info))
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_init_generic_address
@@ -520,7 +515,7 @@ static void acpi_tb_convert_fadt(void)
 
 	/* Examine all of the 64-bit extended address fields (X fields) */
 
-	for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(fadt_info_table); i++) {
 		/*
 		 * Get the 32-bit and 64-bit addresses, as well as the register
 		 * length and register name.
@@ -686,7 +681,7 @@ static void acpi_tb_setup_fadt_registers(void)
 	 * update them if they are incorrect.
 	 */
 	if (acpi_gbl_use_default_register_widths) {
-		for (i = 0; i < ACPI_FADT_INFO_ENTRIES; i++) {
+		for (i = 0; i < ARRAY_SIZE(fadt_info_table); i++) {
 			target64 =
 			    ACPI_ADD_PTR(struct acpi_generic_address,
 					 &acpi_gbl_FADT,
@@ -737,7 +732,7 @@ static void acpi_tb_setup_fadt_registers(void)
 	 * used.
 	 */
 
-	for (i = 0; i < ACPI_FADT_PM_INFO_ENTRIES; i++) {
+	for (i = 0; i < ARRAY_SIZE(fadt_pm_info_table); i++) {
 		source64 =
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_pm_info_table[i].source);
-- 
2.14.1
