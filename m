From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 24/53] ACPICA: ACPI 6.2: Add support for PinGroupFunction() resource
Date: Mon,  5 Jun 2017 16:39:31 +0800
Message-ID: <4e6c994118c7b4a818469265ff0682d31479cffe.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10858 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbdFEIje (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:39:34 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: Mika Westerberg <mika.westerberg@linux.intel.com>

ACPICA commit bd9a745749eac7137cd23085e6bdeb322de14ea2

PinGroupFunction() is a new resource introduced with ACPI 6.2. It is
used with PinGroup() to configure specific mode for a set of pins
exposed by a GPIO controller.

The format of the resource is:

  PinGroupFunction (Shared/Exclusive, FunctionNumber, ResourceSource,
                    ResourceSourceIndex, ResourceSourceLabel,
                    ResourceUsage, DescriptorName, VendorData)

The resource_source and ResourceSourceLabel fields are used to specify
the PinGroup() resource referenced by PinGroupFunction().

  Device (GPIO)
  {
      Name (_CRS, ResourceTemplate () {
          PinGroup ("group1") {2, 3}
          PinGroup ("group2") {4, 5}
          ...
      })
  }

  Device (I2C)
  {
      Name (_CRS, ResourceTemplate () {
          PinGroupFunction (Exclusive, 6, "^GPIO", 0, "mygroup2")
      })
  }

In the above example the PinGroupFunction() references the second
PinGroup() resource (using label "mygroup2" and configures pins 4 and 5
into mode 6.

Link: https://github.com/acpica/acpica/commit/bd9a7457
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/aclocal.h    |  3 +-
 drivers/acpi/acpica/acresrc.h    |  3 ++
 drivers/acpi/acpica/amlresrc.h   | 20 +++++++++++
 drivers/acpi/acpica/rscalc.c     | 26 ++++++++++++++
 drivers/acpi/acpica/rsdump.c     | 10 ++++++
 drivers/acpi/acpica/rsdumpinfo.c | 23 ++++++++++++
 drivers/acpi/acpica/rsinfo.c     |  5 +++
 drivers/acpi/acpica/rsserial.c   | 77 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utresrc.c    |  2 ++
 include/acpi/acrestyp.h          | 15 +++++++-
 10 files changed, 182 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 01b961c..75fd75c3 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1146,7 +1146,8 @@ struct acpi_port_info {
 #define ACPI_RESOURCE_NAME_SERIAL_BUS           0x8E
 #define ACPI_RESOURCE_NAME_PIN_CONFIG           0x8F
 #define ACPI_RESOURCE_NAME_PIN_GROUP            0x90
-#define ACPI_RESOURCE_NAME_LARGE_MAX            0x90
+#define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
+#define ACPI_RESOURCE_NAME_LARGE_MAX            0x91
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/acpica/acresrc.h b/drivers/acpi/acpica/acresrc.h
index 63f2ab4..4b28939 100644
--- a/drivers/acpi/acpica/acresrc.h
+++ b/drivers/acpi/acpica/acresrc.h
@@ -150,6 +150,7 @@ typedef enum {
 	ACPI_RSD_UINT64,
 	ACPI_RSD_WORDLIST,
 	ACPI_RSD_LABEL,
+	ACPI_RSD_SOURCE_LABEL,
 
 } ACPI_RSDUMP_OPCODES;
 
@@ -334,6 +335,7 @@ extern struct acpi_rsconvert_info acpi_rs_convert_uart_serial_bus[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_function[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_config[];
 extern struct acpi_rsconvert_info acpi_rs_convert_pin_group[];
+extern struct acpi_rsconvert_info acpi_rs_convert_pin_group_function[];
 
 /* These resources require separate get/set tables */
 
@@ -386,6 +388,7 @@ extern struct acpi_rsdump_info acpi_rs_dump_uart_serial_bus[];
 extern struct acpi_rsdump_info acpi_rs_dump_general_flags[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_config[];
 extern struct acpi_rsdump_info acpi_rs_dump_pin_group[];
+extern struct acpi_rsdump_info acpi_rs_dump_pin_group_function[];
 #endif
 
 #endif				/* __ACRESRC_H__ */
diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 510c20d..de44df7 100644
--- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -464,6 +464,25 @@ struct aml_resource_pin_group {
 
 #define AML_RESOURCE_PIN_GROUP_REVISION      1	/* ACPI 6.2 */
 
+struct aml_resource_pin_group_function {
+	AML_RESOURCE_LARGE_HEADER_COMMON u8 revision_id;
+	u16 flags;
+	u16 function_number;
+	u8 res_source_index;
+	u16 res_source_offset;
+	u16 res_source_label_offset;
+	u16 vendor_offset;
+	u16 vendor_length;
+	/*
+	 * Optional fields follow immediately:
+	 * 1) Resource Source String
+	 * 2) Resource Source Label String
+	 * 3) Vendor Data bytes
+	 */
+};
+
+#define AML_RESOURCE_PIN_GROUP_FUNCTION_REVISION    1	/* ACPI 6.2 */
+
 /* restore default alignment */
 
 #pragma pack()
@@ -509,6 +528,7 @@ union aml_resource {
 	struct aml_resource_pin_function pin_function;
 	struct aml_resource_pin_config pin_config;
 	struct aml_resource_pin_group pin_group;
+	struct aml_resource_pin_group_function pin_group_function;
 
 	/* Utility overlays */
 
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 39cc7ff..a0331ef 100644
--- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -402,6 +402,23 @@ acpi_rs_get_aml_length(struct acpi_resource *resource,
 
 			break;
 
+		case ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION:
+
+			total_size = (acpi_rs_length)(total_size +
+						      resource->data.
+						      pin_group_function.
+						      resource_source.
+						      string_length +
+						      resource->data.
+						      pin_group_function.
+						      resource_source_label.
+						      string_length +
+						      resource->data.
+						      pin_group_function.
+						      vendor_length);
+
+			break;
+
 		default:
 
 			break;
@@ -634,6 +651,15 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 
 			break;
 
+		case ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION:
+
+			extra_struct_bytes +=
+			    aml_resource->pin_group_function.vendor_offset -
+			    aml_resource->pin_group_function.res_source_offset +
+			    aml_resource->pin_group_function.vendor_length;
+
+			break;
+
 		default:
 
 			break;
diff --git a/drivers/acpi/acpica/rsdump.c b/drivers/acpi/acpica/rsdump.c
index 608e36e..55fd188 100644
--- a/drivers/acpi/acpica/rsdump.c
+++ b/drivers/acpi/acpica/rsdump.c
@@ -385,6 +385,16 @@ acpi_rs_dump_descriptor(void *resource, struct acpi_rsdump_info *table)
 								  target));
 			break;
 
+		case ACPI_RSD_SOURCE_LABEL:
+			/*
+			 * resource_source_label
+			 */
+			acpi_rs_dump_resource_label("Resource Source Label",
+						    ACPI_CAST_PTR(struct
+								  acpi_resource_label,
+								  target));
+			break;
+
 		default:
 
 			acpi_os_printf("**** Invalid table opcode [%X] ****\n",
diff --git a/drivers/acpi/acpica/rsdumpinfo.c b/drivers/acpi/acpica/rsdumpinfo.c
index 30c34d5..355b40f 100644
--- a/drivers/acpi/acpica/rsdumpinfo.c
+++ b/drivers/acpi/acpica/rsdumpinfo.c
@@ -381,6 +381,29 @@ struct acpi_rsdump_info acpi_rs_dump_pin_group[8] = {
 	 "VendorData", NULL},
 };
 
+struct acpi_rsdump_info acpi_rs_dump_pin_group_function[9] = {
+	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_pin_group_function),
+	 "PinGroupFunction", NULL},
+	{ACPI_RSD_UINT8, ACPI_RSD_OFFSET(pin_group_function.revision_id),
+	 "RevisionId", NULL},
+	{ACPI_RSD_1BITFLAG,
+	 ACPI_RSD_OFFSET(pin_group_function.producer_consumer),
+	 "ProducerConsumer", acpi_gbl_consume_decode},
+	{ACPI_RSD_1BITFLAG, ACPI_RSD_OFFSET(pin_group_function.sharable),
+	 "Sharing", acpi_gbl_shr_decode},
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(pin_group_function.function_number),
+	 "FunctionNumber", NULL},
+	{ACPI_RSD_SOURCE_LABEL,
+	 ACPI_RSD_OFFSET(pin_group_function.resource_source_label),
+	 "ResourceSourceLabel", NULL},
+	{ACPI_RSD_SOURCE, ACPI_RSD_OFFSET(pin_group_function.resource_source),
+	 "ResourceSource", NULL},
+	{ACPI_RSD_UINT16, ACPI_RSD_OFFSET(pin_group_function.vendor_length),
+	 "VendorLength", NULL},
+	{ACPI_RSD_SHORTLISTX, ACPI_RSD_OFFSET(pin_group_function.vendor_data),
+	 "VendorData", NULL},
+};
+
 struct acpi_rsdump_info acpi_rs_dump_fixed_dma[4] = {
 	{ACPI_RSD_TITLE, ACPI_RSD_TABLE_SIZE(acpi_rs_dump_fixed_dma),
 	 "FixedDma", NULL},
diff --git a/drivers/acpi/acpica/rsinfo.c b/drivers/acpi/acpica/rsinfo.c
index 13c3d36..ebccc6a 100644
--- a/drivers/acpi/acpica/rsinfo.c
+++ b/drivers/acpi/acpica/rsinfo.c
@@ -83,6 +83,7 @@ struct acpi_rsconvert_info *acpi_gbl_set_resource_dispatch[] = {
 	acpi_rs_convert_pin_function,	/* 0x14, ACPI_RESOURCE_TYPE_PIN_FUNCTION */
 	acpi_rs_convert_pin_config,	/* 0x15, ACPI_RESOURCE_TYPE_PIN_CONFIG */
 	acpi_rs_convert_pin_group,	/* 0x16, ACPI_RESOURCE_TYPE_PIN_GROUP */
+	acpi_rs_convert_pin_group_function,	/* 0x17, ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 };
 
 /* Dispatch tables for AML-to-resource (Get Resource) conversion functions */
@@ -126,6 +127,7 @@ struct acpi_rsconvert_info *acpi_gbl_get_resource_dispatch[] = {
 	NULL,			/* 0x0E, ACPI_RESOURCE_NAME_SERIAL_BUS - Use subtype table below */
 	acpi_rs_convert_pin_config,	/* 0x0F, ACPI_RESOURCE_NAME_PIN_CONFIG */
 	acpi_rs_convert_pin_group,	/* 0x10, ACPI_RESOURCE_NAME_PIN_GROUP */
+	acpi_rs_convert_pin_group_function,	/* 0x11, ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION */
 };
 
 /* Subtype table for serial_bus -- I2C, SPI, and UART */
@@ -165,6 +167,7 @@ struct acpi_rsdump_info *acpi_gbl_dump_resource_dispatch[] = {
 	acpi_rs_dump_pin_function,	/* ACPI_RESOURCE_TYPE_PIN_FUNCTION */
 	acpi_rs_dump_pin_config,	/* ACPI_RESOURCE_TYPE_PIN_CONFIG */
 	acpi_rs_dump_pin_group,	/* ACPI_RESOURCE_TYPE_PIN_GROUP */
+	acpi_rs_dump_pin_group_function,	/* ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 };
 
 struct acpi_rsdump_info *acpi_gbl_dump_serial_bus_dispatch[] = {
@@ -204,6 +207,7 @@ const u8 acpi_gbl_aml_resource_sizes[] = {
 	sizeof(struct aml_resource_pin_function),	/* ACPI_RESOURCE_TYPE_PIN_FUNCTION */
 	sizeof(struct aml_resource_pin_config),	/* ACPI_RESOURCE_TYPE_PIN_CONFIG */
 	sizeof(struct aml_resource_pin_group),	/* ACPI_RESOURCE_TYPE_PIN_GROUP */
+	sizeof(struct aml_resource_pin_group_function),	/* ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION */
 };
 
 const u8 acpi_gbl_resource_struct_sizes[] = {
@@ -245,6 +249,7 @@ const u8 acpi_gbl_resource_struct_sizes[] = {
 	ACPI_RS_SIZE(struct acpi_resource_common_serialbus),
 	ACPI_RS_SIZE(struct acpi_resource_pin_config),
 	ACPI_RS_SIZE(struct acpi_resource_pin_group),
+	ACPI_RS_SIZE(struct acpi_resource_pin_group_function),
 };
 
 const u8 acpi_gbl_aml_resource_serial_bus_sizes[] = {
diff --git a/drivers/acpi/acpica/rsserial.c b/drivers/acpi/acpica/rsserial.c
index 4a15893..96ee92e 100644
--- a/drivers/acpi/acpica/rsserial.c
+++ b/drivers/acpi/acpica/rsserial.c
@@ -674,3 +674,80 @@ struct acpi_rsconvert_info acpi_rs_convert_pin_group[10] = {
 	 AML_OFFSET(pin_group.vendor_offset),
 	 0},
 };
+
+/*******************************************************************************
+ *
+ * acpi_rs_convert_pin_group_function
+ *
+ ******************************************************************************/
+
+struct acpi_rsconvert_info acpi_rs_convert_pin_group_function[13] = {
+	{ACPI_RSC_INITGET, ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION,
+	 ACPI_RS_SIZE(struct acpi_resource_pin_group_function),
+	 ACPI_RSC_TABLE_SIZE(acpi_rs_convert_pin_group_function)},
+
+	{ACPI_RSC_INITSET, ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION,
+	 sizeof(struct aml_resource_pin_group_function),
+	 0},
+
+	{ACPI_RSC_MOVE8, ACPI_RS_OFFSET(data.pin_group_function.revision_id),
+	 AML_OFFSET(pin_group_function.revision_id),
+	 1},
+
+	{ACPI_RSC_1BITFLAG, ACPI_RS_OFFSET(data.pin_group_function.sharable),
+	 AML_OFFSET(pin_group_function.flags),
+	 0},
+
+	{ACPI_RSC_1BITFLAG,
+	 ACPI_RS_OFFSET(data.pin_group_function.producer_consumer),
+	 AML_OFFSET(pin_group_function.flags),
+	 1},
+
+	{ACPI_RSC_MOVE16,
+	 ACPI_RS_OFFSET(data.pin_group_function.function_number),
+	 AML_OFFSET(pin_group_function.function_number),
+	 1},
+
+	/* Resource Source */
+
+	{ACPI_RSC_MOVE8,
+	 ACPI_RS_OFFSET(data.pin_group_function.resource_source.index),
+	 AML_OFFSET(pin_group_function.res_source_index),
+	 1},
+
+	{ACPI_RSC_COUNT_GPIO_RES,
+	 ACPI_RS_OFFSET(data.pin_group_function.resource_source.string_length),
+	 AML_OFFSET(pin_group_function.res_source_offset),
+	 AML_OFFSET(pin_group_function.res_source_label_offset)},
+
+	{ACPI_RSC_MOVE_GPIO_RES,
+	 ACPI_RS_OFFSET(data.pin_group_function.resource_source.string_ptr),
+	 AML_OFFSET(pin_group_function.res_source_offset),
+	 0},
+
+	/* Resource Source Label */
+
+	{ACPI_RSC_COUNT_GPIO_RES,
+	 ACPI_RS_OFFSET(data.pin_group_function.resource_source_label.
+			string_length),
+	 AML_OFFSET(pin_group_function.res_source_label_offset),
+	 AML_OFFSET(pin_group_function.vendor_offset)},
+
+	{ACPI_RSC_MOVE_GPIO_RES,
+	 ACPI_RS_OFFSET(data.pin_group_function.resource_source_label.
+			string_ptr),
+	 AML_OFFSET(pin_group_function.res_source_label_offset),
+	 0},
+
+	/* Vendor Data */
+
+	{ACPI_RSC_COUNT_GPIO_VEN,
+	 ACPI_RS_OFFSET(data.pin_group_function.vendor_length),
+	 AML_OFFSET(pin_group_function.vendor_length),
+	 1},
+
+	{ACPI_RSC_MOVE_GPIO_RES,
+	 ACPI_RS_OFFSET(data.pin_group_function.vendor_data),
+	 AML_OFFSET(pin_group_function.vendor_offset),
+	 0},
+};
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index 946e1e2..bf5d19e 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -355,6 +355,7 @@ const u8 acpi_gbl_resource_aml_sizes[] = {
 	ACPI_AML_SIZE_LARGE(struct aml_resource_common_serialbus),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_config),
 	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_group),
+	ACPI_AML_SIZE_LARGE(struct aml_resource_pin_group_function),
 };
 
 const u8 acpi_gbl_resource_aml_serial_bus_sizes[] = {
@@ -409,6 +410,7 @@ static const u8 acpi_gbl_resource_types[] = {
 	ACPI_VARIABLE_LENGTH,	/* 0E *serial_bus */
 	ACPI_VARIABLE_LENGTH,	/* 0F pin_config */
 	ACPI_VARIABLE_LENGTH,	/* 10 pin_group */
+	ACPI_VARIABLE_LENGTH,	/* 11 pin_group_function */
 };
 
 /*******************************************************************************
diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
index d29841b..b4b9e57 100644
--- a/include/acpi/acrestyp.h
+++ b/include/acpi/acrestyp.h
@@ -591,6 +591,17 @@ struct acpi_resource_pin_group {
 	u8 *vendor_data;
 };
 
+struct acpi_resource_pin_group_function {
+	u8 revision_id;
+	u8 producer_consumer;	/* For values, see Producer/Consumer above */
+	u8 sharable;		/* For values, see Interrupt Attributes above */
+	u16 function_number;
+	u16 vendor_length;
+	struct acpi_resource_source resource_source;
+	struct acpi_resource_label resource_source_label;
+	u8 *vendor_data;
+};
+
 /* ACPI_RESOURCE_TYPEs */
 
 #define ACPI_RESOURCE_TYPE_IRQ                  0
@@ -616,7 +627,8 @@ struct acpi_resource_pin_group {
 #define ACPI_RESOURCE_TYPE_PIN_FUNCTION         20	/* ACPI 6.2 */
 #define ACPI_RESOURCE_TYPE_PIN_CONFIG           21	/* ACPI 6.2 */
 #define ACPI_RESOURCE_TYPE_PIN_GROUP            22	/* ACPI 6.2 */
-#define ACPI_RESOURCE_TYPE_MAX                  22
+#define ACPI_RESOURCE_TYPE_PIN_GROUP_FUNCTION   23	/* ACPI 6.2 */
+#define ACPI_RESOURCE_TYPE_MAX                  23
 
 /* Master union for resource descriptors */
 
@@ -647,6 +659,7 @@ union acpi_resource_data {
 	struct acpi_resource_pin_function pin_function;
 	struct acpi_resource_pin_config pin_config;
 	struct acpi_resource_pin_group pin_group;
+	struct acpi_resource_pin_group_function pin_group_function;
 
 	/* Common fields */
 
-- 
2.7.4

