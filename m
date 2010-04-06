From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/12] ACPI: EC: Allow multibyte access to EC
Date: Tue, 06 Apr 2010 03:06:12 -0400
Message-ID: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42502 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab0DFHGa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:30 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G00IHP12P35P5@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:26 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=14667

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exprep.c |   12 ++++++++++++
 drivers/acpi/ec.c            |   35 +++++++++--------------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index edf62bf..a610ebe 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -468,6 +468,18 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 
 		acpi_ut_add_reference(obj_desc->field.region_obj);
 
+		/* allow full data read from EC address space */
+		if (obj_desc->field.region_obj->region.space_id ==
+			ACPI_ADR_SPACE_EC) {
+			if (obj_desc->common_field.bit_length > 8)
+				obj_desc->common_field.access_bit_width =
+				ACPI_ROUND_UP(obj_desc->common_field.
+							bit_length, 8);
+				obj_desc->common_field.access_byte_width =
+				ACPI_DIV_8(obj_desc->common_field.
+							access_bit_width);
+		}
+
 		ACPI_DEBUG_PRINT((ACPI_DB_BFIELD,
 				  "RegionField: BitOff %X, Off %X, Gran %X, Region %p\n",
 				  obj_desc->field.start_field_bit_offset,
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 1ac28c6..7208a69 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -628,12 +628,12 @@ static u32 acpi_ec_gpe_handler(void *data)
 
 static acpi_status
 acpi_ec_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, u64 *value,
+		      u32 bits, u64 *value64,
 		      void *handler_context, void *region_context)
 {
 	struct acpi_ec *ec = handler_context;
-	int result = 0, i;
-	u8 temp = 0;
+	int result = 0, i, bytes = bits / 8;
+	u8 *value = (u8 *)value64;
 
 	if ((address > 0xFF) || !value || !handler_context)
 		return AE_BAD_PARAMETER;
@@ -641,32 +641,15 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
 	if (function != ACPI_READ && function != ACPI_WRITE)
 		return AE_BAD_PARAMETER;
 
-	if (bits != 8 && acpi_strict)
-		return AE_BAD_PARAMETER;
-
-	if (EC_FLAGS_MSI)
+	if (EC_FLAGS_MSI || bits > 8)
 		acpi_ec_burst_enable(ec);
 
-	if (function == ACPI_READ) {
-		result = acpi_ec_read(ec, address, &temp);
-		*value = temp;
-	} else {
-		temp = 0xff & (*value);
-		result = acpi_ec_write(ec, address, temp);
-	}
-
-	for (i = 8; unlikely(bits - i > 0); i += 8) {
-		++address;
-		if (function == ACPI_READ) {
-			result = acpi_ec_read(ec, address, &temp);
-			(*value) |= ((u64)temp) << i;
-		} else {
-			temp = 0xff & ((*value) >> i);
-			result = acpi_ec_write(ec, address, temp);
-		}
-	}
+	for (i = 0; i < bytes; ++i, ++address, ++value)
+		result = (function == ACPI_READ) ?
+			acpi_ec_read(ec, address, value) :
+			acpi_ec_write(ec, address, *value);
 
-	if (EC_FLAGS_MSI)
+	if (EC_FLAGS_MSI || bits > 8)
 		acpi_ec_burst_disable(ec);
 
 	switch (result) {
-- 
1.6.0.6

