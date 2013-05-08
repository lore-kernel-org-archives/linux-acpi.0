From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPICA: Fix possible buffer overflow during a field unit read operation
Date: Wed,  8 May 2013 12:01:15 +0800
Message-ID: <ce8ab48589fa4dd3e5468b75228992ddc12646ae.1367912853.git.lv.zheng@intel.com>
References: <cover.1367813690.git.lv.zheng@intel.com> <cover.1367912853.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12279 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab3EHECA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 May 2013 00:02:00 -0400
In-Reply-To: <cover.1367912853.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, stable@vger.kernel.org, linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Can only happen under these conditions: 1) The DSDT version is 1,
meaning integers are 32-bits.  2) The field is between 33 and 64
bits long.
It applies cleanly back to ACPICA 20100806+ (Linux v2.6.37+).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/acpica/exfldio.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ec7f569..c84ee95 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -720,7 +720,19 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 
 	if ((obj_desc->common_field.start_field_bit_offset == 0) &&
 	    (obj_desc->common_field.bit_length == access_bit_width)) {
-		status = acpi_ex_field_datum_io(obj_desc, 0, buffer, ACPI_READ);
+		if (buffer_length >= sizeof(u64)) {
+			status =
+			    acpi_ex_field_datum_io(obj_desc, 0, buffer,
+						   ACPI_READ);
+		} else {
+			/* Use raw_datum (u64) to handle buffers < 64 bits */
+
+			status =
+			    acpi_ex_field_datum_io(obj_desc, 0, &raw_datum,
+						   ACPI_READ);
+			ACPI_MEMCPY(buffer, &raw_datum, buffer_length);
+		}
+
 		return_ACPI_STATUS(status);
 	}
 
-- 
1.7.10

