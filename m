From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA release 20100806 linuxized patches
Date: Wed, 11 Aug 2010 10:42:35 +0800
Message-ID: <1281494555.2372.21.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6INNdQMn71h5udvvjFA0"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52175 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758030Ab0HKCme (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Aug 2010 22:42:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>


--=-6INNdQMn71h5udvvjFA0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Len,

ACPICA release 20100806 linuxized patches attached.
Build and tested OK on 32 and 64 bit machines.
Applied cleanly on top of Linus' tree(f5fc216).

Note that patch 3 includes Linux OSL _OSI code
change(drivers/acpi/osl.c). See
https://patchwork.kernel.org/patch/118729/

[PATCH 1/4] ACPICA: Fix acpi_os_read_pci_configuration prototype
[PATCH 2/4] ACPICA: Revert "Revert "Enable multi-byte EC transfers
[PATCH 3/4] ACPICA/ACPI: Add new host interfaces for _OSI support
[PATCH 4/4] ACPICA: Update version to 20100806

Thanks,
Lin Ming

--=-6INNdQMn71h5udvvjFA0
Content-Type: application/mbox; name="acpica-v20100806.mbox"
Content-Disposition: attachment; filename="acpica-v20100806.mbox"
Content-Transfer-Encoding: 7bit

>From 764c582617fc3f262f9be6f625cbb4a987728736 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 6 Aug 2010 08:57:53 +0800
Subject: [PATCH 1/4] ACPICA: Fix acpi_os_read_pci_configuration prototype

Prototype in acpiosxf.h had the output value pointer as a (u32 *).
Should be a (u64 *).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/exregion.c |    4 +---
 drivers/acpi/osl.c             |    8 +++++---
 include/acpi/acpiosxf.h        |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 8819d2a..de17e10 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -353,7 +353,6 @@ acpi_ex_pci_config_space_handler(u32 function,
 	acpi_status status = AE_OK;
 	struct acpi_pci_id *pci_id;
 	u16 pci_register;
-	u32 value32;
 
 	ACPI_FUNCTION_TRACE(ex_pci_config_space_handler);
 
@@ -381,8 +380,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	case ACPI_READ:
 
 		status = acpi_os_read_pci_configuration(pci_id, pci_register,
-							&value32, bit_width);
-		*value = value32;
+							value, bit_width);
 		break;
 
 	case ACPI_WRITE:
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index f14d3f2..3fd6747 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -548,9 +548,10 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
-			       u32 *value, u32 width)
+			       u64 *value, u32 width)
 {
 	int result, size;
+	u32 value32;
 
 	if (!value)
 		return AE_BAD_PARAMETER;
@@ -571,7 +572,8 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 	result = raw_pci_read(pci_id->segment, pci_id->bus,
 				PCI_DEVFN(pci_id->device, pci_id->function),
-				reg, size, value);
+				reg, size, &value32);
+	*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -627,7 +629,7 @@ static void acpi_os_derive_pci_id_2(acpi_handle rhandle,	/* upper bound  */
 		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
 					  &temp);
 		if (ACPI_SUCCESS(status)) {
-			u32 val;
+			u64 val;
 			pci_id->device = ACPI_HIWORD(ACPI_LODWORD(temp));
 			pci_id->function = ACPI_LOWORD(ACPI_LODWORD(temp));
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 29bf945..5e22577 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -223,7 +223,7 @@ acpi_os_write_memory(acpi_physical_address address, u32 value, u32 width);
  */
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id,
-			       u32 reg, u32 *value, u32 width);
+			       u32 reg, u64 *value, u32 width);
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,

>From ff81c55973711e8c64d9433eab6fc19c4a2a4ad9 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Fri, 6 Aug 2010 09:09:33 +0800
Subject: [PATCH 2/4] ACPICA: Revert "Revert "Enable multi-byte EC transfers

This reverts commit f23b9c7(http://git.moblin.org/cgit.cgi/acpica/commit/?id=f23b9c7)
The problem with this change was determined to be a problem with
the FreeBSD host OSL (OS services layer), not with this patch
itself. Therefore, re-introducing this change into the main ACPICA
code. See ACPICA bugzilla 863.

http://www.acpica.org/bugzilla/show_bug.cgi?id=863

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acobject.h |    2 +-
 drivers/acpi/acpica/exfldio.c  |   75 ++++++++++++++++++++++++++-------------
 drivers/acpi/acpica/exprep.c   |   42 ++++++++++------------
 3 files changed, 70 insertions(+), 49 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 54857fa..bdbfaf2 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -248,7 +248,7 @@ ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_NOTIFY_INFO};
 	u32                             base_byte_offset;   /* Byte offset within containing object */\
 	u32                             value;              /* Value to store into the Bank or Index register */\
 	u8                              start_field_bit_offset;/* Bit offset within first field datum (0-63) */\
-	u8                              access_bit_width;	/* Read/Write size in bits (8-64) */
+
 
 struct acpi_object_field_common {	/* COMMON FIELD (for BUFFER, REGION, BANK, and INDEX fields) */
 	ACPI_OBJECT_COMMON_HEADER ACPI_COMMON_FIELD_INFO union acpi_operand_object *region_obj;	/* Parent Operation Region object (REGION/BANK fields only) */
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 0472173..38293fd 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -119,8 +119,8 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	}
 
 	/*
-	 * Exit now for SMBus or IPMI address space, it has a non-linear address space
-	 * and the request cannot be directly validated
+	 * Exit now for SMBus or IPMI address space, it has a non-linear
+	 * address space and the request cannot be directly validated
 	 */
 	if (rgn_desc->region.space_id == ACPI_ADR_SPACE_SMBUS ||
 	    rgn_desc->region.space_id == ACPI_ADR_SPACE_IPMI) {
@@ -147,8 +147,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 	 * (Region length is specified in bytes)
 	 */
 	if (rgn_desc->region.length <
-	    (obj_desc->common_field.base_byte_offset +
-	     field_datum_byte_offset +
+	    (obj_desc->common_field.base_byte_offset + field_datum_byte_offset +
 	     obj_desc->common_field.access_byte_width)) {
 		if (acpi_gbl_enable_interpreter_slack) {
 			/*
@@ -680,6 +679,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
+	u32 access_bit_width;
 	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_extract_from_field);
@@ -694,16 +694,36 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 		return_ACPI_STATUS(AE_BUFFER_OVERFLOW);
 	}
+
 	ACPI_MEMSET(buffer, 0, buffer_length);
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
+	/* Handle the simple case here */
+
+	if ((obj_desc->common_field.start_field_bit_offset == 0) &&
+	    (obj_desc->common_field.bit_length == access_bit_width)) {
+		status = acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
+		return_ACPI_STATUS(status);
+	}
+
+/* TBD: Move to common setup code */
+
+	/* Field algorithm is limited to sizeof(u64), truncate if needed */
+
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+		access_bit_width = sizeof(u64) * 8;
+	}
 
 	/* Compute the number of datums (access width data items) */
 
-	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+	datum_count =
+	    ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
+			     access_bit_width);
+
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Priming read from the field */
@@ -738,12 +758,11 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
-		     obj_desc->common_field.start_field_bit_offset) <
+		if (access_bit_width -
+		    obj_desc->common_field.start_field_bit_offset <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum |=
-			    raw_datum << (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum << (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		}
@@ -765,8 +784,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 	/* Mask off any extra bits in the last datum */
 
-	buffer_tail_bits = obj_desc->common_field.bit_length %
-	    obj_desc->common_field.access_bit_width;
+	buffer_tail_bits = obj_desc->common_field.bit_length % access_bit_width;
 	if (buffer_tail_bits) {
 		merged_datum &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
@@ -798,6 +816,7 @@ acpi_status
 acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 			  void *buffer, u32 buffer_length)
 {
+	void *new_buffer;
 	acpi_status status;
 	u64 mask;
 	u64 width_mask;
@@ -808,9 +827,9 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	u32 buffer_tail_bits;
 	u32 datum_count;
 	u32 field_datum_count;
-	u32 i;
+	u32 access_bit_width;
 	u32 required_length;
-	void *new_buffer;
+	u32 i;
 
 	ACPI_FUNCTION_TRACE(ex_insert_into_field);
 
@@ -844,17 +863,24 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		buffer_length = required_length;
 	}
 
+/* TBD: Move to common setup code */
+
+	/* Algo is limited to sizeof(u64), so cut the access_byte_width */
+	if (obj_desc->common_field.access_byte_width > sizeof(u64)) {
+		obj_desc->common_field.access_byte_width = sizeof(u64);
+	}
+
+	access_bit_width = ACPI_MUL_8(obj_desc->common_field.access_byte_width);
+
 	/*
 	 * Create the bitmasks used for bit insertion.
 	 * Note: This if/else is used to bypass compiler differences with the
 	 * shift operator
 	 */
-	if (obj_desc->common_field.access_bit_width == ACPI_INTEGER_BIT_SIZE) {
+	if (access_bit_width == ACPI_INTEGER_BIT_SIZE) {
 		width_mask = ACPI_UINT64_MAX;
 	} else {
-		width_mask =
-		    ACPI_MASK_BITS_ABOVE(obj_desc->common_field.
-					 access_bit_width);
+		width_mask = ACPI_MASK_BITS_ABOVE(access_bit_width);
 	}
 
 	mask = width_mask &
@@ -863,12 +889,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
-				       obj_desc->common_field.access_bit_width);
+				       access_bit_width);
 
 	field_datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length +
 					     obj_desc->common_field.
 					     start_field_bit_offset,
-					     obj_desc->common_field.
 					     access_bit_width);
 
 	/* Get initial Datum from the input buffer */
@@ -905,12 +930,11 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		 * This avoids the differences in behavior between different compilers
 		 * concerning shift values larger than the target data width.
 		 */
-		if ((obj_desc->common_field.access_bit_width -
+		if ((access_bit_width -
 		     obj_desc->common_field.start_field_bit_offset) <
 		    ACPI_INTEGER_BIT_SIZE) {
 			merged_datum =
-			    raw_datum >> (obj_desc->common_field.
-					  access_bit_width -
+			    raw_datum >> (access_bit_width -
 					  obj_desc->common_field.
 					  start_field_bit_offset);
 		} else {
@@ -929,6 +953,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 		ACPI_MEMCPY(&raw_datum, ((char *)buffer) + buffer_offset,
 			    ACPI_MIN(obj_desc->common_field.access_byte_width,
 				     buffer_length - buffer_offset));
+
 		merged_datum |=
 		    raw_datum << obj_desc->common_field.start_field_bit_offset;
 	}
@@ -937,7 +962,7 @@ acpi_ex_insert_into_field(union acpi_operand_object *obj_desc,
 
 	buffer_tail_bits = (obj_desc->common_field.bit_length +
 			    obj_desc->common_field.start_field_bit_offset) %
-	    obj_desc->common_field.access_bit_width;
+	    access_bit_width;
 	if (buffer_tail_bits) {
 		mask &= ACPI_MASK_BITS_ABOVE(buffer_tail_bits);
 	}
diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 98a331d..5366a48 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -355,12 +355,10 @@ acpi_ex_prep_common_field_object(union acpi_operand_object *obj_desc,
 		return_ACPI_STATUS(AE_AML_OPERAND_VALUE);
 	}
 
-	/* Setup width (access granularity) fields */
+	/* Setup width (access granularity) fields (values are: 1, 2, 4, 8) */
 
 	obj_desc->common_field.access_byte_width = (u8)
-	    ACPI_DIV_8(access_bit_width);	/* 1,  2,  4,  8 */
-
-	obj_desc->common_field.access_bit_width = (u8) access_bit_width;
+	    ACPI_DIV_8(access_bit_width);
 
 	/*
 	 * base_byte_offset is the address of the start of the field within the
@@ -405,8 +403,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 {
 	union acpi_operand_object *obj_desc;
 	union acpi_operand_object *second_desc = NULL;
-	u32 type;
 	acpi_status status;
+	u32 access_byte_width;
+	u32 type;
 
 	ACPI_FUNCTION_TRACE(ex_prep_field_value);
 
@@ -421,8 +420,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		type = acpi_ns_get_type(info->region_node);
 		if (type != ACPI_TYPE_REGION) {
 			ACPI_ERROR((AE_INFO,
-				    "Needed Region, found type 0x%X (%s)",
-				    type, acpi_ut_get_type_name(type)));
+				    "Needed Region, found type 0x%X (%s)", type,
+				    acpi_ut_get_type_name(type)));
 
 			return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
 		}
@@ -438,7 +437,8 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 	/* Initialize areas of the object that are common to all fields */
 
 	obj_desc->common_field.node = info->field_node;
-	status = acpi_ex_prep_common_field_object(obj_desc, info->field_flags,
+	status = acpi_ex_prep_common_field_object(obj_desc,
+						  info->field_flags,
 						  info->attribute,
 						  info->field_bit_position,
 						  info->field_bit_length);
@@ -455,24 +455,20 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 		obj_desc->field.region_obj =
 		    acpi_ns_get_attached_object(info->region_node);
 
-		/* An additional reference for the container */
+		/* Allow full data read from EC address space */
+
+		if ((obj_desc->field.region_obj->region.space_id ==
+		     ACPI_ADR_SPACE_EC)
+		    && (obj_desc->common_field.bit_length > 8)) {
+			access_byte_width =
+			    ACPI_ROUND_BITS_UP_TO_BYTES(obj_desc->common_field.
+							bit_length);
 
-		acpi_ut_add_reference(obj_desc->field.region_obj);
+			/* Maximum byte width supported is 255 */
 
-		/* allow full data read from EC address space */
-		if (obj_desc->field.region_obj->region.space_id ==
-			ACPI_ADR_SPACE_EC) {
-			if (obj_desc->common_field.bit_length > 8) {
-				unsigned width =
-					ACPI_ROUND_BITS_UP_TO_BYTES(
-					obj_desc->common_field.bit_length);
-				// access_bit_width is u8, don't overflow it
-				if (width > 8)
-					width = 8;
+			if (access_byte_width < 256) {
 				obj_desc->common_field.access_byte_width =
-							width;
-				obj_desc->common_field.access_bit_width =
-							8 * width;
+				    (u8)access_byte_width;
 			}
 		}
 

>From 2021225e2e938f08c0139f3ddf59cc3202ab5a29 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Fri, 6 Aug 2010 09:35:51 +0800
Subject: [PATCH 3/4] ACPICA/ACPI: Add new host interfaces for _OSI support

Adds install/remove interfaces so that the host can dynamically
alter the global _OSI table. Also adds support for _OSI handlers.
Additional support: new debugger command (osi), and test support in
the acpiexec utility. Adds new file, utilities/utosi.c.
ACPICA bugzilla 836.

The Linux OSL _OSI code is also changed.
acpi_osi_setup can't call acpi_install/remove_interface because ACPICA
is not initialized yet at this early time.
So we just save the osi string in acpi_osi_setup and will handle it
later in a new function acpi_osi_setup_late.

http://www.acpica.org/bugzilla/show_bug.cgi?id=836

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com
---
 drivers/acpi/acpica/Makefile   |    3 +-
 drivers/acpi/acpica/acdebug.h  |    2 +
 drivers/acpi/acpica/acglobal.h |    6 +
 drivers/acpi/acpica/aclocal.h  |    5 +
 drivers/acpi/acpica/acutils.h  |   17 ++-
 drivers/acpi/acpica/uteval.c   |  147 ----------------
 drivers/acpi/acpica/utglobal.c |    2 +
 drivers/acpi/acpica/utinit.c   |    4 +
 drivers/acpi/acpica/utmutex.c  |    8 +
 drivers/acpi/acpica/utosi.c    |  379 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/utxface.c  |  125 +++++++++++++-
 drivers/acpi/osl.c             |   88 +++++-----
 include/acpi/acpiosxf.h        |    3 -
 include/acpi/acpixf.h          |    6 +
 include/acpi/actypes.h         |    3 +
 15 files changed, 602 insertions(+), 196 deletions(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index d93cc06..262903e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -44,4 +44,5 @@ acpi-y += tbxface.o tbinstal.o tbutils.o tbfind.o tbfadt.o tbxfroot.o
 
 acpi-y += utalloc.o utdebug.o uteval.o utinit.o utmisc.o utxface.o \
 		utcopy.o utdelete.o utglobal.o utmath.o utobject.o \
-		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o
+		utstate.o utmutex.o utobject.o utresrc.o utlock.o utids.o \
+		utosi.o
diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
index 48faf3e..72e9d5e 100644
--- a/drivers/acpi/acpica/acdebug.h
+++ b/drivers/acpi/acpica/acdebug.h
@@ -105,6 +105,8 @@ void acpi_db_set_method_data(char *type_arg, char *index_arg, char *value_arg);
 acpi_status
 acpi_db_display_objects(char *obj_type_arg, char *display_count_arg);
 
+void acpi_db_display_interfaces(char *action_arg, char *interface_name_arg);
+
 acpi_status acpi_db_find_name_in_namespace(char *name_arg);
 
 void acpi_db_set_scope(char *name);
diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 18e796f..ea2316d 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -187,6 +187,10 @@ ACPI_EXTERN u8 acpi_gbl_integer_bit_width;
 ACPI_EXTERN u8 acpi_gbl_integer_byte_width;
 ACPI_EXTERN u8 acpi_gbl_integer_nybble_width;
 
+/* Mutex for _OSI support */
+
+ACPI_EXTERN acpi_mutex acpi_gbl_osi_mutex;
+
 /* Reader/Writer lock is used for namespace walk and dynamic table unload */
 
 ACPI_EXTERN struct acpi_rw_lock acpi_gbl_namespace_rw_lock;
@@ -255,6 +259,7 @@ ACPI_EXTERN acpi_init_handler acpi_gbl_init_handler;
 ACPI_EXTERN acpi_tbl_handler acpi_gbl_table_handler;
 ACPI_EXTERN void *acpi_gbl_table_handler_context;
 ACPI_EXTERN struct acpi_walk_state *acpi_gbl_breakpoint_walk;
+ACPI_EXTERN acpi_interface_handler acpi_gbl_interface_handler;
 
 /* Owner ID support */
 
@@ -275,6 +280,7 @@ ACPI_EXTERN u8 acpi_gbl_acpi_hardware_present;
 ACPI_EXTERN u8 acpi_gbl_events_initialized;
 ACPI_EXTERN u8 acpi_gbl_system_awake_and_running;
 ACPI_EXTERN u8 acpi_gbl_osi_data;
+ACPI_EXTERN struct acpi_interface_info *acpi_gbl_supported_interfaces;
 
 #ifndef DEFINE_ACPI_GLOBALS
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 1ee0bcf..e9cedae 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -913,9 +913,14 @@ struct acpi_bit_register_info {
 
 struct acpi_interface_info {
 	char *name;
+	struct acpi_interface_info *next;
+	u8 flags;
 	u8 value;
 };
 
+#define ACPI_OSI_INVALID                0x01
+#define ACPI_OSI_DYNAMIC                0x02
+
 struct acpi_port_info {
 	char *name;
 	u16 start;
diff --git a/drivers/acpi/acpica/acutils.h b/drivers/acpi/acpica/acutils.h
index 35df755..78e0121 100644
--- a/drivers/acpi/acpica/acutils.h
+++ b/drivers/acpi/acpica/acutils.h
@@ -312,8 +312,6 @@ void acpi_ut_delete_internal_object_list(union acpi_operand_object **obj_list);
 /*
  * uteval - object evaluation
  */
-acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
-
 acpi_status
 acpi_ut_evaluate_object(struct acpi_namespace_node *prefix_node,
 			char *path,
@@ -395,6 +393,21 @@ acpi_status
 acpi_ut_get_object_size(union acpi_operand_object *obj, acpi_size * obj_length);
 
 /*
+ * utosi - Support for the _OSI predefined control method
+ */
+acpi_status acpi_ut_initialize_interfaces(void);
+
+void acpi_ut_interface_terminate(void);
+
+acpi_status acpi_ut_install_interface(acpi_string interface_name);
+
+acpi_status acpi_ut_remove_interface(acpi_string interface_name);
+
+struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name);
+
+acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state);
+
+/*
  * utstate - Generic state creation/cache routines
  */
 void
diff --git a/drivers/acpi/acpica/uteval.c b/drivers/acpi/acpica/uteval.c
index 6dfdeb6..22f59ef 100644
--- a/drivers/acpi/acpica/uteval.c
+++ b/drivers/acpi/acpica/uteval.c
@@ -48,153 +48,6 @@
 #define _COMPONENT          ACPI_UTILITIES
 ACPI_MODULE_NAME("uteval")
 
-/*
- * Strings supported by the _OSI predefined (internal) method.
- *
- * March 2009: Removed "Linux" as this host no longer wants to respond true
- * for this string. Basically, the only safe OS strings are windows-related
- * and in many or most cases represent the only test path within the
- * BIOS-provided ASL code.
- *
- * The second element of each entry is used to track the newest version of
- * Windows that the BIOS has requested.
- */
-static struct acpi_interface_info acpi_interfaces_supported[] = {
-	/* Operating System Vendor Strings */
-
-	{"Windows 2000", ACPI_OSI_WIN_2000},	/* Windows 2000 */
-	{"Windows 2001", ACPI_OSI_WIN_XP},	/* Windows XP */
-	{"Windows 2001 SP1", ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
-	{"Windows 2001.1", ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
-	{"Windows 2001 SP2", ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
-	{"Windows 2001.1 SP1", ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
-	{"Windows 2006", ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
-	{"Windows 2006.1", ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
-	{"Windows 2006 SP1", ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
-	{"Windows 2009", ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
-
-	/* Feature Group Strings */
-
-	{"Extended Address Space Descriptor", 0}
-
-	/*
-	 * All "optional" feature group strings (features that are implemented
-	 * by the host) should be implemented in the host version of
-	 * acpi_os_validate_interface and should not be added here.
-	 */
-};
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_ut_osi_implementation
- *
- * PARAMETERS:  walk_state          - Current walk state
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Implementation of the _OSI predefined control method
- *
- ******************************************************************************/
-
-acpi_status acpi_ut_osi_implementation(struct acpi_walk_state *walk_state)
-{
-	acpi_status status;
-	union acpi_operand_object *string_desc;
-	union acpi_operand_object *return_desc;
-	u32 return_value;
-	u32 i;
-
-	ACPI_FUNCTION_TRACE(ut_osi_implementation);
-
-	/* Validate the string input argument */
-
-	string_desc = walk_state->arguments[0].object;
-	if (!string_desc || (string_desc->common.type != ACPI_TYPE_STRING)) {
-		return_ACPI_STATUS(AE_TYPE);
-	}
-
-	/* Create a return object */
-
-	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
-	if (!return_desc) {
-		return_ACPI_STATUS(AE_NO_MEMORY);
-	}
-
-	/* Default return value is 0, NOT SUPPORTED */
-
-	return_value = 0;
-
-	/* Compare input string to static table of supported interfaces */
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(string_desc->string.pointer,
-				 acpi_interfaces_supported[i].name)) {
-			/*
-			 * The interface is supported.
-			 * Update the osi_data if necessary. We keep track of the latest
-			 * version of Windows that has been requested by the BIOS.
-			 */
-			if (acpi_interfaces_supported[i].value >
-			    acpi_gbl_osi_data) {
-				acpi_gbl_osi_data =
-				    acpi_interfaces_supported[i].value;
-			}
-
-			return_value = ACPI_UINT32_MAX;
-			goto exit;
-		}
-	}
-
-	/*
-	 * Did not match the string in the static table, call the host OSL to
-	 * check for a match with one of the optional strings (such as
-	 * "Module Device", "3.0 Thermal Model", etc.)
-	 */
-	status = acpi_os_validate_interface(string_desc->string.pointer);
-	if (ACPI_SUCCESS(status)) {
-
-		/* The interface is supported */
-
-		return_value = ACPI_UINT32_MAX;
-	}
-
-exit:
-	ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INFO,
-		"ACPI: BIOS _OSI(%s) is %ssupported\n",
-		string_desc->string.pointer, return_value == 0 ? "not " : ""));
-
-	/* Complete the return value */
-
-	return_desc->integer.value = return_value;
-	walk_state->return_desc = return_desc;
-	return_ACPI_STATUS (AE_OK);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_osi_invalidate
- *
- * PARAMETERS:  interface_string
- *
- * RETURN:      Status
- *
- * DESCRIPTION: invalidate string in pre-defiend _OSI string list
- *
- ******************************************************************************/
-
-acpi_status acpi_osi_invalidate(char *interface)
-{
-	int i;
-
-	for (i = 0; i < ACPI_ARRAY_LENGTH(acpi_interfaces_supported); i++) {
-		if (!ACPI_STRCMP(interface, acpi_interfaces_supported[i].name)) {
-			*acpi_interfaces_supported[i].name = '\0';
-			return AE_OK;
-		}
-	}
-	return AE_NOT_FOUND;
-}
-
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_evaluate_object
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index 0558747..45f6334 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -774,6 +774,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_exception_handler = NULL;
 	acpi_gbl_init_handler = NULL;
 	acpi_gbl_table_handler = NULL;
+	acpi_gbl_interface_handler = NULL;
 
 	/* Global Lock support */
 
@@ -800,6 +801,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
 	acpi_gbl_osi_data = 0;
+	acpi_gbl_osi_mutex = NULL;
 
 	/* Hardware oriented */
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index a39c93d..c1b1c80 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -117,6 +117,10 @@ void acpi_ut_subsystem_shutdown(void)
 	/* Close the acpi_event Handling */
 
 	acpi_ev_terminate();
+
+	/* Delete any dynamic _OSI interfaces */
+
+	acpi_ut_interface_terminate();
 #endif
 
 	/* Close the Namespace */
diff --git a/drivers/acpi/acpica/utmutex.c b/drivers/acpi/acpica/utmutex.c
index 058b3df..ac7efa7 100644
--- a/drivers/acpi/acpica/utmutex.c
+++ b/drivers/acpi/acpica/utmutex.c
@@ -86,6 +86,12 @@ acpi_status acpi_ut_mutex_initialize(void)
 	spin_lock_init(acpi_gbl_gpe_lock);
 	spin_lock_init(acpi_gbl_hardware_lock);
 
+	/* Mutex for _OSI support */
+	status = acpi_os_create_mutex(&acpi_gbl_osi_mutex);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Create the reader/writer lock for namespace access */
 
 	status = acpi_ut_create_rw_lock(&acpi_gbl_namespace_rw_lock);
@@ -117,6 +123,8 @@ void acpi_ut_mutex_terminate(void)
 		acpi_ut_delete_mutex(i);
 	}
 
+	acpi_os_delete_mutex(acpi_gbl_osi_mutex);
+
 	/* Delete the spinlocks */
 
 	acpi_os_delete_lock(acpi_gbl_gpe_lock);
diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
new file mode 100644
index 0000000..0a37950
--- /dev/null
+++ b/drivers/acpi/acpica/utosi.c
@@ -0,0 +1,379 @@
+/******************************************************************************
+ *
+ * Module Name: utosi - Support for the _OSI predefined control method
+ *
+ *****************************************************************************/
+
+/*
+ * Copyright (C) 2000 - 2010, Intel Corp.
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
+#define _COMPONENT          ACPI_UTILITIES
+ACPI_MODULE_NAME("utosi")
+
+/*
+ * Strings supported by the _OSI predefined control method (which is
+ * implemented internally within this module.)
+ *
+ * March 2009: Removed "Linux" as this host no longer wants to respond true
+ * for this string. Basically, the only safe OS strings are windows-related
+ * and in many or most cases represent the only test path within the
+ * BIOS-provided ASL code.
+ *
+ * The last element of each entry is used to track the newest version of
+ * Windows that the BIOS has requested.
+ */
+static struct acpi_interface_info acpi_default_supported_interfaces[] = {
+	/* Operating System Vendor Strings */
+
+	{"Windows 2000", NULL, 0, ACPI_OSI_WIN_2000},	/* Windows 2000 */
+	{"Windows 2001", NULL, 0, ACPI_OSI_WIN_XP},	/* Windows XP */
+	{"Windows 2001 SP1", NULL, 0, ACPI_OSI_WIN_XP_SP1},	/* Windows XP SP1 */
+	{"Windows 2001.1", NULL, 0, ACPI_OSI_WINSRV_2003},	/* Windows Server 2003 */
+	{"Windows 2001 SP2", NULL, 0, ACPI_OSI_WIN_XP_SP2},	/* Windows XP SP2 */
+	{"Windows 2001.1 SP1", NULL, 0, ACPI_OSI_WINSRV_2003_SP1},	/* Windows Server 2003 SP1 - Added 03/2006 */
+	{"Windows 2006", NULL, 0, ACPI_OSI_WIN_VISTA},	/* Windows Vista - Added 03/2006 */
+	{"Windows 2006.1", NULL, 0, ACPI_OSI_WINSRV_2008},	/* Windows Server 2008 - Added 09/2009 */
+	{"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},	/* Windows Vista SP1 - Added 09/2009 */
+	{"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},	/* Windows 7 and Server 2008 R2 - Added 09/2009 */
+
+	/* Feature Group Strings */
+
+	{"Extended Address Space Descriptor", NULL, 0, 0}
+
+	/*
+	 * All "optional" feature group strings (features that are implemented
+	 * by the host) should be dynamically added by the host via
+	 * acpi_install_interface and should not be manually added here.
+	 *
+	 * Examples of optional feature group strings:
+	 *
+	 * "Module Device"
+	 * "Processor Device"
+	 * "3.0 Thermal Model"
+	 * "3.0 _SCP Extensions"
+	 * "Processor Aggregator Device"
+	 */
+};
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_initialize_interfaces
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Initialize the global _OSI supported interfaces list
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_initialize_interfaces(void)
+{
+	u32 i;
+
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	acpi_gbl_supported_interfaces = acpi_default_supported_interfaces;
+
+	/* Link the static list of supported interfaces */
+
+	for (i = 0;
+	     i < (ACPI_ARRAY_LENGTH(acpi_default_supported_interfaces) - 1);
+	     i++) {
+		acpi_default_supported_interfaces[i].next =
+		    &acpi_default_supported_interfaces[(acpi_size) i + 1];
+	}
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_interface_terminate
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Delete all interfaces in the global list. Sets
+ *              acpi_gbl_supported_interfaces to NULL.
+ *
+ ******************************************************************************/
+
+void acpi_ut_interface_terminate(void)
+{
+	struct acpi_interface_info *next_interface;
+
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+	next_interface = acpi_gbl_supported_interfaces;
+
+	while (next_interface) {
+		acpi_gbl_supported_interfaces = next_interface->next;
+
+		/* Only interfaces added at runtime can be freed */
+
+		if (next_interface->flags & ACPI_OSI_DYNAMIC) {
+			ACPI_FREE(next_interface->name);
+			ACPI_FREE(next_interface);
+		}
+
+		next_interface = acpi_gbl_supported_interfaces;
+	}
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_install_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to install
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install the interface into the global interface list.
+ *              Caller MUST hold acpi_gbl_osi_mutex
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_install_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *interface_info;
+
+	/* Allocate info block and space for the name string */
+
+	interface_info =
+	    ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_interface_info));
+	if (!interface_info) {
+		return (AE_NO_MEMORY);
+	}
+
+	interface_info->name =
+	    ACPI_ALLOCATE_ZEROED(ACPI_STRLEN(interface_name) + 1);
+	if (!interface_info->name) {
+		ACPI_FREE(interface_info);
+		return (AE_NO_MEMORY);
+	}
+
+	/* Initialize new info and insert at the head of the global list */
+
+	ACPI_STRCPY(interface_info->name, interface_name);
+	interface_info->flags = ACPI_OSI_DYNAMIC;
+	interface_info->next = acpi_gbl_supported_interfaces;
+
+	acpi_gbl_supported_interfaces = interface_info;
+	return (AE_OK);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_remove_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to remove
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove the interface from the global interface list.
+ *              Caller MUST hold acpi_gbl_osi_mutex
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_remove_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *previous_interface;
+	struct acpi_interface_info *next_interface;
+
+	previous_interface = next_interface = acpi_gbl_supported_interfaces;
+	while (next_interface) {
+		if (!ACPI_STRCMP(interface_name, next_interface->name)) {
+
+			/* Found: name is in either the static list or was added at runtime */
+
+			if (next_interface->flags & ACPI_OSI_DYNAMIC) {
+
+				/* Interface was added dynamically, remove and free it */
+
+				if (previous_interface == next_interface) {
+					acpi_gbl_supported_interfaces =
+					    next_interface->next;
+				} else {
+					previous_interface->next =
+					    next_interface->next;
+				}
+
+				ACPI_FREE(next_interface->name);
+				ACPI_FREE(next_interface);
+			} else {
+				/*
+				 * Interface is in static list. If marked invalid, then it
+				 * does not actually exist. Else, mark it invalid.
+				 */
+				if (next_interface->flags & ACPI_OSI_INVALID) {
+					return (AE_NOT_EXIST);
+				}
+
+				next_interface->flags |= ACPI_OSI_INVALID;
+			}
+
+			return (AE_OK);
+		}
+
+		previous_interface = next_interface;
+		next_interface = next_interface->next;
+	}
+
+	/* Interface was not found */
+
+	return (AE_NOT_EXIST);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_get_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to find
+ *
+ * RETURN:      struct acpi_interface_info if found. NULL if not found.
+ *
+ * DESCRIPTION: Search for the specified interface name in the global list.
+ *              Caller MUST hold acpi_gbl_osi_mutex
+ *
+ ******************************************************************************/
+
+struct acpi_interface_info *acpi_ut_get_interface(acpi_string interface_name)
+{
+	struct acpi_interface_info *next_interface;
+
+	next_interface = acpi_gbl_supported_interfaces;
+	while (next_interface) {
+		if (!ACPI_STRCMP(interface_name, next_interface->name)) {
+			return (next_interface);
+		}
+
+		next_interface = next_interface->next;
+	}
+
+	return (NULL);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ut_osi_implementation
+ *
+ * PARAMETERS:  walk_state          - Current walk state
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Implementation of the _OSI predefined control method. When
+ *              an invocation of _OSI is encountered in the system AML,
+ *              control is transferred to this function.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_ut_osi_implementation(struct acpi_walk_state * walk_state)
+{
+	union acpi_operand_object *string_desc;
+	union acpi_operand_object *return_desc;
+	struct acpi_interface_info *interface_info;
+	acpi_interface_handler interface_handler;
+	u32 return_value;
+
+	ACPI_FUNCTION_TRACE(ut_osi_implementation);
+
+	/* Validate the string input argument (from the AML caller) */
+
+	string_desc = walk_state->arguments[0].object;
+	if (!string_desc || (string_desc->common.type != ACPI_TYPE_STRING)) {
+		return_ACPI_STATUS(AE_TYPE);
+	}
+
+	/* Create a return object */
+
+	return_desc = acpi_ut_create_internal_object(ACPI_TYPE_INTEGER);
+	if (!return_desc) {
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	/* Default return value is 0, NOT SUPPORTED */
+
+	return_value = 0;
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+
+	/* Lookup the interface in the global _OSI list */
+
+	interface_info = acpi_ut_get_interface(string_desc->string.pointer);
+	if (interface_info && !(interface_info->flags & ACPI_OSI_INVALID)) {
+		/*
+		 * The interface is supported.
+		 * Update the osi_data if necessary. We keep track of the latest
+		 * version of Windows that has been requested by the BIOS.
+		 */
+		if (interface_info->value > acpi_gbl_osi_data) {
+			acpi_gbl_osi_data = interface_info->value;
+		}
+
+		return_value = ACPI_UINT32_MAX;
+	}
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+
+	/*
+	 * Invoke an optional _OSI interface handler. The host OS may wish
+	 * to do some interface-specific handling. For example, warn about
+	 * certain interfaces or override the true/false support value.
+	 */
+	interface_handler = acpi_gbl_interface_handler;
+	if (interface_handler) {
+		return_value =
+		    interface_handler(string_desc->string.pointer,
+				      return_value);
+	}
+
+	ACPI_DEBUG_PRINT_RAW((ACPI_DB_INFO,
+			      "ACPI: BIOS _OSI(\"%s\") is %ssupported\n",
+			      string_desc->string.pointer,
+			      return_value == 0 ? "not " : ""));
+
+	/* Complete the return object */
+
+	return_desc->integer.value = return_value;
+	walk_state->return_desc = return_desc;
+	return_ACPI_STATUS(AE_OK);
+}
diff --git a/drivers/acpi/acpica/utxface.c b/drivers/acpi/acpica/utxface.c
index 7f8cefc..c2da90f 100644
--- a/drivers/acpi/acpica/utxface.c
+++ b/drivers/acpi/acpica/utxface.c
@@ -110,6 +110,15 @@ acpi_status __init acpi_initialize_subsystem(void)
 		return_ACPI_STATUS(status);
 	}
 
+	/* Initialize the global OSI interfaces list with the static names */
+
+	status = acpi_ut_initialize_interfaces();
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During OSI interfaces initialization"));
+		return_ACPI_STATUS(status);
+	}
+
 	/* If configured, initialize the AML debugger */
 
 	ACPI_DEBUGGER_EXEC(status = acpi_db_initialize());
@@ -506,6 +515,7 @@ acpi_install_initialization_handler(acpi_init_handler handler, u32 function)
 
 ACPI_EXPORT_SYMBOL(acpi_install_initialization_handler)
 #endif				/*  ACPI_FUTURE_USAGE  */
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_purge_cached_objects
@@ -529,4 +539,117 @@ acpi_status acpi_purge_cached_objects(void)
 }
 
 ACPI_EXPORT_SYMBOL(acpi_purge_cached_objects)
-#endif
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_install_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to install
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install an _OSI interface to the global list
+ *
+ ****************************************************************************/
+acpi_status acpi_install_interface(acpi_string interface_name)
+{
+	acpi_status status;
+	struct acpi_interface_info *interface_info;
+
+	/* Parameter validation */
+
+	if (!interface_name || (ACPI_STRLEN(interface_name) == 0)) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+
+	/* Check if the interface name is already in the global list */
+
+	interface_info = acpi_ut_get_interface(interface_name);
+	if (interface_info) {
+		/*
+		 * The interface already exists in the list. This is OK if the
+		 * interface has been marked invalid -- just clear the bit.
+		 */
+		if (interface_info->flags & ACPI_OSI_INVALID) {
+			interface_info->flags &= ~ACPI_OSI_INVALID;
+			status = AE_OK;
+		} else {
+			status = AE_ALREADY_EXISTS;
+		}
+	} else {
+		/* New interface name, install into the global list */
+
+		status = acpi_ut_install_interface(interface_name);
+	}
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_interface)
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_remove_interface
+ *
+ * PARAMETERS:  interface_name      - The interface to remove
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Remove an _OSI interface from the global list
+ *
+ ****************************************************************************/
+acpi_status acpi_remove_interface(acpi_string interface_name)
+{
+	acpi_status status;
+
+	/* Parameter validation */
+
+	if (!interface_name || (ACPI_STRLEN(interface_name) == 0)) {
+		return (AE_BAD_PARAMETER);
+	}
+
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+
+	status = acpi_ut_remove_interface(interface_name);
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_remove_interface)
+
+/*****************************************************************************
+ *
+ * FUNCTION:    acpi_install_interface_handler
+ *
+ * PARAMETERS:  Handler             - The _OSI interface handler to install
+ *                                    NULL means "remove existing handler"
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for the predefined _OSI ACPI method.
+ *              invoked during execution of the internal implementation of
+ *              _OSI. A NULL handler simply removes any existing handler.
+ *
+ ****************************************************************************/
+acpi_status acpi_install_interface_handler(acpi_interface_handler handler)
+{
+	acpi_status status = AE_OK;
+
+	(void)acpi_os_acquire_mutex(acpi_gbl_osi_mutex, ACPI_WAIT_FOREVER);
+
+	if (handler && acpi_gbl_interface_handler) {
+		status = AE_ALREADY_EXISTS;
+	} else {
+		acpi_gbl_interface_handler = handler;
+	}
+
+	acpi_os_release_mutex(acpi_gbl_osi_mutex);
+	return (status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_interface_handler)
+#endif				/* !ACPI_ASL_COMPILER */
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3fd6747..af109c7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -96,7 +96,9 @@ static LIST_HEAD(resource_list_head);
 static DEFINE_SPINLOCK(acpi_res_lock);
 
 #define	OSI_STRING_LENGTH_MAX 64	/* arbitrary */
-static char osi_additional_string[OSI_STRING_LENGTH_MAX];
+static char osi_setup_string[OSI_STRING_LENGTH_MAX];
+
+static void __init acpi_osi_setup_late(void);
 
 /*
  * The story of _OSI(Linux)
@@ -138,6 +140,20 @@ static struct osi_linux {
 	unsigned int	known:1;
 } osi_linux = { 0, 0, 0, 0};
 
+static u32 acpi_osi_handler(acpi_string interface, u32 supported)
+{
+	if (!strcmp("Linux", interface)) {
+
+		printk(KERN_NOTICE PREFIX
+			"BIOS _OSI(Linux) query %s%s\n",
+			osi_linux.enable ? "honored" : "ignored",
+			osi_linux.cmdline ? " via cmdline" :
+			osi_linux.dmi ? " via DMI" : "");
+	}
+
+	return supported;
+}
+
 static void __init acpi_request_region (struct acpi_generic_address *addr,
 	unsigned int length, char *desc)
 {
@@ -199,6 +215,8 @@ acpi_status acpi_os_initialize1(void)
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
 	BUG_ON(!kacpi_hotplug_wq);
+	acpi_install_interface_handler(acpi_osi_handler);
+	acpi_osi_setup_late();
 	return AE_OK;
 }
 
@@ -980,6 +998,12 @@ static void __init set_osi_linux(unsigned int enable)
 		printk(KERN_NOTICE PREFIX "%sed _OSI(Linux)\n",
 			enable ? "Add": "Delet");
 	}
+
+	if (osi_linux.enable)
+		acpi_install_interface("Linux");
+	else
+		acpi_remove_interface("Linux");
+
 	return;
 }
 
@@ -1014,21 +1038,33 @@ void __init acpi_dmi_osi_linux(int enable, const struct dmi_system_id *d)
  * string starting with '!' disables that string
  * otherwise string is added to list, augmenting built-in strings
  */
-int __init acpi_osi_setup(char *str)
+static void __init acpi_osi_setup_late(void)
 {
-	if (str == NULL || *str == '\0') {
-		printk(KERN_INFO PREFIX "_OSI method disabled\n");
-		acpi_gbl_create_osi_method = FALSE;
-	} else if (!strcmp("!Linux", str)) {
+	char *str = osi_setup_string;
+
+	if (*str == '\0')
+		return;
+
+	if (!strcmp("!Linux", str)) {
 		acpi_cmdline_osi_linux(0);	/* !enable */
 	} else if (*str == '!') {
-		if (acpi_osi_invalidate(++str) == AE_OK)
+		if (acpi_remove_interface(++str) == AE_OK)
 			printk(KERN_INFO PREFIX "Deleted _OSI(%s)\n", str);
 	} else if (!strcmp("Linux", str)) {
 		acpi_cmdline_osi_linux(1);	/* enable */
-	} else if (*osi_additional_string == '\0') {
-		strncpy(osi_additional_string, str, OSI_STRING_LENGTH_MAX);
-		printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+	} else {
+		if (acpi_install_interface(str) == AE_OK)
+			printk(KERN_INFO PREFIX "Added _OSI(%s)\n", str);
+	}
+}
+
+int __init acpi_osi_setup(char *str)
+{
+	if (str == NULL || *str == '\0') {
+		printk(KERN_INFO PREFIX "_OSI method disabled\n");
+		acpi_gbl_create_osi_method = FALSE;
+	} else {
+		strncpy(osi_setup_string, str, OSI_STRING_LENGTH_MAX);
 	}
 
 	return 1;
@@ -1285,38 +1321,6 @@ acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
 	return (AE_OK);
 }
 
-/******************************************************************************
- *
- * FUNCTION:    acpi_os_validate_interface
- *
- * PARAMETERS:  interface           - Requested interface to be validated
- *
- * RETURN:      AE_OK if interface is supported, AE_SUPPORT otherwise
- *
- * DESCRIPTION: Match an interface string to the interfaces supported by the
- *              host. Strings originate from an AML call to the _OSI method.
- *
- *****************************************************************************/
-
-acpi_status
-acpi_os_validate_interface (char *interface)
-{
-	if (!strncmp(osi_additional_string, interface, OSI_STRING_LENGTH_MAX))
-		return AE_OK;
-	if (!strcmp("Linux", interface)) {
-
-		printk(KERN_NOTICE PREFIX
-			"BIOS _OSI(Linux) query %s%s\n",
-			osi_linux.enable ? "honored" : "ignored",
-			osi_linux.cmdline ? " via cmdline" :
-			osi_linux.dmi ? " via DMI" : "");
-
-		if (osi_linux.enable)
-			return AE_OK;
-	}
-	return AE_SUPPORT;
-}
-
 static inline int acpi_res_list_add(struct acpi_res_list *res)
 {
 	struct acpi_res_list *res_list_elem;
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 5e22577..c29b0af 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -239,9 +239,6 @@ acpi_os_derive_pci_id(acpi_handle device,
 /*
  * Miscellaneous
  */
-acpi_status acpi_os_validate_interface(char *interface);
-acpi_status acpi_osi_invalidate(char* interface);
-
 acpi_status
 acpi_os_validate_address(u8 space_id, acpi_physical_address address,
 			 acpi_size length, char *name);
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 81d4f3d..55164c7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -105,6 +105,10 @@ const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
 
+acpi_status acpi_install_interface(acpi_string interface_name);
+
+acpi_status acpi_remove_interface(acpi_string interface_name);
+
 /*
  * ACPI Memory management
  */
@@ -263,6 +267,8 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
 #endif
 
+acpi_status acpi_install_interface_handler(acpi_interface_handler handler);
+
 /*
  * Event interfaces
  */
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 5db8f47..332d076 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -950,6 +950,9 @@ acpi_status(*acpi_walk_callback) (acpi_handle object,
 				  u32 nesting_level,
 				  void *context, void **return_value);
 
+typedef
+u32 (*acpi_interface_handler) (acpi_string interface_name, u32 supported);
+
 /* Interrupt handler return values */
 
 #define ACPI_INTERRUPT_NOT_HANDLED      0x00

>From 18496c5e0a37bb00139c84f38892d3937b0ddce1 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Wed, 11 Aug 2010 10:14:35 +0800
Subject: [PATCH 4/4] ACPICA: Update version to 20100806

Version 20100806.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 55164c7..8a2d2cf 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100702
+#define ACPI_CA_VERSION                 0x20100806
 
 #include "actypes.h"
 #include "actbl.h"


--=-6INNdQMn71h5udvvjFA0--

