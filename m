From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 05/13] ACPICA: ACPI 6.0, tools/iasl: Add support for new resource descriptors
Date: Thu,  5 May 2016 12:58:19 +0800
Message-ID: <90234239097c31d3a240d87a0e5f6a06c0703105.1462418912.git.lv.zheng@intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com> <cover.1462418912.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1462418912.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 5a0555ece4ba9917e5842b21d88469ae06b4e815

Adds full support for:
i2c_serial_bus_v2
spi_serial_bus_v2
uart_serial_bus_v2

Compiler, Disassembler, Resource Manager, acpi_help.

Link: https://github.com/acpica/acpica/commit/5a0555ec
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/rsdumpinfo.c |    9 +++++----
 drivers/acpi/acpica/rsserial.c   |   21 ++++++++++++++++++---
 include/acpi/acrestyp.h          |    1 +
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 5c34913..61e8f16 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -330,19 +330,20 @@ struct acpi_rsdump_info acpi_rs_dump_fixed_dma[4] = {
 	{ACPI_RSD_UINT8,    ACPI_RSD_OFFSET (common_serial_bus.type),           "Type",                     acpi_gbl_sbt_decode}, \
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET (common_serial_bus.producer_consumer), "ProducerConsumer",      acpi_gbl_consume_decode}, \
 	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET (common_serial_bus.slave_mode),     "SlaveMode",                acpi_gbl_sm_decode}, \
+	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET (common_serial_bus.connection_sharing),"ConnectionSharing",     acpi_gbl_shr_decode}, \
 	{ACPI_RSD_UINT8,    ACPI_RSD_OFFSET (common_serial_bus.type_revision_id), "TypeRevisionId",         NULL}, \
 	{ACPI_RSD_UINT16,   ACPI_RSD_OFFSET (common_serial_bus.type_data_length), "TypeDataLength",         NULL}, \
 	{ACPI_RSD_SOURCE,   ACPI_RSD_OFFSET (common_serial_bus.resource_source), "ResourceSource",          NULL}, \
 	{ACPI_RSD_UINT16,   ACPI_RSD_OFFSET (common_serial_bus.vendor_length),  "VendorLength",             NULL}, \
 	{ACPI_RSD_SHORTLISTX,ACPI_RSD_OFFSET (common_serial_bus.vendor_data),   "VendorData",               NULL},
 
-struct acpi_rsdump_info acpi_rs_dump_common_serial_bus[10] = {
+struct acpi_rsdump_info acpi_rs_dump_common_serial_bus[11] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_common_serial_bus),
 	 "Common Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS
 };
 
-struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[13] = {
+struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[14] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_i2c_serial_bus),
 	 "I2C Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_1BITFLAG,
@@ -355,7 +356,7 @@ struct acpi_rsdump_info acpi_rs_dump_i2c_serial_bus[13] = {
 	 "SlaveAddress", NULL},
 };
 
-struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[17] = {
+struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[18] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_spi_serial_bus),
 	 "Spi Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_1BITFLAG,
@@ -376,7 +377,7 @@ struct acpi_rsdump_info acpi_rs_dump_spi_serial_bus[17] = {
 	 "ConnectionSpeed", NULL},
 };
 
-struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[19] = {
+struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[20] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_uart_serial_bus),
 	 "Uart Serial Bus", NULL},
 	ACPI_RS_DUMP_COMMON_SERIAL_BUS {ACPI_RSD_2BITFLAG,
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 8a01296..b82c061 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -151,7 +151,7 @@ struct acpi_rsconvert_info acpi_rs_convert_gpio[18] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[16] = {
+struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[17] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_SERIAL_BUS,
 	 ACPI_RS_SIZE(struct acpi_resource_i2c_serialbus),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_i2c_serial_bus)},
@@ -177,6 +177,11 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[16] = {
 	 AML_OFFSET(common_serial_bus.flags),
 	 1},
 
+	{ACPI_RSC_1BITFLAG,
+	 ACPI_RS_OFFSET(data.common_serial_bus.connection_sharing),
+	 AML_OFFSET(common_serial_bus.flags),
+	 2},
+
 	{ACPI_RSC_MOVE8,
 	 ACPI_RS_OFFSET(data.common_serial_bus.type_revision_id),
 	 AML_OFFSET(common_serial_bus.type_revision_id),
@@ -237,7 +242,7 @@ struct acpi_rsconvert_info acpi_rs_convert_i2c_serial_bus[16] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_convert_spi_serial_bus[20] = {
+struct acpi_rsconvert_info acpi_rs_convert_spi_serial_bus[21] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_SERIAL_BUS,
 	 ACPI_RS_SIZE(struct acpi_resource_spi_serialbus),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_spi_serial_bus)},
@@ -263,6 +268,11 @@ struct acpi_rsconvert_info acpi_rs_convert_spi_serial_bus[20] = {
 	 AML_OFFSET(common_serial_bus.flags),
 	 1},
 
+	{ACPI_RSC_1BITFLAG,
+	 ACPI_RS_OFFSET(data.common_serial_bus.connection_sharing),
+	 AML_OFFSET(common_serial_bus.flags),
+	 2},
+
 	{ACPI_RSC_MOVE8,
 	 ACPI_RS_OFFSET(data.common_serial_bus.type_revision_id),
 	 AML_OFFSET(common_serial_bus.type_revision_id),
@@ -339,7 +349,7 @@ struct acpi_rsconvert_info acpi_rs_convert_spi_serial_bus[20] = {
  *
  ******************************************************************************/
 
-struct acpi_rsconvert_info acpi_rs_convert_uart_serial_bus[22] = {
+struct acpi_rsconvert_info acpi_rs_convert_uart_serial_bus[23] = {
 	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_SERIAL_BUS,
 	 ACPI_RS_SIZE(struct acpi_resource_uart_serialbus),
 	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_uart_serial_bus)},
@@ -365,6 +375,11 @@ struct acpi_rsconvert_info acpi_rs_convert_uart_serial_bus[22] = {
 	 AML_OFFSET(common_serial_bus.flags),
 	 1},
 
+	{ACPI_RSC_1BITFLAG,
+	 ACPI_RS_OFFSET(data.common_serial_bus.connection_sharing),
+	 AML_OFFSET(common_serial_bus.flags),
+	 2},
+
 	{ACPI_RSC_MOVE8,
 	 ACPI_RS_OFFSET(data.common_serial_bus.type_revision_id),
 	 AML_OFFSET(common_serial_bus.type_revision_id),
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index cf2acb8..16c1892 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -417,6 +417,7 @@ struct acpi_resource_gpio {
 	u8                                      type; \
 	u8                                      producer_consumer;   /* For values, see Producer/Consumer above */\
 	u8                                      slave_mode; \
+	u8                                      connection_sharing; \
 	u8                                      type_revision_id; \
 	u16                                     type_data_length; \
 	u16                                     vendor_length; \
-- 
1.7.10
